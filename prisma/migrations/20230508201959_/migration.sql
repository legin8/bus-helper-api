-- CreateTable
CREATE TABLE "Route" (
    "number" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "key" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "Service" (
    "code" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "routeNumber" TEXT NOT NULL,
    "key" INTEGER NOT NULL,
    CONSTRAINT "Service_routeNumber_fkey" FOREIGN KEY ("routeNumber") REFERENCES "Route" ("number") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Route_number_key" ON "Route"("number");

-- CreateIndex
CREATE UNIQUE INDEX "Route_key_key" ON "Route"("key");

-- CreateIndex
CREATE UNIQUE INDEX "Service_code_key" ON "Service"("code");
