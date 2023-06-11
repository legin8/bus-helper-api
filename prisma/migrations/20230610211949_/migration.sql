/*
  Warnings:

  - You are about to drop the column `key` on the `Route` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Route" (
    "title" TEXT NOT NULL,
    "agencyCode" TEXT NOT NULL,
    "locations" TEXT NOT NULL,

    PRIMARY KEY ("title", "agencyCode"),
    CONSTRAINT "Route_agencyCode_fkey" FOREIGN KEY ("agencyCode") REFERENCES "Agency" ("code") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Route" ("agencyCode", "locations", "title") SELECT "agencyCode", "locations", "title" FROM "Route";
DROP TABLE "Route";
ALTER TABLE "new_Route" RENAME TO "Route";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
