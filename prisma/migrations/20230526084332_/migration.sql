-- CreateTable
CREATE TABLE "Agency" (
    "code" TEXT NOT NULL PRIMARY KEY,
    "region" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "phone" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Route" (
    "title" TEXT NOT NULL PRIMARY KEY,
    "locations" TEXT NOT NULL,
    "key" INTEGER NOT NULL,
    "agencyCode" TEXT NOT NULL,
    CONSTRAINT "Route_agencyCode_fkey" FOREIGN KEY ("agencyCode") REFERENCES "Agency" ("code") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Service" (
    "code" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "routeTitle" TEXT NOT NULL,
    "key" INTEGER NOT NULL,
    CONSTRAINT "Service_routeTitle_fkey" FOREIGN KEY ("routeTitle") REFERENCES "Route" ("title") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Trip" (
    "serviceCode" TEXT NOT NULL,
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,

    PRIMARY KEY ("serviceCode", "id"),
    CONSTRAINT "Trip_serviceCode_fkey" FOREIGN KEY ("serviceCode") REFERENCES "Service" ("code") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Times" (
    "serviceCode" TEXT NOT NULL,
    "tripId" INTEGER NOT NULL,
    "time" TEXT NOT NULL,

    PRIMARY KEY ("serviceCode", "tripId"),
    CONSTRAINT "Times_tripId_serviceCode_fkey" FOREIGN KEY ("tripId", "serviceCode") REFERENCES "Trip" ("id", "serviceCode") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "TimeStop" (
    "serviceCode" TEXT NOT NULL,
    "tripId" INTEGER NOT NULL,
    "stopsCode" TEXT NOT NULL,

    PRIMARY KEY ("serviceCode", "tripId", "stopsCode"),
    CONSTRAINT "TimeStop_serviceCode_tripId_fkey" FOREIGN KEY ("serviceCode", "tripId") REFERENCES "Times" ("serviceCode", "tripId") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TimeStop_stopsCode_fkey" FOREIGN KEY ("stopsCode") REFERENCES "Stops" ("code") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Stops" (
    "code" TEXT NOT NULL PRIMARY KEY,
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "stopAlias" TEXT
);

-- CreateIndex
CREATE UNIQUE INDEX "Agency_code_key" ON "Agency"("code");

-- CreateIndex
CREATE UNIQUE INDEX "Route_title_key" ON "Route"("title");

-- CreateIndex
CREATE UNIQUE INDEX "Route_key_key" ON "Route"("key");

-- CreateIndex
CREATE UNIQUE INDEX "Service_code_key" ON "Service"("code");
