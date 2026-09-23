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
    "userInfoId" bigint NOT NULL,
    "fullName" text NOT NULL,
    "email" text NOT NULL,
    "birthDate" timestamp without time zone NOT NULL,
    "sex" text NOT NULL,
    "weightKgs" double precision NOT NULL,
    "heightMs" double precision NOT NULL,
    "bodyGoal" text NOT NULL,
    "activityLevel" text NOT NULL,
    "daysPerWeekExercise" bigint NOT NULL,
    "timePerExerciseSessionMinutes" bigint NOT NULL,
    "experienceLevel" text NOT NULL,
    "authMethod" text DEFAULT 'google'::text,
    "hasEquipment" boolean NOT NULL DEFAULT true,
    "dietaryRestrictions" text NOT NULL DEFAULT 'none'::text,
    "deletedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_profiles"
    ADD CONSTRAINT "user_profiles_fk_0"
    FOREIGN KEY("userInfoId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR fitbodyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fitbodyrd', '20251118153839154', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251118153839154', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20240520102713718', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240520102713718', "timestamp" = now();


COMMIT;
