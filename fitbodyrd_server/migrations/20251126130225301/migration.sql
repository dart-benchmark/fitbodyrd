BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "exercise_logs" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "exerciseId" bigint NOT NULL,
    "workoutExerciseId" bigint,
    "date" timestamp without time zone NOT NULL,
    "setNumber" bigint NOT NULL,
    "repsCompleted" bigint NOT NULL,
    "weightUsed" double precision,
    "difficultyRating" bigint,
    "notes" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "_workoutExercisesLogsWorkoutExercisesId" bigint
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "exercise_logs"
    ADD CONSTRAINT "exercise_logs_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user_profiles"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "exercise_logs"
    ADD CONSTRAINT "exercise_logs_fk_1"
    FOREIGN KEY("exerciseId")
    REFERENCES "exercises"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "exercise_logs"
    ADD CONSTRAINT "exercise_logs_fk_2"
    FOREIGN KEY("workoutExerciseId")
    REFERENCES "workout_exercises"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "exercise_logs"
    ADD CONSTRAINT "exercise_logs_fk_3"
    FOREIGN KEY("_workoutExercisesLogsWorkoutExercisesId")
    REFERENCES "workout_exercises"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR fitbodyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fitbodyrd', '20251126130225301', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251126130225301', "timestamp" = now();

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
