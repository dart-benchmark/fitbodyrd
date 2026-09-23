BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "foods" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "foods" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "categoryId" bigint NOT NULL,
    "calories" double precision NOT NULL,
    "proteins" double precision NOT NULL,
    "carbs" double precision NOT NULL,
    "fats" double precision NOT NULL,
    "fiber" double precision NOT NULL,
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
-- MIGRATION VERSION FOR fitbodyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fitbodyrd', '20251108041628493', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251108041628493', "timestamp" = now();

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
