BEGIN;

--
-- ACTION ALTER TABLE
--
--
-- ACTION ALTER TABLE
--
--
-- ACTION ALTER TABLE
--
ALTER TABLE "foods" DROP CONSTRAINT "foods_fk_0";
--
-- ACTION CREATE TABLE
--
CREATE TABLE "meal_plan_foods" (
    "id" bigserial PRIMARY KEY,
    "mealPlanId" bigint NOT NULL,
    "foodId" bigint NOT NULL,
    "servingSizeId" bigint NOT NULL,
    "servingQuantity" double precision NOT NULL,
    "quantityGrams" double precision NOT NULL,
    "isUserModified" boolean NOT NULL DEFAULT false,
    "wasUserDeleted" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" timestamp without time zone,
    "deletedById" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "meal_plans" (
    "id" bigserial PRIMARY KEY,
    "nutritionPlanId" bigint NOT NULL,
    "date" timestamp without time zone NOT NULL,
    "dayNumber" bigint NOT NULL,
    "mealType" text NOT NULL,
    "targetCalories" double precision NOT NULL,
    "targetProteins" double precision NOT NULL,
    "targetCarbs" double precision NOT NULL,
    "targetFats" double precision NOT NULL,
    "notes" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "nutrition_plans" (
    "id" bigserial PRIMARY KEY,
    "userProfileId" bigint NOT NULL,
    "startDate" timestamp without time zone NOT NULL,
    "endDate" timestamp without time zone NOT NULL,
    "dailyCalories" double precision NOT NULL,
    "dailyProteins" double precision NOT NULL,
    "dailyCarbs" double precision NOT NULL,
    "dailyFats" double precision NOT NULL,
    "status" text NOT NULL,
    "notes" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "user_food_preferences" DROP CONSTRAINT "user_food_preferences_fk_0";
--
-- ACTION ALTER TABLE
--
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "food_micronutrients"
    ADD CONSTRAINT "food_micronutrients_fk_0"
    FOREIGN KEY("foodId")
    REFERENCES "foods"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "food_serving_sizes"
    ADD CONSTRAINT "food_serving_sizes_fk_0"
    FOREIGN KEY("foodId")
    REFERENCES "foods"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "foods"
    ADD CONSTRAINT "foods_fk_0"
    FOREIGN KEY("categoryId")
    REFERENCES "food_categories"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "meal_plan_foods"
    ADD CONSTRAINT "meal_plan_foods_fk_0"
    FOREIGN KEY("mealPlanId")
    REFERENCES "meal_plans"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "meal_plan_foods"
    ADD CONSTRAINT "meal_plan_foods_fk_1"
    FOREIGN KEY("foodId")
    REFERENCES "foods"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "meal_plan_foods"
    ADD CONSTRAINT "meal_plan_foods_fk_2"
    FOREIGN KEY("servingSizeId")
    REFERENCES "food_serving_sizes"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "meal_plan_foods"
    ADD CONSTRAINT "meal_plan_foods_fk_3"
    FOREIGN KEY("deletedById")
    REFERENCES "user_profiles"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "meal_plans"
    ADD CONSTRAINT "meal_plans_fk_0"
    FOREIGN KEY("nutritionPlanId")
    REFERENCES "nutrition_plans"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "nutrition_plans"
    ADD CONSTRAINT "nutrition_plans_fk_0"
    FOREIGN KEY("userProfileId")
    REFERENCES "user_profiles"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_food_preferences"
    ADD CONSTRAINT "user_food_preferences_fk_1"
    FOREIGN KEY("foodId")
    REFERENCES "foods"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "user_food_preferences"
    ADD CONSTRAINT "user_food_preferences_fk_0"
    FOREIGN KEY("userProfileId")
    REFERENCES "user_profiles"("id")
    ON DELETE CASCADE
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
-- MIGRATION VERSION FOR fitbodyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fitbodyrd', '20251111202822714', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251111202822714', "timestamp" = now();

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

--
-- MIGRATION VERSION FOR _repair
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('_repair', '20251111203343166', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251111203343166', "timestamp" = now();


COMMIT;
