BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "foods" DROP CONSTRAINT "foods_fk_0";
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
-- MIGRATION VERSION FOR fitbodyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fitbodyrd', '20251108043034995', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251108043034995', "timestamp" = now();

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
