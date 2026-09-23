/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i3;
import 'common/models/activity_level.dart' as _i4;
import 'common/models/body_goal.dart' as _i5;
import 'common/models/exercise_difficulty.dart' as _i6;
import 'common/models/sex.dart' as _i7;
import 'common/models/status.dart' as _i8;
import 'common/models/stream_status.dart' as _i9;
import 'common/models/string_list.dart' as _i10;
import 'common/models/weight_category.dart' as _i11;
import 'errors/models/app_exception.dart' as _i12;
import 'errors/models/generic_exception.dart' as _i13;
import 'features/dashboard/dto/weekly_summary.dto.dart' as _i14;
import 'features/email/models/email_template.dart' as _i15;
import 'features/email/models/email_templates_enum.dart' as _i16;
import 'features/exercise/models/exercise.dart' as _i17;
import 'features/exercise/models/exercise_alternative.dart' as _i18;
import 'features/exercise/models/exercise_category.dart' as _i19;
import 'features/exercise/models/exercise_image.dart' as _i20;
import 'features/exercise/models/exercise_image_order.dart' as _i21;
import 'features/exercise/models/exercise_muscle_group.dart' as _i22;
import 'features/food/dto/create_micronutrient.dto.dart' as _i23;
import 'features/food/dto/create_serving_size.dto.dart' as _i24;
import 'features/food/dto/food_catalogue.dto.dart' as _i25;
import 'features/food/dto/food_category_detail.dto.dart' as _i26;
import 'features/food/dto/search_endpoints_response.dto.dart' as _i27;
import 'features/food/models/dietary_restriction.dart' as _i28;
import 'features/food/models/food.dart' as _i29;
import 'features/food/models/food_category.dart' as _i30;
import 'features/food/models/food_category_list.dart' as _i31;
import 'features/food/models/food_micronutrient.dart' as _i32;
import 'features/food/models/food_serving_size.dart' as _i33;
import 'features/food/models/user_food_preference.dart' as _i34;
import 'features/food/models/user_food_preference_type.dart' as _i35;
import 'features/nutrition/dto/create_food_intake_log.dto.dart' as _i36;
import 'features/nutrition/dto/macros_response.dto.dart' as _i37;
import 'features/nutrition/dto/meal_distribution.dto.dart' as _i38;
import 'features/nutrition/dto/meal_individual_distribution.dto.dart' as _i39;
import 'features/nutrition/models/food_intake_log.dart' as _i40;
import 'features/nutrition_plan/dto/create_meal_plan.dto.dart' as _i41;
import 'features/nutrition_plan/dto/create_meal_plan_detail.dto.dart' as _i42;
import 'features/nutrition_plan/dto/create_meal_plan_food.dto.dart' as _i43;
import 'features/nutrition_plan/dto/created_meal_plan.dto.dart' as _i44;
import 'features/nutrition_plan/dto/created_meal_plan_id.dto.dart' as _i45;
import 'features/nutrition_plan/dto/created_meal_plan_totals.dto.dart' as _i46;
import 'features/nutrition_plan/dto/created_meal_plan_variance.dto.dart'
    as _i47;
import 'features/nutrition_plan/dto/generate_nutrition_plan_progress.dto.dart'
    as _i48;
import 'features/nutrition_plan/dto/update_meal_plan_food.dto.dart' as _i49;
import 'features/nutrition_plan/models/meal_plan.dart' as _i50;
import 'features/nutrition_plan/models/meal_plan_food.dart' as _i51;
import 'features/nutrition_plan/models/meal_type.dart' as _i52;
import 'features/nutrition_plan/models/nutrition_plan.dart' as _i53;
import 'features/user/dto/user_food_preferences_response.dto.dart' as _i54;
import 'features/user/models/app_user.dart' as _i55;
import 'features/user/models/auth_method.dart' as _i56;
import 'features/workouts/dto/create_workout_exercise.dto.dart' as _i57;
import 'features/workouts/dto/create_workout_plan.dto.dart' as _i58;
import 'features/workouts/dto/create_workout_session.dto.dart' as _i59;
import 'features/workouts/dto/generate_workout_plan_progress.dto.dart' as _i60;
import 'features/workouts/dto/workout_progress_metrics.dto.dart' as _i61;
import 'features/workouts/dto/workout_sessions_by_date.dto.dart' as _i62;
import 'features/workouts/models/exercise_log.dart' as _i63;
import 'features/workouts/models/workout_exercise.dart' as _i64;
import 'features/workouts/models/workout_plan.dart' as _i65;
import 'features/workouts/models/workout_session.dart' as _i66;
import 'features/workouts/models/workout_tip.dart' as _i67;
import 'package:fitbodyrd_server/src/generated/features/exercise/models/exercise.dart'
    as _i68;
import 'package:fitbodyrd_server/src/generated/features/exercise/models/exercise_category.dart'
    as _i69;
import 'package:fitbodyrd_server/src/generated/features/exercise/models/exercise_muscle_group.dart'
    as _i70;
import 'package:fitbodyrd_server/src/generated/features/exercise/models/exercise_image.dart'
    as _i71;
import 'package:fitbodyrd_server/src/generated/features/exercise/models/exercise_image_order.dart'
    as _i72;
import 'package:fitbodyrd_server/src/generated/common/models/exercise_difficulty.dart'
    as _i73;
import 'package:fitbodyrd_server/src/generated/features/food/models/food_category.dart'
    as _i74;
import 'package:fitbodyrd_server/src/generated/features/food/models/food.dart'
    as _i75;
import 'package:fitbodyrd_server/src/generated/features/food/dto/create_serving_size.dto.dart'
    as _i76;
import 'package:fitbodyrd_server/src/generated/features/food/dto/create_micronutrient.dto.dart'
    as _i77;
import 'package:fitbodyrd_server/src/generated/features/nutrition/models/food_intake_log.dart'
    as _i78;
import 'package:fitbodyrd_server/src/generated/features/nutrition_plan/models/meal_type.dart'
    as _i79;
import 'package:fitbodyrd_server/src/generated/features/workouts/models/exercise_log.dart'
    as _i80;
import 'package:fitbodyrd_server/src/generated/features/workouts/models/workout_session.dart'
    as _i81;
import 'package:fitbodyrd_server/src/generated/features/workouts/dto/workout_sessions_by_date.dto.dart'
    as _i82;
export 'common/models/activity_level.dart';
export 'common/models/body_goal.dart';
export 'common/models/exercise_difficulty.dart';
export 'common/models/sex.dart';
export 'common/models/status.dart';
export 'common/models/stream_status.dart';
export 'common/models/string_list.dart';
export 'common/models/weight_category.dart';
export 'errors/models/app_exception.dart';
export 'errors/models/generic_exception.dart';
export 'features/dashboard/dto/weekly_summary.dto.dart';
export 'features/email/models/email_template.dart';
export 'features/email/models/email_templates_enum.dart';
export 'features/exercise/models/exercise.dart';
export 'features/exercise/models/exercise_alternative.dart';
export 'features/exercise/models/exercise_category.dart';
export 'features/exercise/models/exercise_image.dart';
export 'features/exercise/models/exercise_image_order.dart';
export 'features/exercise/models/exercise_muscle_group.dart';
export 'features/food/dto/create_micronutrient.dto.dart';
export 'features/food/dto/create_serving_size.dto.dart';
export 'features/food/dto/food_catalogue.dto.dart';
export 'features/food/dto/food_category_detail.dto.dart';
export 'features/food/dto/search_endpoints_response.dto.dart';
export 'features/food/models/dietary_restriction.dart';
export 'features/food/models/food.dart';
export 'features/food/models/food_category.dart';
export 'features/food/models/food_category_list.dart';
export 'features/food/models/food_micronutrient.dart';
export 'features/food/models/food_serving_size.dart';
export 'features/food/models/user_food_preference.dart';
export 'features/food/models/user_food_preference_type.dart';
export 'features/nutrition/dto/create_food_intake_log.dto.dart';
export 'features/nutrition/dto/macros_response.dto.dart';
export 'features/nutrition/dto/meal_distribution.dto.dart';
export 'features/nutrition/dto/meal_individual_distribution.dto.dart';
export 'features/nutrition/models/food_intake_log.dart';
export 'features/nutrition_plan/dto/create_meal_plan.dto.dart';
export 'features/nutrition_plan/dto/create_meal_plan_detail.dto.dart';
export 'features/nutrition_plan/dto/create_meal_plan_food.dto.dart';
export 'features/nutrition_plan/dto/created_meal_plan.dto.dart';
export 'features/nutrition_plan/dto/created_meal_plan_id.dto.dart';
export 'features/nutrition_plan/dto/created_meal_plan_totals.dto.dart';
export 'features/nutrition_plan/dto/created_meal_plan_variance.dto.dart';
export 'features/nutrition_plan/dto/generate_nutrition_plan_progress.dto.dart';
export 'features/nutrition_plan/dto/update_meal_plan_food.dto.dart';
export 'features/nutrition_plan/models/meal_plan.dart';
export 'features/nutrition_plan/models/meal_plan_food.dart';
export 'features/nutrition_plan/models/meal_type.dart';
export 'features/nutrition_plan/models/nutrition_plan.dart';
export 'features/user/dto/user_food_preferences_response.dto.dart';
export 'features/user/models/app_user.dart';
export 'features/user/models/auth_method.dart';
export 'features/workouts/dto/create_workout_exercise.dto.dart';
export 'features/workouts/dto/create_workout_plan.dto.dart';
export 'features/workouts/dto/create_workout_session.dto.dart';
export 'features/workouts/dto/generate_workout_plan_progress.dto.dart';
export 'features/workouts/dto/workout_progress_metrics.dto.dart';
export 'features/workouts/dto/workout_sessions_by_date.dto.dart';
export 'features/workouts/models/exercise_log.dart';
export 'features/workouts/models/workout_exercise.dart';
export 'features/workouts/models/workout_plan.dart';
export 'features/workouts/models/workout_session.dart';
export 'features/workouts/models/workout_tip.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'email_templates',
      dartName: 'EmailTemplate',
      schema: 'public',
      module: 'fitbodyrd',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'email_templates_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:EmailTemplatesEnum',
        ),
        _i2.ColumnDefinition(
          name: 'content',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'subject',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'plainTextContent',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'email_templates_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'email_template_type_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'type',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'exercise_alternatives',
      dartName: 'ExerciseAlternative',
      schema: 'public',
      module: 'fitbodyrd',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'exercise_alternatives_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'exerciseId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'alternativeExerciseId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'exercise_alternatives_fk_0',
          columns: ['exerciseId'],
          referenceTable: 'exercises',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'exercise_alternatives_fk_1',
          columns: ['alternativeExerciseId'],
          referenceTable: 'exercises',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'exercise_alternatives_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'unique_exercise_alternative',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'exerciseId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'alternativeExerciseId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'exercise_images',
      dartName: 'ExerciseImage',
      schema: 'public',
      module: 'fitbodyrd',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'exercise_images_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'exerciseId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'imageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'orderIndex',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'exercise_images_fk_0',
          columns: ['exerciseId'],
          referenceTable: 'exercises',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'exercise_images_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'exercise_logs',
      dartName: 'ExerciseLog',
      schema: 'public',
      module: 'fitbodyrd',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'exercise_logs_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'exerciseId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'workoutExerciseId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'date',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'setsCompleted',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'repsCompleted',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'weightUsed',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'difficultyRating',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: '_workoutExercisesLogsWorkoutExercisesId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'exercise_logs_fk_0',
          columns: ['userId'],
          referenceTable: 'user_profiles',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'exercise_logs_fk_1',
          columns: ['exerciseId'],
          referenceTable: 'exercises',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'exercise_logs_fk_2',
          columns: ['workoutExerciseId'],
          referenceTable: 'workout_exercises',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'exercise_logs_fk_3',
          columns: ['_workoutExercisesLogsWorkoutExercisesId'],
          referenceTable: 'workout_exercises',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'exercise_logs_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'exercises',
      dartName: 'Exercise',
      schema: 'public',
      module: 'fitbodyrd',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'exercises_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'category',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:ExerciseCategory>',
        ),
        _i2.ColumnDefinition(
          name: 'muscleGroup',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:ExerciseMuscleGroup>',
        ),
        _i2.ColumnDefinition(
          name: 'difficulty',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ExerciseDifficulty',
        ),
        _i2.ColumnDefinition(
          name: 'requiresEquipment',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'equipmentNeeded',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'videoUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'exercises_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'unique_exercise_name',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'name',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'food_categories',
      dartName: 'FoodCategory',
      schema: 'public',
      module: 'fitbodyrd',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'food_categories_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'slug',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'iconName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'parentCategoryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'colorHex',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'displayOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'food_categories_fk_0',
          columns: ['parentCategoryId'],
          referenceTable: 'food_categories',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'food_categories_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'food_intake_log',
      dartName: 'FoodIntakeLog',
      schema: 'public',
      module: 'fitbodyrd',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'food_intake_log_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'mealPlanId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'foodId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'date',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'mealType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MealPlanType',
        ),
        _i2.ColumnDefinition(
          name: 'servingSizeId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'servingQuantity',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'quantityGrams',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'consumedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'food_intake_log_fk_0',
          columns: ['userId'],
          referenceTable: 'user_profiles',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'food_intake_log_fk_1',
          columns: ['mealPlanId'],
          referenceTable: 'meal_plans',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'food_intake_log_fk_2',
          columns: ['foodId'],
          referenceTable: 'foods',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'food_intake_log_fk_3',
          columns: ['servingSizeId'],
          referenceTable: 'food_serving_sizes',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'food_intake_log_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'food_micronutrients',
      dartName: 'FoodMicronutrient',
      schema: 'public',
      module: 'fitbodyrd',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'food_micronutrients_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'foodId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'amount',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'unit',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'food_micronutrients_fk_0',
          columns: ['foodId'],
          referenceTable: 'foods',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'food_micronutrients_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'food_serving_sizes',
      dartName: 'FoodServingSize',
      schema: 'public',
      module: 'fitbodyrd',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'food_serving_sizes_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'foodId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'grams',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'isDefault',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'food_serving_sizes_fk_0',
          columns: ['foodId'],
          referenceTable: 'foods',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'food_serving_sizes_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'foods',
      dartName: 'Food',
      schema: 'public',
      module: 'fitbodyrd',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'foods_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'categoryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'calories',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'proteins',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'carbs',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'fats',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'fiber',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'isLocal',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'imageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'brand',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'barcode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isCustom',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'createdByUserIdId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'foods_fk_0',
          columns: ['categoryId'],
          referenceTable: 'food_categories',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'foods_fk_1',
          columns: ['createdByUserIdId'],
          referenceTable: 'user_profiles',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'foods_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'meal_plan_foods',
      dartName: 'MealPlanFood',
      schema: 'public',
      module: 'fitbodyrd',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'meal_plan_foods_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'mealPlanId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'foodId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'servingSizeId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'servingQuantity',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'quantityGrams',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'isUserModified',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'wasUserDeleted',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'deletedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'deletedById',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'meal_plan_foods_fk_0',
          columns: ['mealPlanId'],
          referenceTable: 'meal_plans',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'meal_plan_foods_fk_1',
          columns: ['foodId'],
          referenceTable: 'foods',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'meal_plan_foods_fk_2',
          columns: ['servingSizeId'],
          referenceTable: 'food_serving_sizes',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'meal_plan_foods_fk_3',
          columns: ['deletedById'],
          referenceTable: 'user_profiles',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'meal_plan_foods_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'meal_plans',
      dartName: 'MealPlan',
      schema: 'public',
      module: 'fitbodyrd',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'meal_plans_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'nutritionPlanId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'date',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'dayNumber',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'mealType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MealPlanType',
        ),
        _i2.ColumnDefinition(
          name: 'targetCalories',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'targetProteins',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'targetCarbs',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'targetFats',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'meal_plans_fk_0',
          columns: ['nutritionPlanId'],
          referenceTable: 'nutrition_plans',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'meal_plans_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'nutrition_plans',
      dartName: 'NutritionPlan',
      schema: 'public',
      module: 'fitbodyrd',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'nutrition_plans_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userProfileId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'startDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'endDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'dailyCalories',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'dailyProteins',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'dailyCarbs',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'dailyFats',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:Status',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'nutrition_plans_fk_0',
          columns: ['userProfileId'],
          referenceTable: 'user_profiles',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'nutrition_plans_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_food_preferences',
      dartName: 'UserFoodPreference',
      schema: 'public',
      module: 'fitbodyrd',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_food_preferences_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userProfileId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'foodId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'preferenceType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:UserFoodPreferenceType',
        ),
        _i2.ColumnDefinition(
          name: 'note',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'user_food_preferences_fk_0',
          columns: ['userProfileId'],
          referenceTable: 'user_profiles',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'user_food_preferences_fk_1',
          columns: ['foodId'],
          referenceTable: 'foods',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_food_preferences_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_profiles',
      dartName: 'UserProfile',
      schema: 'public',
      module: 'fitbodyrd',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_profiles_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userInfoId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'fullName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'birthDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'sex',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:Sex',
        ),
        _i2.ColumnDefinition(
          name: 'weightKgs',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'heightMs',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'bodyGoal',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:BodyGoal',
        ),
        _i2.ColumnDefinition(
          name: 'activityLevel',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ActivityLevel',
        ),
        _i2.ColumnDefinition(
          name: 'daysPerWeekExercise',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'timePerExerciseSessionMinutes',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'experienceLevel',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ExerciseDifficulty',
        ),
        _i2.ColumnDefinition(
          name: 'authMethod',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:AuthMethod?',
          columnDefault: '\'google\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'hasEquipment',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'dietaryRestrictions',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DietaryRestriction',
          columnDefault: '\'none\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'deletedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'user_profiles_fk_0',
          columns: ['userInfoId'],
          referenceTable: 'serverpod_user_info',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_profiles_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'workout_exercises',
      dartName: 'WorkoutExercise',
      schema: 'public',
      module: 'fitbodyrd',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'workout_exercises_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'workoutSessionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'exerciseId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'order',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'sets',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'reps',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'restSeconds',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'workout_exercises_fk_0',
          columns: ['workoutSessionId'],
          referenceTable: 'workout_sessions',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'workout_exercises_fk_1',
          columns: ['exerciseId'],
          referenceTable: 'exercises',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'workout_exercises_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'workout_plans',
      dartName: 'WorkoutPlan',
      schema: 'public',
      module: 'fitbodyrd',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'workout_plans_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'startDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'endDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'difficultyLevel',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ExerciseDifficulty',
        ),
        _i2.ColumnDefinition(
          name: 'sessionsCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:Status',
          columnDefault: '\'active\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'workout_plans_fk_0',
          columns: ['userId'],
          referenceTable: 'user_profiles',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'workout_plans_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'workout_sessions',
      dartName: 'WorkoutSession',
      schema: 'public',
      module: 'fitbodyrd',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'workout_sessions_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'workoutPlanId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'date',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'dayName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'focus',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'sessionComplete',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'workout_sessions_fk_0',
          columns: ['workoutPlanId'],
          referenceTable: 'workout_plans',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'workout_sessions_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'workout_tips',
      dartName: 'WorkoutTip',
      schema: 'public',
      module: 'fitbodyrd',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'workout_tips_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'content',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'order',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'workout_tips_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'workout_tip_order_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'order',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i4.ActivityLevel) {
      return _i4.ActivityLevel.fromJson(data) as T;
    }
    if (t == _i5.BodyGoal) {
      return _i5.BodyGoal.fromJson(data) as T;
    }
    if (t == _i6.ExerciseDifficulty) {
      return _i6.ExerciseDifficulty.fromJson(data) as T;
    }
    if (t == _i7.Sex) {
      return _i7.Sex.fromJson(data) as T;
    }
    if (t == _i8.Status) {
      return _i8.Status.fromJson(data) as T;
    }
    if (t == _i9.StreamStatus) {
      return _i9.StreamStatus.fromJson(data) as T;
    }
    if (t == _i10.StringList) {
      return _i10.StringList.fromJson(data) as T;
    }
    if (t == _i11.WeightCategory) {
      return _i11.WeightCategory.fromJson(data) as T;
    }
    if (t == _i12.AppException) {
      return _i12.AppException.fromJson(data) as T;
    }
    if (t == _i13.GenericException) {
      return _i13.GenericException.fromJson(data) as T;
    }
    if (t == _i14.WeeklySummaryDto) {
      return _i14.WeeklySummaryDto.fromJson(data) as T;
    }
    if (t == _i15.EmailTemplate) {
      return _i15.EmailTemplate.fromJson(data) as T;
    }
    if (t == _i16.EmailTemplatesEnum) {
      return _i16.EmailTemplatesEnum.fromJson(data) as T;
    }
    if (t == _i17.Exercise) {
      return _i17.Exercise.fromJson(data) as T;
    }
    if (t == _i18.ExerciseAlternative) {
      return _i18.ExerciseAlternative.fromJson(data) as T;
    }
    if (t == _i19.ExerciseCategory) {
      return _i19.ExerciseCategory.fromJson(data) as T;
    }
    if (t == _i20.ExerciseImage) {
      return _i20.ExerciseImage.fromJson(data) as T;
    }
    if (t == _i21.ExerciseImageOrder) {
      return _i21.ExerciseImageOrder.fromJson(data) as T;
    }
    if (t == _i22.ExerciseMuscleGroup) {
      return _i22.ExerciseMuscleGroup.fromJson(data) as T;
    }
    if (t == _i23.CreateMicronutrientDto) {
      return _i23.CreateMicronutrientDto.fromJson(data) as T;
    }
    if (t == _i24.CreateServingSizeDto) {
      return _i24.CreateServingSizeDto.fromJson(data) as T;
    }
    if (t == _i25.FoodCatalogueDto) {
      return _i25.FoodCatalogueDto.fromJson(data) as T;
    }
    if (t == _i26.FoodCategoryDetailDto) {
      return _i26.FoodCategoryDetailDto.fromJson(data) as T;
    }
    if (t == _i27.SearchEndpointsResponseDto) {
      return _i27.SearchEndpointsResponseDto.fromJson(data) as T;
    }
    if (t == _i28.DietaryRestriction) {
      return _i28.DietaryRestriction.fromJson(data) as T;
    }
    if (t == _i29.Food) {
      return _i29.Food.fromJson(data) as T;
    }
    if (t == _i30.FoodCategory) {
      return _i30.FoodCategory.fromJson(data) as T;
    }
    if (t == _i31.FoodCategoryList) {
      return _i31.FoodCategoryList.fromJson(data) as T;
    }
    if (t == _i32.FoodMicronutrient) {
      return _i32.FoodMicronutrient.fromJson(data) as T;
    }
    if (t == _i33.FoodServingSize) {
      return _i33.FoodServingSize.fromJson(data) as T;
    }
    if (t == _i34.UserFoodPreference) {
      return _i34.UserFoodPreference.fromJson(data) as T;
    }
    if (t == _i35.UserFoodPreferenceType) {
      return _i35.UserFoodPreferenceType.fromJson(data) as T;
    }
    if (t == _i36.CreateFoodIntakeLog) {
      return _i36.CreateFoodIntakeLog.fromJson(data) as T;
    }
    if (t == _i37.MacrosResponseDto) {
      return _i37.MacrosResponseDto.fromJson(data) as T;
    }
    if (t == _i38.MealDistributionDto) {
      return _i38.MealDistributionDto.fromJson(data) as T;
    }
    if (t == _i39.MealIndividualDistributionDto) {
      return _i39.MealIndividualDistributionDto.fromJson(data) as T;
    }
    if (t == _i40.FoodIntakeLog) {
      return _i40.FoodIntakeLog.fromJson(data) as T;
    }
    if (t == _i41.CreateMealPlanDto) {
      return _i41.CreateMealPlanDto.fromJson(data) as T;
    }
    if (t == _i42.CreateMealPlanDetailDto) {
      return _i42.CreateMealPlanDetailDto.fromJson(data) as T;
    }
    if (t == _i43.CreateMealPlanFoodDto) {
      return _i43.CreateMealPlanFoodDto.fromJson(data) as T;
    }
    if (t == _i44.CreatedMealPlanDto) {
      return _i44.CreatedMealPlanDto.fromJson(data) as T;
    }
    if (t == _i45.CreatedMealPlanIdDto) {
      return _i45.CreatedMealPlanIdDto.fromJson(data) as T;
    }
    if (t == _i46.CreatedMealPlanTotalsDto) {
      return _i46.CreatedMealPlanTotalsDto.fromJson(data) as T;
    }
    if (t == _i47.CreatedMealPlanVarianceDto) {
      return _i47.CreatedMealPlanVarianceDto.fromJson(data) as T;
    }
    if (t == _i48.GenerateNutritionPlanProgressDto) {
      return _i48.GenerateNutritionPlanProgressDto.fromJson(data) as T;
    }
    if (t == _i49.UpdateMealPlanFoodDto) {
      return _i49.UpdateMealPlanFoodDto.fromJson(data) as T;
    }
    if (t == _i50.MealPlan) {
      return _i50.MealPlan.fromJson(data) as T;
    }
    if (t == _i51.MealPlanFood) {
      return _i51.MealPlanFood.fromJson(data) as T;
    }
    if (t == _i52.MealPlanType) {
      return _i52.MealPlanType.fromJson(data) as T;
    }
    if (t == _i53.NutritionPlan) {
      return _i53.NutritionPlan.fromJson(data) as T;
    }
    if (t == _i54.UserFoodPreferencesResponseDto) {
      return _i54.UserFoodPreferencesResponseDto.fromJson(data) as T;
    }
    if (t == _i55.UserProfile) {
      return _i55.UserProfile.fromJson(data) as T;
    }
    if (t == _i56.AuthMethod) {
      return _i56.AuthMethod.fromJson(data) as T;
    }
    if (t == _i57.CreateWorkoutExerciseDto) {
      return _i57.CreateWorkoutExerciseDto.fromJson(data) as T;
    }
    if (t == _i58.CreateWorkoutPlanDto) {
      return _i58.CreateWorkoutPlanDto.fromJson(data) as T;
    }
    if (t == _i59.CreateWorkoutSessionDto) {
      return _i59.CreateWorkoutSessionDto.fromJson(data) as T;
    }
    if (t == _i60.GenerateWorkoutPlanProgressDto) {
      return _i60.GenerateWorkoutPlanProgressDto.fromJson(data) as T;
    }
    if (t == _i61.WorkoutProgressMetricsDto) {
      return _i61.WorkoutProgressMetricsDto.fromJson(data) as T;
    }
    if (t == _i62.WorkoutSessionsByDateDto) {
      return _i62.WorkoutSessionsByDateDto.fromJson(data) as T;
    }
    if (t == _i63.ExerciseLog) {
      return _i63.ExerciseLog.fromJson(data) as T;
    }
    if (t == _i64.WorkoutExercise) {
      return _i64.WorkoutExercise.fromJson(data) as T;
    }
    if (t == _i65.WorkoutPlan) {
      return _i65.WorkoutPlan.fromJson(data) as T;
    }
    if (t == _i66.WorkoutSession) {
      return _i66.WorkoutSession.fromJson(data) as T;
    }
    if (t == _i67.WorkoutTip) {
      return _i67.WorkoutTip.fromJson(data) as T;
    }
    if (t == _i1.getType<_i4.ActivityLevel?>()) {
      return (data != null ? _i4.ActivityLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.BodyGoal?>()) {
      return (data != null ? _i5.BodyGoal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ExerciseDifficulty?>()) {
      return (data != null ? _i6.ExerciseDifficulty.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Sex?>()) {
      return (data != null ? _i7.Sex.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Status?>()) {
      return (data != null ? _i8.Status.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.StreamStatus?>()) {
      return (data != null ? _i9.StreamStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.StringList?>()) {
      return (data != null ? _i10.StringList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.WeightCategory?>()) {
      return (data != null ? _i11.WeightCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.AppException?>()) {
      return (data != null ? _i12.AppException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.GenericException?>()) {
      return (data != null ? _i13.GenericException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.WeeklySummaryDto?>()) {
      return (data != null ? _i14.WeeklySummaryDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.EmailTemplate?>()) {
      return (data != null ? _i15.EmailTemplate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.EmailTemplatesEnum?>()) {
      return (data != null ? _i16.EmailTemplatesEnum.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.Exercise?>()) {
      return (data != null ? _i17.Exercise.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.ExerciseAlternative?>()) {
      return (data != null ? _i18.ExerciseAlternative.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.ExerciseCategory?>()) {
      return (data != null ? _i19.ExerciseCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.ExerciseImage?>()) {
      return (data != null ? _i20.ExerciseImage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.ExerciseImageOrder?>()) {
      return (data != null ? _i21.ExerciseImageOrder.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.ExerciseMuscleGroup?>()) {
      return (data != null ? _i22.ExerciseMuscleGroup.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.CreateMicronutrientDto?>()) {
      return (data != null ? _i23.CreateMicronutrientDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i24.CreateServingSizeDto?>()) {
      return (data != null ? _i24.CreateServingSizeDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.FoodCatalogueDto?>()) {
      return (data != null ? _i25.FoodCatalogueDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.FoodCategoryDetailDto?>()) {
      return (data != null ? _i26.FoodCategoryDetailDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i27.SearchEndpointsResponseDto?>()) {
      return (data != null
              ? _i27.SearchEndpointsResponseDto.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i28.DietaryRestriction?>()) {
      return (data != null ? _i28.DietaryRestriction.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i29.Food?>()) {
      return (data != null ? _i29.Food.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.FoodCategory?>()) {
      return (data != null ? _i30.FoodCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.FoodCategoryList?>()) {
      return (data != null ? _i31.FoodCategoryList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.FoodMicronutrient?>()) {
      return (data != null ? _i32.FoodMicronutrient.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.FoodServingSize?>()) {
      return (data != null ? _i33.FoodServingSize.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.UserFoodPreference?>()) {
      return (data != null ? _i34.UserFoodPreference.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i35.UserFoodPreferenceType?>()) {
      return (data != null ? _i35.UserFoodPreferenceType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i36.CreateFoodIntakeLog?>()) {
      return (data != null ? _i36.CreateFoodIntakeLog.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i37.MacrosResponseDto?>()) {
      return (data != null ? _i37.MacrosResponseDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.MealDistributionDto?>()) {
      return (data != null ? _i38.MealDistributionDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i39.MealIndividualDistributionDto?>()) {
      return (data != null
              ? _i39.MealIndividualDistributionDto.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i40.FoodIntakeLog?>()) {
      return (data != null ? _i40.FoodIntakeLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.CreateMealPlanDto?>()) {
      return (data != null ? _i41.CreateMealPlanDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.CreateMealPlanDetailDto?>()) {
      return (data != null ? _i42.CreateMealPlanDetailDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i43.CreateMealPlanFoodDto?>()) {
      return (data != null ? _i43.CreateMealPlanFoodDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i44.CreatedMealPlanDto?>()) {
      return (data != null ? _i44.CreatedMealPlanDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i45.CreatedMealPlanIdDto?>()) {
      return (data != null ? _i45.CreatedMealPlanIdDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i46.CreatedMealPlanTotalsDto?>()) {
      return (data != null
              ? _i46.CreatedMealPlanTotalsDto.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i47.CreatedMealPlanVarianceDto?>()) {
      return (data != null
              ? _i47.CreatedMealPlanVarianceDto.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i48.GenerateNutritionPlanProgressDto?>()) {
      return (data != null
              ? _i48.GenerateNutritionPlanProgressDto.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i49.UpdateMealPlanFoodDto?>()) {
      return (data != null ? _i49.UpdateMealPlanFoodDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i50.MealPlan?>()) {
      return (data != null ? _i50.MealPlan.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.MealPlanFood?>()) {
      return (data != null ? _i51.MealPlanFood.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.MealPlanType?>()) {
      return (data != null ? _i52.MealPlanType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.NutritionPlan?>()) {
      return (data != null ? _i53.NutritionPlan.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.UserFoodPreferencesResponseDto?>()) {
      return (data != null
              ? _i54.UserFoodPreferencesResponseDto.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i55.UserProfile?>()) {
      return (data != null ? _i55.UserProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.AuthMethod?>()) {
      return (data != null ? _i56.AuthMethod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.CreateWorkoutExerciseDto?>()) {
      return (data != null
              ? _i57.CreateWorkoutExerciseDto.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i58.CreateWorkoutPlanDto?>()) {
      return (data != null ? _i58.CreateWorkoutPlanDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i59.CreateWorkoutSessionDto?>()) {
      return (data != null ? _i59.CreateWorkoutSessionDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i60.GenerateWorkoutPlanProgressDto?>()) {
      return (data != null
              ? _i60.GenerateWorkoutPlanProgressDto.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i61.WorkoutProgressMetricsDto?>()) {
      return (data != null
              ? _i61.WorkoutProgressMetricsDto.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i62.WorkoutSessionsByDateDto?>()) {
      return (data != null
              ? _i62.WorkoutSessionsByDateDto.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i63.ExerciseLog?>()) {
      return (data != null ? _i63.ExerciseLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.WorkoutExercise?>()) {
      return (data != null ? _i64.WorkoutExercise.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.WorkoutPlan?>()) {
      return (data != null ? _i65.WorkoutPlan.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i66.WorkoutSession?>()) {
      return (data != null ? _i66.WorkoutSession.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.WorkoutTip?>()) {
      return (data != null ? _i67.WorkoutTip.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i19.ExerciseCategory>) {
      return (data as List)
              .map((e) => deserialize<_i19.ExerciseCategory>(e))
              .toList()
          as T;
    }
    if (t == List<_i22.ExerciseMuscleGroup>) {
      return (data as List)
              .map((e) => deserialize<_i22.ExerciseMuscleGroup>(e))
              .toList()
          as T;
    }
    if (t == List<_i20.ExerciseImage>) {
      return (data as List)
              .map((e) => deserialize<_i20.ExerciseImage>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i20.ExerciseImage>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i20.ExerciseImage>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i18.ExerciseAlternative>) {
      return (data as List)
              .map((e) => deserialize<_i18.ExerciseAlternative>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i18.ExerciseAlternative>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i18.ExerciseAlternative>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i26.FoodCategoryDetailDto>) {
      return (data as List)
              .map((e) => deserialize<_i26.FoodCategoryDetailDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i29.Food>) {
      return (data as List).map((e) => deserialize<_i29.Food>(e)).toList() as T;
    }
    if (t == List<_i32.FoodMicronutrient>) {
      return (data as List)
              .map((e) => deserialize<_i32.FoodMicronutrient>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i32.FoodMicronutrient>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i32.FoodMicronutrient>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i33.FoodServingSize>) {
      return (data as List)
              .map((e) => deserialize<_i33.FoodServingSize>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i33.FoodServingSize>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i33.FoodServingSize>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i30.FoodCategory>) {
      return (data as List)
              .map((e) => deserialize<_i30.FoodCategory>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i30.FoodCategory>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i30.FoodCategory>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == _i1.getType<List<_i29.Food>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<_i29.Food>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i42.CreateMealPlanDetailDto>) {
      return (data as List)
              .map((e) => deserialize<_i42.CreateMealPlanDetailDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i43.CreateMealPlanFoodDto>) {
      return (data as List)
              .map((e) => deserialize<_i43.CreateMealPlanFoodDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i45.CreatedMealPlanIdDto>) {
      return (data as List)
              .map((e) => deserialize<_i45.CreatedMealPlanIdDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i51.MealPlanFood>) {
      return (data as List)
              .map((e) => deserialize<_i51.MealPlanFood>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i51.MealPlanFood>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i51.MealPlanFood>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i50.MealPlan>) {
      return (data as List).map((e) => deserialize<_i50.MealPlan>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i50.MealPlan>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i50.MealPlan>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i34.UserFoodPreference>) {
      return (data as List)
              .map((e) => deserialize<_i34.UserFoodPreference>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i59.CreateWorkoutSessionDto>) {
      return (data as List)
              .map((e) => deserialize<_i59.CreateWorkoutSessionDto>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i59.CreateWorkoutSessionDto>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i59.CreateWorkoutSessionDto>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i57.CreateWorkoutExerciseDto>) {
      return (data as List)
              .map((e) => deserialize<_i57.CreateWorkoutExerciseDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i66.WorkoutSession>) {
      return (data as List)
              .map((e) => deserialize<_i66.WorkoutSession>(e))
              .toList()
          as T;
    }
    if (t == List<_i63.ExerciseLog>) {
      return (data as List)
              .map((e) => deserialize<_i63.ExerciseLog>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i63.ExerciseLog>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i63.ExerciseLog>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == _i1.getType<List<_i66.WorkoutSession>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i66.WorkoutSession>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i64.WorkoutExercise>) {
      return (data as List)
              .map((e) => deserialize<_i64.WorkoutExercise>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i64.WorkoutExercise>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i64.WorkoutExercise>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i68.Exercise>) {
      return (data as List).map((e) => deserialize<_i68.Exercise>(e)).toList()
          as T;
    }
    if (t == List<_i69.ExerciseCategory>) {
      return (data as List)
              .map((e) => deserialize<_i69.ExerciseCategory>(e))
              .toList()
          as T;
    }
    if (t == List<_i70.ExerciseMuscleGroup>) {
      return (data as List)
              .map((e) => deserialize<_i70.ExerciseMuscleGroup>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i71.ExerciseImage>) {
      return (data as List)
              .map((e) => deserialize<_i71.ExerciseImage>(e))
              .toList()
          as T;
    }
    if (t == List<_i72.ExerciseImageOrder>) {
      return (data as List)
              .map((e) => deserialize<_i72.ExerciseImageOrder>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i69.ExerciseCategory>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i69.ExerciseCategory>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == _i1.getType<List<_i70.ExerciseMuscleGroup>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i70.ExerciseMuscleGroup>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i73.ExerciseDifficulty>) {
      return (data as List)
              .map((e) => deserialize<_i73.ExerciseDifficulty>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i73.ExerciseDifficulty>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i73.ExerciseDifficulty>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i74.FoodCategory>) {
      return (data as List)
              .map((e) => deserialize<_i74.FoodCategory>(e))
              .toList()
          as T;
    }
    if (t == List<_i75.Food>) {
      return (data as List).map((e) => deserialize<_i75.Food>(e)).toList() as T;
    }
    if (t == List<_i76.CreateServingSizeDto>) {
      return (data as List)
              .map((e) => deserialize<_i76.CreateServingSizeDto>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i76.CreateServingSizeDto>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i76.CreateServingSizeDto>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i77.CreateMicronutrientDto>) {
      return (data as List)
              .map((e) => deserialize<_i77.CreateMicronutrientDto>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i77.CreateMicronutrientDto>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i77.CreateMicronutrientDto>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i78.FoodIntakeLog>) {
      return (data as List)
              .map((e) => deserialize<_i78.FoodIntakeLog>(e))
              .toList()
          as T;
    }
    if (t == List<_i79.MealPlanType>) {
      return (data as List)
              .map((e) => deserialize<_i79.MealPlanType>(e))
              .toList()
          as T;
    }
    if (t == List<_i80.ExerciseLog>) {
      return (data as List)
              .map((e) => deserialize<_i80.ExerciseLog>(e))
              .toList()
          as T;
    }
    if (t == List<_i81.WorkoutSession>) {
      return (data as List)
              .map((e) => deserialize<_i81.WorkoutSession>(e))
              .toList()
          as T;
    }
    if (t == List<_i82.WorkoutSessionsByDateDto>) {
      return (data as List)
              .map((e) => deserialize<_i82.WorkoutSessionsByDateDto>(e))
              .toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i4.ActivityLevel => 'ActivityLevel',
      _i5.BodyGoal => 'BodyGoal',
      _i6.ExerciseDifficulty => 'ExerciseDifficulty',
      _i7.Sex => 'Sex',
      _i8.Status => 'Status',
      _i9.StreamStatus => 'StreamStatus',
      _i10.StringList => 'StringList',
      _i11.WeightCategory => 'WeightCategory',
      _i12.AppException => 'AppException',
      _i13.GenericException => 'GenericException',
      _i14.WeeklySummaryDto => 'WeeklySummaryDto',
      _i15.EmailTemplate => 'EmailTemplate',
      _i16.EmailTemplatesEnum => 'EmailTemplatesEnum',
      _i17.Exercise => 'Exercise',
      _i18.ExerciseAlternative => 'ExerciseAlternative',
      _i19.ExerciseCategory => 'ExerciseCategory',
      _i20.ExerciseImage => 'ExerciseImage',
      _i21.ExerciseImageOrder => 'ExerciseImageOrder',
      _i22.ExerciseMuscleGroup => 'ExerciseMuscleGroup',
      _i23.CreateMicronutrientDto => 'CreateMicronutrientDto',
      _i24.CreateServingSizeDto => 'CreateServingSizeDto',
      _i25.FoodCatalogueDto => 'FoodCatalogueDto',
      _i26.FoodCategoryDetailDto => 'FoodCategoryDetailDto',
      _i27.SearchEndpointsResponseDto => 'SearchEndpointsResponseDto',
      _i28.DietaryRestriction => 'DietaryRestriction',
      _i29.Food => 'Food',
      _i30.FoodCategory => 'FoodCategory',
      _i31.FoodCategoryList => 'FoodCategoryList',
      _i32.FoodMicronutrient => 'FoodMicronutrient',
      _i33.FoodServingSize => 'FoodServingSize',
      _i34.UserFoodPreference => 'UserFoodPreference',
      _i35.UserFoodPreferenceType => 'UserFoodPreferenceType',
      _i36.CreateFoodIntakeLog => 'CreateFoodIntakeLog',
      _i37.MacrosResponseDto => 'MacrosResponseDto',
      _i38.MealDistributionDto => 'MealDistributionDto',
      _i39.MealIndividualDistributionDto => 'MealIndividualDistributionDto',
      _i40.FoodIntakeLog => 'FoodIntakeLog',
      _i41.CreateMealPlanDto => 'CreateMealPlanDto',
      _i42.CreateMealPlanDetailDto => 'CreateMealPlanDetailDto',
      _i43.CreateMealPlanFoodDto => 'CreateMealPlanFoodDto',
      _i44.CreatedMealPlanDto => 'CreatedMealPlanDto',
      _i45.CreatedMealPlanIdDto => 'CreatedMealPlanIdDto',
      _i46.CreatedMealPlanTotalsDto => 'CreatedMealPlanTotalsDto',
      _i47.CreatedMealPlanVarianceDto => 'CreatedMealPlanVarianceDto',
      _i48.GenerateNutritionPlanProgressDto =>
        'GenerateNutritionPlanProgressDto',
      _i49.UpdateMealPlanFoodDto => 'UpdateMealPlanFoodDto',
      _i50.MealPlan => 'MealPlan',
      _i51.MealPlanFood => 'MealPlanFood',
      _i52.MealPlanType => 'MealPlanType',
      _i53.NutritionPlan => 'NutritionPlan',
      _i54.UserFoodPreferencesResponseDto => 'UserFoodPreferencesResponseDto',
      _i55.UserProfile => 'UserProfile',
      _i56.AuthMethod => 'AuthMethod',
      _i57.CreateWorkoutExerciseDto => 'CreateWorkoutExerciseDto',
      _i58.CreateWorkoutPlanDto => 'CreateWorkoutPlanDto',
      _i59.CreateWorkoutSessionDto => 'CreateWorkoutSessionDto',
      _i60.GenerateWorkoutPlanProgressDto => 'GenerateWorkoutPlanProgressDto',
      _i61.WorkoutProgressMetricsDto => 'WorkoutProgressMetricsDto',
      _i62.WorkoutSessionsByDateDto => 'WorkoutSessionsByDateDto',
      _i63.ExerciseLog => 'ExerciseLog',
      _i64.WorkoutExercise => 'WorkoutExercise',
      _i65.WorkoutPlan => 'WorkoutPlan',
      _i66.WorkoutSession => 'WorkoutSession',
      _i67.WorkoutTip => 'WorkoutTip',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('fitbodyrd.', '');
    }

    switch (data) {
      case _i4.ActivityLevel():
        return 'ActivityLevel';
      case _i5.BodyGoal():
        return 'BodyGoal';
      case _i6.ExerciseDifficulty():
        return 'ExerciseDifficulty';
      case _i7.Sex():
        return 'Sex';
      case _i8.Status():
        return 'Status';
      case _i9.StreamStatus():
        return 'StreamStatus';
      case _i10.StringList():
        return 'StringList';
      case _i11.WeightCategory():
        return 'WeightCategory';
      case _i12.AppException():
        return 'AppException';
      case _i13.GenericException():
        return 'GenericException';
      case _i14.WeeklySummaryDto():
        return 'WeeklySummaryDto';
      case _i15.EmailTemplate():
        return 'EmailTemplate';
      case _i16.EmailTemplatesEnum():
        return 'EmailTemplatesEnum';
      case _i17.Exercise():
        return 'Exercise';
      case _i18.ExerciseAlternative():
        return 'ExerciseAlternative';
      case _i19.ExerciseCategory():
        return 'ExerciseCategory';
      case _i20.ExerciseImage():
        return 'ExerciseImage';
      case _i21.ExerciseImageOrder():
        return 'ExerciseImageOrder';
      case _i22.ExerciseMuscleGroup():
        return 'ExerciseMuscleGroup';
      case _i23.CreateMicronutrientDto():
        return 'CreateMicronutrientDto';
      case _i24.CreateServingSizeDto():
        return 'CreateServingSizeDto';
      case _i25.FoodCatalogueDto():
        return 'FoodCatalogueDto';
      case _i26.FoodCategoryDetailDto():
        return 'FoodCategoryDetailDto';
      case _i27.SearchEndpointsResponseDto():
        return 'SearchEndpointsResponseDto';
      case _i28.DietaryRestriction():
        return 'DietaryRestriction';
      case _i29.Food():
        return 'Food';
      case _i30.FoodCategory():
        return 'FoodCategory';
      case _i31.FoodCategoryList():
        return 'FoodCategoryList';
      case _i32.FoodMicronutrient():
        return 'FoodMicronutrient';
      case _i33.FoodServingSize():
        return 'FoodServingSize';
      case _i34.UserFoodPreference():
        return 'UserFoodPreference';
      case _i35.UserFoodPreferenceType():
        return 'UserFoodPreferenceType';
      case _i36.CreateFoodIntakeLog():
        return 'CreateFoodIntakeLog';
      case _i37.MacrosResponseDto():
        return 'MacrosResponseDto';
      case _i38.MealDistributionDto():
        return 'MealDistributionDto';
      case _i39.MealIndividualDistributionDto():
        return 'MealIndividualDistributionDto';
      case _i40.FoodIntakeLog():
        return 'FoodIntakeLog';
      case _i41.CreateMealPlanDto():
        return 'CreateMealPlanDto';
      case _i42.CreateMealPlanDetailDto():
        return 'CreateMealPlanDetailDto';
      case _i43.CreateMealPlanFoodDto():
        return 'CreateMealPlanFoodDto';
      case _i44.CreatedMealPlanDto():
        return 'CreatedMealPlanDto';
      case _i45.CreatedMealPlanIdDto():
        return 'CreatedMealPlanIdDto';
      case _i46.CreatedMealPlanTotalsDto():
        return 'CreatedMealPlanTotalsDto';
      case _i47.CreatedMealPlanVarianceDto():
        return 'CreatedMealPlanVarianceDto';
      case _i48.GenerateNutritionPlanProgressDto():
        return 'GenerateNutritionPlanProgressDto';
      case _i49.UpdateMealPlanFoodDto():
        return 'UpdateMealPlanFoodDto';
      case _i50.MealPlan():
        return 'MealPlan';
      case _i51.MealPlanFood():
        return 'MealPlanFood';
      case _i52.MealPlanType():
        return 'MealPlanType';
      case _i53.NutritionPlan():
        return 'NutritionPlan';
      case _i54.UserFoodPreferencesResponseDto():
        return 'UserFoodPreferencesResponseDto';
      case _i55.UserProfile():
        return 'UserProfile';
      case _i56.AuthMethod():
        return 'AuthMethod';
      case _i57.CreateWorkoutExerciseDto():
        return 'CreateWorkoutExerciseDto';
      case _i58.CreateWorkoutPlanDto():
        return 'CreateWorkoutPlanDto';
      case _i59.CreateWorkoutSessionDto():
        return 'CreateWorkoutSessionDto';
      case _i60.GenerateWorkoutPlanProgressDto():
        return 'GenerateWorkoutPlanProgressDto';
      case _i61.WorkoutProgressMetricsDto():
        return 'WorkoutProgressMetricsDto';
      case _i62.WorkoutSessionsByDateDto():
        return 'WorkoutSessionsByDateDto';
      case _i63.ExerciseLog():
        return 'ExerciseLog';
      case _i64.WorkoutExercise():
        return 'WorkoutExercise';
      case _i65.WorkoutPlan():
        return 'WorkoutPlan';
      case _i66.WorkoutSession():
        return 'WorkoutSession';
      case _i67.WorkoutTip():
        return 'WorkoutTip';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'ActivityLevel') {
      return deserialize<_i4.ActivityLevel>(data['data']);
    }
    if (dataClassName == 'BodyGoal') {
      return deserialize<_i5.BodyGoal>(data['data']);
    }
    if (dataClassName == 'ExerciseDifficulty') {
      return deserialize<_i6.ExerciseDifficulty>(data['data']);
    }
    if (dataClassName == 'Sex') {
      return deserialize<_i7.Sex>(data['data']);
    }
    if (dataClassName == 'Status') {
      return deserialize<_i8.Status>(data['data']);
    }
    if (dataClassName == 'StreamStatus') {
      return deserialize<_i9.StreamStatus>(data['data']);
    }
    if (dataClassName == 'StringList') {
      return deserialize<_i10.StringList>(data['data']);
    }
    if (dataClassName == 'WeightCategory') {
      return deserialize<_i11.WeightCategory>(data['data']);
    }
    if (dataClassName == 'AppException') {
      return deserialize<_i12.AppException>(data['data']);
    }
    if (dataClassName == 'GenericException') {
      return deserialize<_i13.GenericException>(data['data']);
    }
    if (dataClassName == 'WeeklySummaryDto') {
      return deserialize<_i14.WeeklySummaryDto>(data['data']);
    }
    if (dataClassName == 'EmailTemplate') {
      return deserialize<_i15.EmailTemplate>(data['data']);
    }
    if (dataClassName == 'EmailTemplatesEnum') {
      return deserialize<_i16.EmailTemplatesEnum>(data['data']);
    }
    if (dataClassName == 'Exercise') {
      return deserialize<_i17.Exercise>(data['data']);
    }
    if (dataClassName == 'ExerciseAlternative') {
      return deserialize<_i18.ExerciseAlternative>(data['data']);
    }
    if (dataClassName == 'ExerciseCategory') {
      return deserialize<_i19.ExerciseCategory>(data['data']);
    }
    if (dataClassName == 'ExerciseImage') {
      return deserialize<_i20.ExerciseImage>(data['data']);
    }
    if (dataClassName == 'ExerciseImageOrder') {
      return deserialize<_i21.ExerciseImageOrder>(data['data']);
    }
    if (dataClassName == 'ExerciseMuscleGroup') {
      return deserialize<_i22.ExerciseMuscleGroup>(data['data']);
    }
    if (dataClassName == 'CreateMicronutrientDto') {
      return deserialize<_i23.CreateMicronutrientDto>(data['data']);
    }
    if (dataClassName == 'CreateServingSizeDto') {
      return deserialize<_i24.CreateServingSizeDto>(data['data']);
    }
    if (dataClassName == 'FoodCatalogueDto') {
      return deserialize<_i25.FoodCatalogueDto>(data['data']);
    }
    if (dataClassName == 'FoodCategoryDetailDto') {
      return deserialize<_i26.FoodCategoryDetailDto>(data['data']);
    }
    if (dataClassName == 'SearchEndpointsResponseDto') {
      return deserialize<_i27.SearchEndpointsResponseDto>(data['data']);
    }
    if (dataClassName == 'DietaryRestriction') {
      return deserialize<_i28.DietaryRestriction>(data['data']);
    }
    if (dataClassName == 'Food') {
      return deserialize<_i29.Food>(data['data']);
    }
    if (dataClassName == 'FoodCategory') {
      return deserialize<_i30.FoodCategory>(data['data']);
    }
    if (dataClassName == 'FoodCategoryList') {
      return deserialize<_i31.FoodCategoryList>(data['data']);
    }
    if (dataClassName == 'FoodMicronutrient') {
      return deserialize<_i32.FoodMicronutrient>(data['data']);
    }
    if (dataClassName == 'FoodServingSize') {
      return deserialize<_i33.FoodServingSize>(data['data']);
    }
    if (dataClassName == 'UserFoodPreference') {
      return deserialize<_i34.UserFoodPreference>(data['data']);
    }
    if (dataClassName == 'UserFoodPreferenceType') {
      return deserialize<_i35.UserFoodPreferenceType>(data['data']);
    }
    if (dataClassName == 'CreateFoodIntakeLog') {
      return deserialize<_i36.CreateFoodIntakeLog>(data['data']);
    }
    if (dataClassName == 'MacrosResponseDto') {
      return deserialize<_i37.MacrosResponseDto>(data['data']);
    }
    if (dataClassName == 'MealDistributionDto') {
      return deserialize<_i38.MealDistributionDto>(data['data']);
    }
    if (dataClassName == 'MealIndividualDistributionDto') {
      return deserialize<_i39.MealIndividualDistributionDto>(data['data']);
    }
    if (dataClassName == 'FoodIntakeLog') {
      return deserialize<_i40.FoodIntakeLog>(data['data']);
    }
    if (dataClassName == 'CreateMealPlanDto') {
      return deserialize<_i41.CreateMealPlanDto>(data['data']);
    }
    if (dataClassName == 'CreateMealPlanDetailDto') {
      return deserialize<_i42.CreateMealPlanDetailDto>(data['data']);
    }
    if (dataClassName == 'CreateMealPlanFoodDto') {
      return deserialize<_i43.CreateMealPlanFoodDto>(data['data']);
    }
    if (dataClassName == 'CreatedMealPlanDto') {
      return deserialize<_i44.CreatedMealPlanDto>(data['data']);
    }
    if (dataClassName == 'CreatedMealPlanIdDto') {
      return deserialize<_i45.CreatedMealPlanIdDto>(data['data']);
    }
    if (dataClassName == 'CreatedMealPlanTotalsDto') {
      return deserialize<_i46.CreatedMealPlanTotalsDto>(data['data']);
    }
    if (dataClassName == 'CreatedMealPlanVarianceDto') {
      return deserialize<_i47.CreatedMealPlanVarianceDto>(data['data']);
    }
    if (dataClassName == 'GenerateNutritionPlanProgressDto') {
      return deserialize<_i48.GenerateNutritionPlanProgressDto>(data['data']);
    }
    if (dataClassName == 'UpdateMealPlanFoodDto') {
      return deserialize<_i49.UpdateMealPlanFoodDto>(data['data']);
    }
    if (dataClassName == 'MealPlan') {
      return deserialize<_i50.MealPlan>(data['data']);
    }
    if (dataClassName == 'MealPlanFood') {
      return deserialize<_i51.MealPlanFood>(data['data']);
    }
    if (dataClassName == 'MealPlanType') {
      return deserialize<_i52.MealPlanType>(data['data']);
    }
    if (dataClassName == 'NutritionPlan') {
      return deserialize<_i53.NutritionPlan>(data['data']);
    }
    if (dataClassName == 'UserFoodPreferencesResponseDto') {
      return deserialize<_i54.UserFoodPreferencesResponseDto>(data['data']);
    }
    if (dataClassName == 'UserProfile') {
      return deserialize<_i55.UserProfile>(data['data']);
    }
    if (dataClassName == 'AuthMethod') {
      return deserialize<_i56.AuthMethod>(data['data']);
    }
    if (dataClassName == 'CreateWorkoutExerciseDto') {
      return deserialize<_i57.CreateWorkoutExerciseDto>(data['data']);
    }
    if (dataClassName == 'CreateWorkoutPlanDto') {
      return deserialize<_i58.CreateWorkoutPlanDto>(data['data']);
    }
    if (dataClassName == 'CreateWorkoutSessionDto') {
      return deserialize<_i59.CreateWorkoutSessionDto>(data['data']);
    }
    if (dataClassName == 'GenerateWorkoutPlanProgressDto') {
      return deserialize<_i60.GenerateWorkoutPlanProgressDto>(data['data']);
    }
    if (dataClassName == 'WorkoutProgressMetricsDto') {
      return deserialize<_i61.WorkoutProgressMetricsDto>(data['data']);
    }
    if (dataClassName == 'WorkoutSessionsByDateDto') {
      return deserialize<_i62.WorkoutSessionsByDateDto>(data['data']);
    }
    if (dataClassName == 'ExerciseLog') {
      return deserialize<_i63.ExerciseLog>(data['data']);
    }
    if (dataClassName == 'WorkoutExercise') {
      return deserialize<_i64.WorkoutExercise>(data['data']);
    }
    if (dataClassName == 'WorkoutPlan') {
      return deserialize<_i65.WorkoutPlan>(data['data']);
    }
    if (dataClassName == 'WorkoutSession') {
      return deserialize<_i66.WorkoutSession>(data['data']);
    }
    if (dataClassName == 'WorkoutTip') {
      return deserialize<_i67.WorkoutTip>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i3.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i15.EmailTemplate:
        return _i15.EmailTemplate.t;
      case _i17.Exercise:
        return _i17.Exercise.t;
      case _i18.ExerciseAlternative:
        return _i18.ExerciseAlternative.t;
      case _i20.ExerciseImage:
        return _i20.ExerciseImage.t;
      case _i29.Food:
        return _i29.Food.t;
      case _i30.FoodCategory:
        return _i30.FoodCategory.t;
      case _i32.FoodMicronutrient:
        return _i32.FoodMicronutrient.t;
      case _i33.FoodServingSize:
        return _i33.FoodServingSize.t;
      case _i34.UserFoodPreference:
        return _i34.UserFoodPreference.t;
      case _i40.FoodIntakeLog:
        return _i40.FoodIntakeLog.t;
      case _i50.MealPlan:
        return _i50.MealPlan.t;
      case _i51.MealPlanFood:
        return _i51.MealPlanFood.t;
      case _i53.NutritionPlan:
        return _i53.NutritionPlan.t;
      case _i55.UserProfile:
        return _i55.UserProfile.t;
      case _i63.ExerciseLog:
        return _i63.ExerciseLog.t;
      case _i64.WorkoutExercise:
        return _i64.WorkoutExercise.t;
      case _i65.WorkoutPlan:
        return _i65.WorkoutPlan.t;
      case _i66.WorkoutSession:
        return _i66.WorkoutSession.t;
      case _i67.WorkoutTip:
        return _i67.WorkoutTip.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'fitbodyrd';
}
