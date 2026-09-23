BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "exercise_alternatives" (
    "id" bigserial PRIMARY KEY,
    "exerciseId" bigint NOT NULL,
    "alternativeExerciseId" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "unique_exercise_alternative" ON "exercise_alternatives" USING btree ("exerciseId", "alternativeExerciseId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "exercise_images" (
    "id" bigserial PRIMARY KEY,
    "exerciseId" bigint NOT NULL,
    "imageUrl" text NOT NULL,
    "orderIndex" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "exercises" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "description" text,
    "category" bigint NOT NULL,
    "muscleGroup" bigint NOT NULL,
    "difficulty" bigint NOT NULL,
    "requiresEquipment" boolean NOT NULL DEFAULT false,
    "equipmentNeeded" text,
    "videoUrl" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "unique_exercise_name" ON "exercises" USING btree ("name");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_profiles" (
    "id" bigserial PRIMARY KEY,
    "birthDate" timestamp without time zone NOT NULL,
    "sex" bigint NOT NULL,
    "weight" double precision NOT NULL,
    "height" double precision NOT NULL,
    "bmi" double precision NOT NULL,
    "bodyGoal" bigint NOT NULL,
    "activityLevel" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "exercise_alternatives"
    ADD CONSTRAINT "exercise_alternatives_fk_0"
    FOREIGN KEY("exerciseId")
    REFERENCES "exercises"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "exercise_alternatives"
    ADD CONSTRAINT "exercise_alternatives_fk_1"
    FOREIGN KEY("alternativeExerciseId")
    REFERENCES "exercises"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "exercise_images"
    ADD CONSTRAINT "exercise_images_fk_0"
    FOREIGN KEY("exerciseId")
    REFERENCES "exercises"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR fitbodyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fitbodyrd', '20251006161547648', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251006161547648', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
