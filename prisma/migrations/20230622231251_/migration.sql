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
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "agencyCode" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "isSchoolRun" BOOLEAN NOT NULL DEFAULT false,
    "locations" TEXT NOT NULL,
    CONSTRAINT "Route_agencyCode_fkey" FOREIGN KEY ("agencyCode") REFERENCES "Agency" ("code") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Service" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "routeId" INTEGER NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    CONSTRAINT "Service_routeId_fkey" FOREIGN KEY ("routeId") REFERENCES "Route" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Trip" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "serviceId" INTEGER NOT NULL,
    "startTime" DATETIME NOT NULL,
    CONSTRAINT "Trip_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "Service" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "TripDay" (
    "tripId" INTEGER NOT NULL,
    "dayCode" TEXT NOT NULL,
    CONSTRAINT "TripDay_tripId_fkey" FOREIGN KEY ("tripId") REFERENCES "Trip" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TripDay_dayCode_fkey" FOREIGN KEY ("dayCode") REFERENCES "Day" ("code") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Day" (
    "code" TEXT NOT NULL PRIMARY KEY
);

-- CreateTable
CREATE TABLE "TripSequence" (
    "tripId" INTEGER NOT NULL,
    "serviceCode" TEXT NOT NULL,
    "version" INTEGER NOT NULL,
    CONSTRAINT "TripSequence_tripId_fkey" FOREIGN KEY ("tripId") REFERENCES "Trip" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TripSequence_serviceCode_version_fkey" FOREIGN KEY ("serviceCode", "version") REFERENCES "Sequence" ("serviceCode", "version") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Sequence" (
    "serviceCode" TEXT NOT NULL,
    "version" INTEGER NOT NULL,

    PRIMARY KEY ("serviceCode", "version")
);

-- CreateTable
CREATE TABLE "SequenceStop" (
    "serviceCode" TEXT NOT NULL,
    "version" INTEGER NOT NULL,
    "order" INTEGER NOT NULL,
    "timeIncrement" INTEGER NOT NULL,
    "stopCode" TEXT NOT NULL,
    CONSTRAINT "SequenceStop_serviceCode_version_fkey" FOREIGN KEY ("serviceCode", "version") REFERENCES "Sequence" ("serviceCode", "version") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "SequenceStop_stopCode_fkey" FOREIGN KEY ("stopCode") REFERENCES "Stop" ("code") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Stop" (
    "code" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "lat" TEXT NOT NULL,
    "long" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Agency_code_key" ON "Agency"("code");

-- CreateIndex
CREATE UNIQUE INDEX "TripDay_tripId_dayCode_key" ON "TripDay"("tripId", "dayCode");

-- CreateIndex
CREATE UNIQUE INDEX "TripSequence_tripId_key" ON "TripSequence"("tripId");

-- CreateIndex
CREATE UNIQUE INDEX "SequenceStop_serviceCode_version_order_timeIncrement_stopCode_key" ON "SequenceStop"("serviceCode", "version", "order", "timeIncrement", "stopCode");
