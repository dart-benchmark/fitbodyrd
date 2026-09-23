BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "food_categories" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "parentCategoryId" bigint,
    "colorHex" text NOT NULL,
    "displayOrder" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "food_micronutrients" (
    "id" bigserial PRIMARY KEY,
    "foodId" bigint NOT NULL,
    "name" text NOT NULL,
    "amount" double precision NOT NULL,
    "unit" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "food_serving_sizes" (
    "id" bigserial PRIMARY KEY,
    "foodId" bigint NOT NULL,
    "name" text NOT NULL,
    "grams" double precision NOT NULL,
    "isDefault" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "foods" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "categoryId" bigint NOT NULL,
    "calories" bigint NOT NULL,
    "proteins" bigint NOT NULL,
    "carbs" bigint NOT NULL,
    "fats" bigint NOT NULL,
    "fiber" bigint NOT NULL,
    "isActive" boolean NOT NULL DEFAULT true,
    "isLocal" boolean NOT NULL DEFAULT true,
    "imageUrl" text,
    "brand" text,
    "barcode" text,
    "isCustom" boolean NOT NULL DEFAULT false,
    "createdByUserIdId" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_food_preferences" (
    "id" bigserial PRIMARY KEY,
    "userProfileId" bigint NOT NULL,
    "foodId" bigint NOT NULL,
    "preferenceType" text NOT NULL,
    "note" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "food_categories"
    ADD CONSTRAINT "food_categories_fk_0"
    FOREIGN KEY("parentCategoryId")
    REFERENCES "food_categories"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "food_micronutrients"
    ADD CONSTRAINT "food_micronutrients_fk_0"
    FOREIGN KEY("foodId")
    REFERENCES "foods"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "food_serving_sizes"
    ADD CONSTRAINT "food_serving_sizes_fk_0"
    FOREIGN KEY("foodId")
    REFERENCES "foods"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "foods"
    ADD CONSTRAINT "foods_fk_0"
    FOREIGN KEY("categoryId")
    REFERENCES "food_categories"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "foods"
    ADD CONSTRAINT "foods_fk_1"
    FOREIGN KEY("createdByUserIdId")
    REFERENCES "user_profiles"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_food_preferences"
    ADD CONSTRAINT "user_food_preferences_fk_0"
    FOREIGN KEY("userProfileId")
    REFERENCES "user_profiles"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "user_food_preferences"
    ADD CONSTRAINT "user_food_preferences_fk_1"
    FOREIGN KEY("foodId")
    REFERENCES "foods"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR fitbodyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fitbodyrd', '20251108022837076', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251108022837076', "timestamp" = now();

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
