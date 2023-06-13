/*
  Warnings:

  - You are about to drop the `Stops` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Stops";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "Stop" (
    "code" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "long" TEXT NOT NULL,
    "lat" TEXT NOT NULL
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_TimesStops" (
    "serviceCode" TEXT NOT NULL,
    "tripId" INTEGER NOT NULL,
    "stopsCode" TEXT NOT NULL,
    "agencyCode" TEXT NOT NULL,
    "timeStop" INTEGER NOT NULL,

    PRIMARY KEY ("serviceCode", "tripId", "stopsCode", "agencyCode"),
    CONSTRAINT "TimesStops_serviceCode_tripId_agencyCode_timeStop_fkey" FOREIGN KEY ("serviceCode", "tripId", "agencyCode", "timeStop") REFERENCES "Times" ("serviceCode", "tripId", "agencyCode", "stop") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TimesStops_stopsCode_fkey" FOREIGN KEY ("stopsCode") REFERENCES "Stop" ("code") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_TimesStops" ("agencyCode", "serviceCode", "stopsCode", "timeStop", "tripId") SELECT "agencyCode", "serviceCode", "stopsCode", "timeStop", "tripId" FROM "TimesStops";
DROP TABLE "TimesStops";
ALTER TABLE "new_TimesStops" RENAME TO "TimesStops";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
