-- CreateTable
CREATE TABLE "TripDay" (
    "serviceCode" TEXT NOT NULL,
    "agencyCode" TEXT NOT NULL,
    "isSchoolRun" BOOLEAN NOT NULL,
    "tripCode" INTEGER NOT NULL,
    "dayCode" TEXT NOT NULL,

    PRIMARY KEY ("serviceCode", "agencyCode", "isSchoolRun", "tripCode", "dayCode"),
    CONSTRAINT "TripDay_serviceCode_agencyCode_isSchoolRun_tripCode_fkey" FOREIGN KEY ("serviceCode", "agencyCode", "isSchoolRun", "tripCode") REFERENCES "Trip" ("serviceCode", "agencyCode", "isSchoolRun", "code") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TripDay_dayCode_fkey" FOREIGN KEY ("dayCode") REFERENCES "Day" ("code") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Day" (
    "code" TEXT NOT NULL PRIMARY KEY
);
