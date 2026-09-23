BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "food_categories" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "food_categories" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "slug" text NOT NULL,
    "iconName" text NOT NULL,
    "parentCategoryId" bigint,
    "colorHex" text NOT NULL,
    "displayOrder" bigint NOT NULL DEFAULT 0,
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
-- MIGRATION VERSION FOR fitbodyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fitbodyrd', '20251108032935213', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251108032935213', "timestamp" = now();

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
