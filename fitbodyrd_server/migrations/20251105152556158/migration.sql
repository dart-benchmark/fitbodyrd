BEGIN;

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
    "bmi" double precision,
    "bodyGoal" text NOT NULL,
    "activityLevel" text NOT NULL,
    "daysPerWeekExercise" bigint NOT NULL,
    "timePerExerciseSessionMinutes" bigint NOT NULL,
    "experienceLevel" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);


--
-- MIGRATION VERSION FOR fitbodyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fitbodyrd', '20251105152556158', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251105152556158', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
