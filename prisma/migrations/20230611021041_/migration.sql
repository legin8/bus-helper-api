/*
  Warnings:

  - You are about to drop the column `key` on the `Service` table. All the data in the column will be lost.
  - The primary key for the `Route` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Service" (
    "code" TEXT NOT NULL,
    "agencyCode" TEXT NOT NULL,
    "isSchoolRun" BOOLEAN NOT NULL DEFAULT false,
    "routeTitle" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    PRIMARY KEY ("code", "agencyCode"),
    CONSTRAINT "Service_routeTitle_agencyCode_isSchoolRun_fkey" FOREIGN KEY ("routeTitle", "agencyCode", "isSchoolRun") REFERENCES "Route" ("title", "agencyCode", "isSchoolRun") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Service" ("agencyCode", "code", "name", "routeTitle") SELECT "agencyCode", "code", "name", "routeTitle" FROM "Service";
DROP TABLE "Service";
ALTER TABLE "new_Service" RENAME TO "Service";
CREATE TABLE "new_Route" (
    "title" TEXT NOT NULL,
    "agencyCode" TEXT NOT NULL,
    "locations" TEXT NOT NULL,
    "isSchoolRun" BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY ("title", "agencyCode", "isSchoolRun"),
    CONSTRAINT "Route_agencyCode_fkey" FOREIGN KEY ("agencyCode") REFERENCES "Agency" ("code") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Route" ("agencyCode", "locations", "title") SELECT "agencyCode", "locations", "title" FROM "Route";
DROP TABLE "Route";
ALTER TABLE "new_Route" RENAME TO "Route";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
