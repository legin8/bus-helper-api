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
    "isSchoolRun" BOOLEAN NOT NULL DEFAULT false,
    "locations" TEXT NOT NULL,

    PRIMARY KEY ("title", "agencyCode", "isSchoolRun"),
    CONSTRAINT "Route_agencyCode_fkey" FOREIGN KEY ("agencyCode") REFERENCES "Agency" ("code") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Service" (
    "code" TEXT NOT NULL,
    "agencyCode" TEXT NOT NULL,
    "isSchoolRun" BOOLEAN NOT NULL DEFAULT false,
    "routeTitle" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    PRIMARY KEY ("code", "agencyCode", "isSchoolRun"),
    CONSTRAINT "Service_routeTitle_agencyCode_isSchoolRun_fkey" FOREIGN KEY ("routeTitle", "agencyCode", "isSchoolRun") REFERENCES "Route" ("title", "agencyCode", "isSchoolRun") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Trip" (
    "serviceCode" TEXT NOT NULL,
    "agencyCode" TEXT NOT NULL,
    "isSchoolRun" BOOLEAN NOT NULL,
    "code" INTEGER NOT NULL,
    "startTime" DATETIME NOT NULL,

    PRIMARY KEY ("serviceCode", "code", "agencyCode", "isSchoolRun"),
    CONSTRAINT "Trip_serviceCode_agencyCode_isSchoolRun_fkey" FOREIGN KEY ("serviceCode", "agencyCode", "isSchoolRun") REFERENCES "Service" ("code", "agencyCode", "isSchoolRun") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "TripRun" (
    "serviceCode" TEXT NOT NULL,
    "tripCode" INTEGER NOT NULL,
    "agencyCode" TEXT NOT NULL,
    "isSchoolRun" BOOLEAN NOT NULL,
    "runCode" TEXT NOT NULL,
    "runVersion" INTEGER NOT NULL,
    "runOrder" INTEGER NOT NULL,

    PRIMARY KEY ("serviceCode", "tripCode", "agencyCode", "isSchoolRun", "runCode", "runVersion", "runOrder"),
    CONSTRAINT "TripRun_serviceCode_tripCode_agencyCode_isSchoolRun_fkey" FOREIGN KEY ("serviceCode", "tripCode", "agencyCode", "isSchoolRun") REFERENCES "Trip" ("serviceCode", "code", "agencyCode", "isSchoolRun") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TripRun_runCode_runVersion_runOrder_fkey" FOREIGN KEY ("runCode", "runVersion", "runOrder") REFERENCES "Run" ("code", "version", "order") ON DELETE RESTRICT ON UPDATE CASCADE
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

    PRIMARY KEY ("runCode", "version", "order", "stopCode"),
    CONSTRAINT "RunStop_runCode_version_order_fkey" FOREIGN KEY ("runCode", "version", "order") REFERENCES "Run" ("code", "version", "order") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "RunStop_stopCode_fkey" FOREIGN KEY ("stopCode") REFERENCES "Stop" ("code") ON DELETE RESTRICT ON UPDATE CASCADE
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
