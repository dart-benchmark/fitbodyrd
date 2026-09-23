BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "food_micronutrients" DROP CONSTRAINT "food_micronutrients_fk_0";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "food_serving_sizes" DROP CONSTRAINT "food_serving_sizes_fk_0";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "user_food_preferences" DROP CONSTRAINT "user_food_preferences_fk_0";
ALTER TABLE "user_food_preferences" DROP CONSTRAINT "user_food_preferences_fk_1";
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
ALTER TABLE ONLY "user_food_preferences"
    ADD CONSTRAINT "user_food_preferences_fk_0"
    FOREIGN KEY("userProfileId")
    REFERENCES "user_profiles"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "user_food_preferences"
    ADD CONSTRAINT "user_food_preferences_fk_1"
    FOREIGN KEY("foodId")
    REFERENCES "foods"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR fitbodyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fitbodyrd', '20251108042804141', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251108042804141', "timestamp" = now();

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
