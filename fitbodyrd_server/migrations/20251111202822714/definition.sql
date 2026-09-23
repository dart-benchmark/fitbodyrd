BEGIN;

--
-- Class EmailTemplate as table email_templates
--
CREATE TABLE "email_templates" (
    "id" bigserial PRIMARY KEY,
    "type" text NOT NULL,
    "content" text NOT NULL,
    "subject" text NOT NULL,
    "plainTextContent" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "email_template_type_unique_idx" ON "email_templates" USING btree ("type");

--
-- Class ExerciseAlternative as table exercise_alternatives
--
CREATE TABLE "exercise_alternatives" (
    "id" bigserial PRIMARY KEY,
    "exerciseId" bigint NOT NULL,
    "alternativeExerciseId" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "unique_exercise_alternative" ON "exercise_alternatives" USING btree ("exerciseId", "alternativeExerciseId");

--
-- Class ExerciseImage as table exercise_images
--
CREATE TABLE "exercise_images" (
    "id" bigserial PRIMARY KEY,
    "exerciseId" bigint NOT NULL,
    "imageUrl" text NOT NULL,
    "orderIndex" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Class Exercise as table exercises
--
CREATE TABLE "exercises" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "description" text,
    "category" json NOT NULL,
    "muscleGroup" json NOT NULL,
    "difficulty" text NOT NULL,
    "requiresEquipment" boolean NOT NULL DEFAULT false,
    "equipmentNeeded" text,
    "videoUrl" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "unique_exercise_name" ON "exercises" USING btree ("name");

--
-- Class FoodCategory as table food_categories
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
-- Class FoodMicronutrient as table food_micronutrients
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
-- Class FoodServingSize as table food_serving_sizes
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
-- Class Food as table foods
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
-- Class MealPlanFood as table meal_plan_foods
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
-- Class MealPlan as table meal_plans
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
-- Class NutritionPlan as table nutrition_plans
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
-- Class UserFoodPreference as table user_food_preferences
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
-- Class UserProfile as table user_profiles
--
CREATE TABLE "user_profiles" (
    "id" bigserial PRIMARY KEY,
    "fullName" text NOT NULL,
    "email" text NOT NULL,
    "birthDate" timestamp without time zone NOT NULL,
    "sex" text NOT NULL,
    "weightKgs" double precision NOT NULL,
    "heightMs" double precision NOT NULL,
    "bodyGoal" text NOT NULL,
    "activityLevel" text NOT NULL,
    "daysPerWeekExercise" bigint NOT NULL,
    "timePerExerciseSessionMinutes" bigint NOT NULL,
    "experienceLevel" text NOT NULL,
    "authMethod" text DEFAULT 'google'::text,
    "hasEquipment" boolean NOT NULL DEFAULT true,
    "dietaryRestrictions" text NOT NULL DEFAULT 'none'::text,
    "deletedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Class WorkoutExercise as table workout_exercises
--
CREATE TABLE "workout_exercises" (
    "id" bigserial PRIMARY KEY,
    "workoutSessionId" bigint NOT NULL,
    "exerciseId" bigint NOT NULL,
    "order" bigint NOT NULL,
    "sets" bigint NOT NULL,
    "reps" bigint NOT NULL,
    "restSeconds" bigint NOT NULL,
    "notes" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Class WorkoutPlan as table workout_plans
--
CREATE TABLE "workout_plans" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "name" text NOT NULL,
    "startDate" timestamp without time zone NOT NULL,
    "endDate" timestamp without time zone NOT NULL,
    "difficultyLevel" text NOT NULL,
    "status" text NOT NULL DEFAULT 'active'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Class WorkoutSession as table workout_sessions
--
CREATE TABLE "workout_sessions" (
    "id" bigserial PRIMARY KEY,
    "workoutPlanId" bigint NOT NULL,
    "date" timestamp without time zone NOT NULL,
    "dayName" text NOT NULL,
    "focus" text NOT NULL,
    "notes" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Class CloudStorageEntry as table serverpod_cloud_storage
--
CREATE TABLE "serverpod_cloud_storage" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone,
    "byteData" bytea NOT NULL,
    "verified" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_path_idx" ON "serverpod_cloud_storage" USING btree ("storageId", "path");
CREATE INDEX "serverpod_cloud_storage_expiration" ON "serverpod_cloud_storage" USING btree ("expiration");

--
-- Class CloudStorageDirectUploadEntry as table serverpod_cloud_storage_direct_upload
--
CREATE TABLE "serverpod_cloud_storage_direct_upload" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_upload_storage_path" ON "serverpod_cloud_storage_direct_upload" USING btree ("storageId", "path");

--
-- Class FutureCallEntry as table serverpod_future_call
--
CREATE TABLE "serverpod_future_call" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "serializedObject" text,
    "serverId" text NOT NULL,
    "identifier" text
);

-- Indexes
CREATE INDEX "serverpod_future_call_time_idx" ON "serverpod_future_call" USING btree ("time");
CREATE INDEX "serverpod_future_call_serverId_idx" ON "serverpod_future_call" USING btree ("serverId");
CREATE INDEX "serverpod_future_call_identifier_idx" ON "serverpod_future_call" USING btree ("identifier");

--
-- Class ServerHealthConnectionInfo as table serverpod_health_connection_info
--
CREATE TABLE "serverpod_health_connection_info" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "active" bigint NOT NULL,
    "closing" bigint NOT NULL,
    "idle" bigint NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_connection_info_timestamp_idx" ON "serverpod_health_connection_info" USING btree ("timestamp", "serverId", "granularity");

--
-- Class ServerHealthMetric as table serverpod_health_metric
--
CREATE TABLE "serverpod_health_metric" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isHealthy" boolean NOT NULL,
    "value" double precision NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_metric_timestamp_idx" ON "serverpod_health_metric" USING btree ("timestamp", "serverId", "name", "granularity");

--
-- Class LogEntry as table serverpod_log
--
CREATE TABLE "serverpod_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "reference" text,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "logLevel" bigint NOT NULL,
    "message" text NOT NULL,
    "error" text,
    "stackTrace" text,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId");

--
-- Class MessageLogEntry as table serverpod_message_log
--
CREATE TABLE "serverpod_message_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "serverId" text NOT NULL,
    "messageId" bigint NOT NULL,
    "endpoint" text NOT NULL,
    "messageName" text NOT NULL,
    "duration" double precision NOT NULL,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

--
-- Class MethodInfo as table serverpod_method
--
CREATE TABLE "serverpod_method" (
    "id" bigserial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");

--
-- Class DatabaseMigrationVersion as table serverpod_migrations
--
CREATE TABLE "serverpod_migrations" (
    "id" bigserial PRIMARY KEY,
    "module" text NOT NULL,
    "version" text NOT NULL,
    "timestamp" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_migrations_ids" ON "serverpod_migrations" USING btree ("module");

--
-- Class QueryLogEntry as table serverpod_query_log
--
CREATE TABLE "serverpod_query_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "query" text NOT NULL,
    "duration" double precision NOT NULL,
    "numRows" bigint,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId");

--
-- Class ReadWriteTestEntry as table serverpod_readwrite_test
--
CREATE TABLE "serverpod_readwrite_test" (
    "id" bigserial PRIMARY KEY,
    "number" bigint NOT NULL
);

--
-- Class RuntimeSettings as table serverpod_runtime_settings
--
CREATE TABLE "serverpod_runtime_settings" (
    "id" bigserial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);

--
-- Class SessionLogEntry as table serverpod_session_log
--
CREATE TABLE "serverpod_session_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "module" text,
    "endpoint" text,
    "method" text,
    "duration" double precision,
    "numQueries" bigint,
    "slow" boolean,
    "error" text,
    "stackTrace" text,
    "authenticatedUserId" bigint,
    "isOpen" boolean,
    "touched" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");

--
-- Class AuthKey as table serverpod_auth_key
--
CREATE TABLE "serverpod_auth_key" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "hash" text NOT NULL,
    "scopeNames" json NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_auth_key_userId_idx" ON "serverpod_auth_key" USING btree ("userId");

--
-- Class EmailAuth as table serverpod_email_auth
--
CREATE TABLE "serverpod_email_auth" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_email" ON "serverpod_email_auth" USING btree ("email");

--
-- Class EmailCreateAccountRequest as table serverpod_email_create_request
--
CREATE TABLE "serverpod_email_create_request" (
    "id" bigserial PRIMARY KEY,
    "userName" text NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL,
    "verificationCode" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_create_account_request_idx" ON "serverpod_email_create_request" USING btree ("email");

--
-- Class EmailFailedSignIn as table serverpod_email_failed_sign_in
--
CREATE TABLE "serverpod_email_failed_sign_in" (
    "id" bigserial PRIMARY KEY,
    "email" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "ipAddress" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_email_failed_sign_in_email_idx" ON "serverpod_email_failed_sign_in" USING btree ("email");
CREATE INDEX "serverpod_email_failed_sign_in_time_idx" ON "serverpod_email_failed_sign_in" USING btree ("time");

--
-- Class EmailReset as table serverpod_email_reset
--
CREATE TABLE "serverpod_email_reset" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "verificationCode" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_reset_verification_idx" ON "serverpod_email_reset" USING btree ("verificationCode");

--
-- Class GoogleRefreshToken as table serverpod_google_refresh_token
--
CREATE TABLE "serverpod_google_refresh_token" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "refreshToken" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_google_refresh_token_userId_idx" ON "serverpod_google_refresh_token" USING btree ("userId");

--
-- Class UserImage as table serverpod_user_image
--
CREATE TABLE "serverpod_user_image" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "version" bigint NOT NULL,
    "url" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_user_image_user_id" ON "serverpod_user_image" USING btree ("userId", "version");

--
-- Class UserInfo as table serverpod_user_info
--
CREATE TABLE "serverpod_user_info" (
    "id" bigserial PRIMARY KEY,
    "userIdentifier" text NOT NULL,
    "userName" text,
    "fullName" text,
    "email" text,
    "created" timestamp without time zone NOT NULL,
    "imageUrl" text,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_user_info_user_identifier" ON "serverpod_user_info" USING btree ("userIdentifier");
CREATE INDEX "serverpod_user_info_email" ON "serverpod_user_info" USING btree ("email");

--
-- Foreign relations for "exercise_alternatives" table
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
-- Foreign relations for "exercise_images" table
--
ALTER TABLE ONLY "exercise_images"
    ADD CONSTRAINT "exercise_images_fk_0"
    FOREIGN KEY("exerciseId")
    REFERENCES "exercises"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "food_categories" table
--
ALTER TABLE ONLY "food_categories"
    ADD CONSTRAINT "food_categories_fk_0"
    FOREIGN KEY("parentCategoryId")
    REFERENCES "food_categories"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "food_micronutrients" table
--
ALTER TABLE ONLY "food_micronutrients"
    ADD CONSTRAINT "food_micronutrients_fk_0"
    FOREIGN KEY("foodId")
    REFERENCES "foods"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "food_serving_sizes" table
--
ALTER TABLE ONLY "food_serving_sizes"
    ADD CONSTRAINT "food_serving_sizes_fk_0"
    FOREIGN KEY("foodId")
    REFERENCES "foods"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "foods" table
--
ALTER TABLE ONLY "foods"
    ADD CONSTRAINT "foods_fk_0"
    FOREIGN KEY("categoryId")
    REFERENCES "food_categories"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "foods"
    ADD CONSTRAINT "foods_fk_1"
    FOREIGN KEY("createdByUserIdId")
    REFERENCES "user_profiles"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "meal_plan_foods" table
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
-- Foreign relations for "meal_plans" table
--
ALTER TABLE ONLY "meal_plans"
    ADD CONSTRAINT "meal_plans_fk_0"
    FOREIGN KEY("nutritionPlanId")
    REFERENCES "nutrition_plans"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "nutrition_plans" table
--
ALTER TABLE ONLY "nutrition_plans"
    ADD CONSTRAINT "nutrition_plans_fk_0"
    FOREIGN KEY("userProfileId")
    REFERENCES "user_profiles"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "user_food_preferences" table
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
-- Foreign relations for "workout_exercises" table
--
ALTER TABLE ONLY "workout_exercises"
    ADD CONSTRAINT "workout_exercises_fk_0"
    FOREIGN KEY("workoutSessionId")
    REFERENCES "workout_sessions"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "workout_exercises"
    ADD CONSTRAINT "workout_exercises_fk_1"
    FOREIGN KEY("exerciseId")
    REFERENCES "exercises"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "workout_plans" table
--
ALTER TABLE ONLY "workout_plans"
    ADD CONSTRAINT "workout_plans_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user_profiles"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "workout_sessions" table
--
ALTER TABLE ONLY "workout_sessions"
    ADD CONSTRAINT "workout_sessions_fk_0"
    FOREIGN KEY("workoutPlanId")
    REFERENCES "workout_plans"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_log" table
--
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_message_log" table
--
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_query_log" table
--
ALTER TABLE ONLY "serverpod_query_log"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
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


COMMIT;
