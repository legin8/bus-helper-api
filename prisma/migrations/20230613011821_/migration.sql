/*
  Warnings:

  - You are about to drop the `Times` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `TimesStops` table. If the table is not empty, all the data it contains will be lost.
  - The primary key for the `Trip` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Trip` table. All the data in the column will be lost.
  - Added the required column `code` to the `Trip` table without a default value. This is not possible if the table is not empty.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Times";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "TimesStops";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "TripRun" (
    "tripCode" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "runCode" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "Run" (
    "code" TEXT NOT NULL,
    "version" INTEGER NOT NULL,
    "order" INTEGER NOT NULL,
    "timeIncrement" INTEGER NOT NULL,

    PRIMARY KEY ("code", "version", "order")
);

-- CreateTable
CREATE TABLE "RunStop" (
    "runCode" TEXT NOT NULL,
    "version" INTEGER NOT NULL,
    "order" INTEGER NOT NULL,
    "stopCode" TEXT NOT NULL,

    PRIMARY KEY ("runCode", "stopCode"),
    CONSTRAINT "RunStop_runCode_version_order_fkey" FOREIGN KEY ("runCode", "version", "order") REFERENCES "Run" ("code", "version", "order") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "RunStop_stopCode_fkey" FOREIGN KEY ("stopCode") REFERENCES "Stop" ("code") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Trip" (
    "serviceCode" TEXT NOT NULL,
    "code" INTEGER NOT NULL,
    "agencyCode" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    PRIMARY KEY ("serviceCode", "code", "agencyCode"),
    CONSTRAINT "Trip_serviceCode_agencyCode_fkey" FOREIGN KEY ("serviceCode", "agencyCode") REFERENCES "Service" ("code", "agencyCode") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Trip" ("agencyCode", "name", "serviceCode") SELECT "agencyCode", "name", "serviceCode" FROM "Trip";
DROP TABLE "Trip";
ALTER TABLE "new_Trip" RENAME TO "Trip";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
