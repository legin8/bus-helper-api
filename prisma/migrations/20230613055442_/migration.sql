/*
  Warnings:

  - The primary key for the `TripRun` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `RunStop` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - Added the required column `agencyCode` to the `TripRun` table without a default value. This is not possible if the table is not empty.
  - Added the required column `runOrder` to the `TripRun` table without a default value. This is not possible if the table is not empty.
  - Added the required column `runVersion` to the `TripRun` table without a default value. This is not possible if the table is not empty.
  - Added the required column `serviceCode` to the `TripRun` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_TripRun" (
    "serviceCode" TEXT NOT NULL,
    "tripCode" INTEGER NOT NULL,
    "agencyCode" TEXT NOT NULL,
    "runCode" TEXT NOT NULL,
    "runVersion" INTEGER NOT NULL,
    "runOrder" INTEGER NOT NULL,

    PRIMARY KEY ("serviceCode", "tripCode", "agencyCode", "runCode", "runVersion", "runOrder"),
    CONSTRAINT "TripRun_serviceCode_tripCode_agencyCode_fkey" FOREIGN KEY ("serviceCode", "tripCode", "agencyCode") REFERENCES "Trip" ("serviceCode", "code", "agencyCode") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TripRun_runCode_runVersion_runOrder_fkey" FOREIGN KEY ("runCode", "runVersion", "runOrder") REFERENCES "Run" ("code", "version", "order") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_TripRun" ("runCode", "tripCode") SELECT "runCode", "tripCode" FROM "TripRun";
DROP TABLE "TripRun";
ALTER TABLE "new_TripRun" RENAME TO "TripRun";
CREATE TABLE "new_RunStop" (
    "runCode" TEXT NOT NULL,
    "version" INTEGER NOT NULL,
    "order" INTEGER NOT NULL,
    "stopCode" TEXT NOT NULL,

    PRIMARY KEY ("runCode", "version", "order", "stopCode"),
    CONSTRAINT "RunStop_runCode_version_order_fkey" FOREIGN KEY ("runCode", "version", "order") REFERENCES "Run" ("code", "version", "order") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "RunStop_stopCode_fkey" FOREIGN KEY ("stopCode") REFERENCES "Stop" ("code") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_RunStop" ("order", "runCode", "stopCode", "version") SELECT "order", "runCode", "stopCode", "version" FROM "RunStop";
DROP TABLE "RunStop";
ALTER TABLE "new_RunStop" RENAME TO "RunStop";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
