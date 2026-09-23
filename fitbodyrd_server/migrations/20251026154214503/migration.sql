BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "exercises" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "exercises" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "description" text,
    "category" json NOT NULL,
    "muscleGroup" json NOT NULL,
    "difficulty" text NOT NULL,
    "requiresEquipment" boolean NOT NULL DEFAULT false,
    "equipmentNeeded" text,
    "videoUrl" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "unique_exercise_name" ON "exercises" USING btree ("name");


--
-- MIGRATION VERSION FOR fitbodyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fitbodyrd', '20251026154214503', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251026154214503', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
