BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "meal_plan_foods" CASCADE;

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
-- ACTION DROP TABLE
--
DROP TABLE "meal_plans" CASCADE;

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
-- MIGRATION VERSION FOR fitbodyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fitbodyrd', '20251111200732485', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251111200732485', "timestamp" = now();

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
