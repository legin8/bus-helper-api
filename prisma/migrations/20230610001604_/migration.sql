-- CreateTable
CREATE TABLE "User" (
    "userId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "Agency" (
    "code" TEXT NOT NULL PRIMARY KEY,
    "region" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "phone" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Route" (
    "title" TEXT NOT NULL,
    "agencyCode" TEXT NOT NULL,
    "locations" TEXT NOT NULL,
    "key" INTEGER NOT NULL,

    PRIMARY KEY ("title", "agencyCode"),
    CONSTRAINT "Route_agencyCode_fkey" FOREIGN KEY ("agencyCode") REFERENCES "Agency" ("code") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Service" (
    "code" TEXT NOT NULL,
    "agencyCode" TEXT NOT NULL,
    "routeTitle" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "key" INTEGER NOT NULL,

    PRIMARY KEY ("code", "agencyCode"),
    CONSTRAINT "Service_routeTitle_agencyCode_fkey" FOREIGN KEY ("routeTitle", "agencyCode") REFERENCES "Route" ("title", "agencyCode") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Trip" (
    "serviceCode" TEXT NOT NULL,
    "id" INTEGER NOT NULL,
    "agencyCode" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    PRIMARY KEY ("serviceCode", "id", "agencyCode"),
    CONSTRAINT "Trip_serviceCode_agencyCode_fkey" FOREIGN KEY ("serviceCode", "agencyCode") REFERENCES "Service" ("code", "agencyCode") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Times" (
    "serviceCode" TEXT NOT NULL,
    "tripId" INTEGER NOT NULL,
    "agencyCode" TEXT NOT NULL,
    "stop" INTEGER NOT NULL,
    "time" TEXT NOT NULL,
    "stopsCode" TEXT NOT NULL,

    PRIMARY KEY ("serviceCode", "tripId", "agencyCode", "stop"),
    CONSTRAINT "Times_serviceCode_tripId_agencyCode_fkey" FOREIGN KEY ("serviceCode", "tripId", "agencyCode") REFERENCES "Trip" ("serviceCode", "id", "agencyCode") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "TimesStops" (
    "serviceCode" TEXT NOT NULL,
    "tripId" INTEGER NOT NULL,
    "stopsCode" TEXT NOT NULL,
    "agencyCode" TEXT NOT NULL,
    "timeStop" INTEGER NOT NULL,

    PRIMARY KEY ("serviceCode", "tripId", "stopsCode", "agencyCode"),
    CONSTRAINT "TimesStops_serviceCode_tripId_agencyCode_timeStop_fkey" FOREIGN KEY ("serviceCode", "tripId", "agencyCode", "timeStop") REFERENCES "Times" ("serviceCode", "tripId", "agencyCode", "stop") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TimesStops_stopsCode_fkey" FOREIGN KEY ("stopsCode") REFERENCES "Stops" ("code") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Stops" (
    "code" TEXT NOT NULL PRIMARY KEY,
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "stopAlias" TEXT
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Agency_code_key" ON "Agency"("code");
