-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN_USER', 'BASIC_USER');

-- CreateEnum
CREATE TYPE "Day" AS ENUM ('DAILY', 'WD', 'WE', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN');

-- CreateTable
CREATE TABLE "User" (
    "userId" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'BASIC_USER',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "User_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "Agency" (
    "code" TEXT NOT NULL,
    "region" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "phone" TEXT NOT NULL,

    CONSTRAINT "Agency_pkey" PRIMARY KEY ("code")
);

-- CreateTable
CREATE TABLE "Route" (
    "id" SERIAL NOT NULL,
    "agencyCode" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "isSchoolRun" BOOLEAN NOT NULL DEFAULT false,
    "locations" TEXT NOT NULL,

    CONSTRAINT "Route_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Service" (
    "id" SERIAL NOT NULL,
    "routeId" INTEGER NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Service_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Trip" (
    "id" SERIAL NOT NULL,
    "serviceId" INTEGER NOT NULL,
    "startTime" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Trip_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TripDay" (
    "tripId" INTEGER NOT NULL,
    "day" "Day" NOT NULL
);

-- CreateTable
CREATE TABLE "TripSequence" (
    "tripId" INTEGER NOT NULL,
    "serviceCode" TEXT NOT NULL,
    "version" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "Sequence" (
    "serviceCode" TEXT NOT NULL,
    "version" INTEGER NOT NULL,

    CONSTRAINT "Sequence_pkey" PRIMARY KEY ("serviceCode","version")
);

-- CreateTable
CREATE TABLE "SequenceStop" (
    "serviceCode" TEXT NOT NULL,
    "version" INTEGER NOT NULL,
    "order" INTEGER NOT NULL,
    "timeIncrement" INTEGER NOT NULL,
    "stopCode" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Stop" (
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "lat" TEXT NOT NULL,
    "long" TEXT NOT NULL,

    CONSTRAINT "Stop_pkey" PRIMARY KEY ("code")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Agency_code_key" ON "Agency"("code");

-- CreateIndex
CREATE UNIQUE INDEX "TripDay_tripId_day_key" ON "TripDay"("tripId", "day");

-- CreateIndex
CREATE UNIQUE INDEX "TripSequence_tripId_key" ON "TripSequence"("tripId");

-- CreateIndex
CREATE UNIQUE INDEX "SequenceStop_serviceCode_version_order_timeIncrement_stopCo_key" ON "SequenceStop"("serviceCode", "version", "order", "timeIncrement", "stopCode");

-- AddForeignKey
ALTER TABLE "Route" ADD CONSTRAINT "Route_agencyCode_fkey" FOREIGN KEY ("agencyCode") REFERENCES "Agency"("code") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Service" ADD CONSTRAINT "Service_routeId_fkey" FOREIGN KEY ("routeId") REFERENCES "Route"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Trip" ADD CONSTRAINT "Trip_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "Service"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripDay" ADD CONSTRAINT "TripDay_tripId_fkey" FOREIGN KEY ("tripId") REFERENCES "Trip"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripSequence" ADD CONSTRAINT "TripSequence_tripId_fkey" FOREIGN KEY ("tripId") REFERENCES "Trip"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripSequence" ADD CONSTRAINT "TripSequence_serviceCode_version_fkey" FOREIGN KEY ("serviceCode", "version") REFERENCES "Sequence"("serviceCode", "version") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SequenceStop" ADD CONSTRAINT "SequenceStop_serviceCode_version_fkey" FOREIGN KEY ("serviceCode", "version") REFERENCES "Sequence"("serviceCode", "version") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SequenceStop" ADD CONSTRAINT "SequenceStop_stopCode_fkey" FOREIGN KEY ("stopCode") REFERENCES "Stop"("code") ON DELETE RESTRICT ON UPDATE CASCADE;
