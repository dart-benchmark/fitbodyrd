BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "food_intake_log" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "mealPlanId" bigint NOT NULL,
    "foodId" bigint NOT NULL,
    "date" timestamp without time zone NOT NULL,
    "mealType" text NOT NULL,
    "servingSizeId" bigint NOT NULL,
    "servingQuantity" double precision NOT NULL,
    "quantityGrams" double precision NOT NULL,
    "consumedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "notes" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "food_intake_log"
    ADD CONSTRAINT "food_intake_log_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user_profiles"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "food_intake_log"
    ADD CONSTRAINT "food_intake_log_fk_1"
    FOREIGN KEY("mealPlanId")
    REFERENCES "meal_plans"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "food_intake_log"
    ADD CONSTRAINT "food_intake_log_fk_2"
    FOREIGN KEY("foodId")
    REFERENCES "foods"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "food_intake_log"
    ADD CONSTRAINT "food_intake_log_fk_3"
    FOREIGN KEY("servingSizeId")
    REFERENCES "food_serving_sizes"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR fitbodyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fitbodyrd', '20251124202759973', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251124202759973', "timestamp" = now();

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
