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
    "category" text NOT NULL,
    "muscleGroup" text NOT NULL,
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
-- ACTION DROP TABLE
--
DROP TABLE "user_profiles" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_profiles" (
    "id" bigserial PRIMARY KEY,
    "birthDate" timestamp without time zone NOT NULL,
    "sex" text NOT NULL,
    "weight" double precision NOT NULL,
    "height" double precision NOT NULL,
    "bmi" double precision NOT NULL,
    "bodyGoal" text NOT NULL,
    "activityLevel" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);


--
-- MIGRATION VERSION FOR fitbodyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fitbodyrd', '20251006163722413', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251006163722413', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
