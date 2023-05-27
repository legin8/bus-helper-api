/*
  Warnings:

  - You are about to drop the `TimeStop` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `stopsCode` to the `Times` table without a default value. This is not possible if the table is not empty.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "TimeStop";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "TimesStops" (
    "serviceCode" TEXT NOT NULL,
    "tripId" INTEGER NOT NULL,
    "stopsCode" TEXT NOT NULL,

    PRIMARY KEY ("serviceCode", "tripId", "stopsCode"),
    CONSTRAINT "TimesStops_serviceCode_tripId_fkey" FOREIGN KEY ("serviceCode", "tripId") REFERENCES "Times" ("serviceCode", "tripId") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TimesStops_stopsCode_fkey" FOREIGN KEY ("stopsCode") REFERENCES "Stops" ("code") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Times" (
    "serviceCode" TEXT NOT NULL,
    "tripId" INTEGER NOT NULL,
    "time" TEXT NOT NULL,
    "stopsCode" TEXT NOT NULL,

    PRIMARY KEY ("serviceCode", "tripId"),
    CONSTRAINT "Times_tripId_serviceCode_fkey" FOREIGN KEY ("tripId", "serviceCode") REFERENCES "Trip" ("id", "serviceCode") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Times" ("serviceCode", "time", "tripId") SELECT "serviceCode", "time", "tripId" FROM "Times";
DROP TABLE "Times";
ALTER TABLE "new_Times" RENAME TO "Times";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
