BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "workout_exercises" (
    "id" bigserial PRIMARY KEY,
    "workoutSessionId" bigint NOT NULL,
    "exerciseId" bigint NOT NULL,
    "order" bigint NOT NULL,
    "sets" bigint NOT NULL,
    "reps" bigint NOT NULL,
    "restSeconds" bigint NOT NULL,
    "notes" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "workout_plans" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "name" text NOT NULL,
    "startDate" timestamp without time zone NOT NULL,
    "endDate" timestamp without time zone NOT NULL,
    "difficultyLevel" text NOT NULL,
    "status" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "workout_sessions" (
    "id" bigserial PRIMARY KEY,
    "workoutPlanId" bigint NOT NULL,
    "date" timestamp without time zone NOT NULL,
    "dayName" text NOT NULL,
    "focus" text NOT NULL,
    "notes" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "workout_exercises"
    ADD CONSTRAINT "workout_exercises_fk_0"
    FOREIGN KEY("workoutSessionId")
    REFERENCES "workout_sessions"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "workout_exercises"
    ADD CONSTRAINT "workout_exercises_fk_1"
    FOREIGN KEY("exerciseId")
    REFERENCES "exercises"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "workout_plans"
    ADD CONSTRAINT "workout_plans_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user_profiles"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "workout_sessions"
    ADD CONSTRAINT "workout_sessions_fk_0"
    FOREIGN KEY("workoutPlanId")
    REFERENCES "workout_plans"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR fitbodyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fitbodyrd', '20251106230840688', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251106230840688', "timestamp" = now();

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
