/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_local_identifiers

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_test/serverpod_test.dart' as _i1;
import 'package:serverpod/serverpod.dart' as _i2;
import 'dart:async' as _i3;
import 'package:fitbodyrd_server/src/generated/features/dashboard/dto/weekly_summary.dto.dart'
    as _i4;
import 'package:fitbodyrd_server/src/generated/features/exercise/models/exercise.dart'
    as _i5;
import 'package:fitbodyrd_server/src/generated/features/exercise/models/exercise_category.dart'
    as _i6;
import 'package:fitbodyrd_server/src/generated/features/exercise/models/exercise_muscle_group.dart'
    as _i7;
import 'package:fitbodyrd_server/src/generated/common/models/exercise_difficulty.dart'
    as _i8;
import 'package:fitbodyrd_server/src/generated/features/exercise/models/exercise_image.dart'
    as _i9;
import 'package:fitbodyrd_server/src/generated/features/exercise/models/exercise_image_order.dart'
    as _i10;
import 'package:fitbodyrd_server/src/generated/common/models/string_list.dart'
    as _i11;
import 'package:fitbodyrd_server/src/generated/features/food/models/food_category.dart'
    as _i12;
import 'package:fitbodyrd_server/src/generated/features/food/models/food.dart'
    as _i13;
import 'package:fitbodyrd_server/src/generated/features/food/dto/create_serving_size.dto.dart'
    as _i14;
import 'package:fitbodyrd_server/src/generated/features/food/dto/create_micronutrient.dto.dart'
    as _i15;
import 'package:fitbodyrd_server/src/generated/features/food/models/food_serving_size.dart'
    as _i16;
import 'package:fitbodyrd_server/src/generated/features/food/models/food_micronutrient.dart'
    as _i17;
import 'package:fitbodyrd_server/src/generated/features/food/dto/search_endpoints_response.dto.dart'
    as _i18;
import 'package:fitbodyrd_server/src/generated/features/food/models/dietary_restriction.dart'
    as _i19;
import 'package:fitbodyrd_server/src/generated/features/food/dto/food_catalogue.dto.dart'
    as _i20;
import 'package:fitbodyrd_server/src/generated/features/nutrition/models/food_intake_log.dart'
    as _i21;
import 'package:fitbodyrd_server/src/generated/features/nutrition/dto/create_food_intake_log.dto.dart'
    as _i22;
import 'package:fitbodyrd_server/src/generated/features/nutrition/dto/macros_response.dto.dart'
    as _i23;
import 'package:fitbodyrd_server/src/generated/features/nutrition_plan/models/meal_type.dart'
    as _i24;
import 'package:fitbodyrd_server/src/generated/features/nutrition_plan/models/nutrition_plan.dart'
    as _i25;
import 'package:fitbodyrd_server/src/generated/features/nutrition_plan/dto/created_meal_plan.dto.dart'
    as _i26;
import 'package:fitbodyrd_server/src/generated/features/nutrition_plan/dto/create_meal_plan.dto.dart'
    as _i27;
import 'package:fitbodyrd_server/src/generated/features/nutrition_plan/dto/generate_nutrition_plan_progress.dto.dart'
    as _i28;
import 'package:fitbodyrd_server/src/generated/common/models/stream_status.dart'
    as _i29;
import 'package:fitbodyrd_server/src/generated/features/nutrition_plan/models/meal_plan_food.dart'
    as _i30;
import 'package:fitbodyrd_server/src/generated/features/nutrition_plan/dto/update_meal_plan_food.dto.dart'
    as _i31;
import 'package:fitbodyrd_server/src/generated/features/user/models/app_user.dart'
    as _i32;
import 'package:fitbodyrd_server/src/generated/features/user/dto/user_food_preferences_response.dto.dart'
    as _i33;
import 'package:fitbodyrd_server/src/generated/features/user/models/auth_method.dart'
    as _i34;
import 'package:fitbodyrd_server/src/generated/features/workouts/models/workout_plan.dart'
    as _i35;
import 'package:fitbodyrd_server/src/generated/features/workouts/models/exercise_log.dart'
    as _i36;
import 'package:fitbodyrd_server/src/generated/features/workouts/dto/create_workout_session.dto.dart'
    as _i37;
import 'package:fitbodyrd_server/src/generated/features/workouts/dto/create_workout_plan.dto.dart'
    as _i38;
import 'package:fitbodyrd_server/src/generated/features/workouts/dto/generate_workout_plan_progress.dto.dart'
    as _i39;
import 'package:fitbodyrd_server/src/generated/features/workouts/models/workout_session.dart'
    as _i40;
import 'package:fitbodyrd_server/src/generated/features/workouts/dto/workout_progress_metrics.dto.dart'
    as _i41;
import 'package:fitbodyrd_server/src/generated/features/workouts/dto/workout_sessions_by_date.dto.dart'
    as _i42;
import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:fitbodyrd_server/src/generated/endpoints.dart';
export 'package:serverpod_test/serverpod_test_public_exports.dart';

/// Creates a new test group that takes a callback that can be used to write tests.
/// The callback has two parameters: `sessionBuilder` and `endpoints`.
/// `sessionBuilder` is used to build a `Session` object that represents the server state during an endpoint call and is used to set up scenarios.
/// `endpoints` contains all your Serverpod endpoints and lets you call them:
/// ```dart
/// withServerpod('Given Example endpoint', (sessionBuilder, endpoints) {
///   test('when calling `hello` then should return greeting', () async {
///     final greeting = await endpoints.example.hello(sessionBuilder, 'Michael');
///     expect(greeting, 'Hello Michael');
///   });
/// });
/// ```
///
/// **Configuration options**
///
/// [applyMigrations] Whether pending migrations should be applied when starting Serverpod. Defaults to `true`
///
/// [enableSessionLogging] Whether session logging should be enabled. Defaults to `false`
///
/// [rollbackDatabase] Options for when to rollback the database during the test lifecycle.
/// By default `withServerpod` does all database operations inside a transaction that is rolled back after each `test` case.
/// Just like the following enum describes, the behavior of the automatic rollbacks can be configured:
/// ```dart
/// /// Options for when to rollback the database during the test lifecycle.
/// enum RollbackDatabase {
///   /// After each test. This is the default.
///   afterEach,
///
///   /// After all tests.
///   afterAll,
///
///   /// Disable rolling back the database.
///   disabled,
/// }
/// ```
///
/// [runMode] The run mode that Serverpod should be running in. Defaults to `test`.
///
/// [serverpodLoggingMode] The logging mode used when creating Serverpod. Defaults to `ServerpodLoggingMode.normal`
///
/// [serverpodStartTimeout] The timeout to use when starting Serverpod, which connects to the database among other things. Defaults to `Duration(seconds: 30)`.
///
/// [testServerOutputMode] Options for controlling test server output during test execution. Defaults to `TestServerOutputMode.normal`.
/// ```dart
/// /// Options for controlling test server output during test execution.
/// enum TestServerOutputMode {
///   /// Default mode - only stderr is printed (stdout suppressed).
///   /// This hides normal startup/shutdown logs while preserving error messages.
///   normal,
///
///   /// All logging - both stdout and stderr are printed.
///   /// Useful for debugging when you need to see all server output.
///   verbose,
///
///   /// No logging - both stdout and stderr are suppressed.
///   /// Completely silent mode, useful when you don't want any server output.
///   silent,
/// }
/// ```
///
/// [testGroupTagsOverride] By default Serverpod test tools tags the `withServerpod` test group with `"integration"`.
/// This is to provide a simple way to only run unit or integration tests.
/// This property allows this tag to be overridden to something else. Defaults to `['integration']`.
///
/// [experimentalFeatures] Optionally specify experimental features. See [Serverpod] for more information.
@_i1.isTestGroup
void withServerpod(
  String testGroupName,
  _i1.TestClosure<TestEndpoints> testClosure, {
  bool? applyMigrations,
  bool? enableSessionLogging,
  _i2.ExperimentalFeatures? experimentalFeatures,
  _i1.RollbackDatabase? rollbackDatabase,
  String? runMode,
  _i2.RuntimeParametersListBuilder? runtimeParametersBuilder,
  _i2.ServerpodLoggingMode? serverpodLoggingMode,
  Duration? serverpodStartTimeout,
  List<String>? testGroupTagsOverride,
  _i1.TestServerOutputMode? testServerOutputMode,
}) {
  _i1.buildWithServerpod<_InternalTestEndpoints>(
    testGroupName,
    _i1.TestServerpod(
      testEndpoints: _InternalTestEndpoints(),
      endpoints: Endpoints(),
      serializationManager: Protocol(),
      runMode: runMode,
      applyMigrations: applyMigrations,
      isDatabaseEnabled: true,
      serverpodLoggingMode: serverpodLoggingMode,
      testServerOutputMode: testServerOutputMode,
      experimentalFeatures: experimentalFeatures,
      runtimeParametersBuilder: runtimeParametersBuilder,
    ),
    maybeRollbackDatabase: rollbackDatabase,
    maybeEnableSessionLogging: enableSessionLogging,
    maybeTestGroupTagsOverride: testGroupTagsOverride,
    maybeServerpodStartTimeout: serverpodStartTimeout,
    maybeTestServerOutputMode: testServerOutputMode,
  )(testClosure);
}

class TestEndpoints {
  late final _DashboardEndpoint dashboard;

  late final _ExerciseEndpoint exercise;

  late final _FoodEndpoint food;

  late final _FoodIntakeLogEndpoint foodIntakeLog;

  late final _NutritionEndpoint nutrition;

  late final _NutritionPlanEndpoint nutritionPlan;

  late final _AdminUserEndpoint adminUser;

  late final _UserEndpoint user;

  late final _WorkoutEndpoint workout;
}

class _InternalTestEndpoints extends TestEndpoints
    implements _i1.InternalTestEndpoints {
  @override
  void initialize(
    _i2.SerializationManager serializationManager,
    _i2.EndpointDispatch endpoints,
  ) {
    dashboard = _DashboardEndpoint(
      endpoints,
      serializationManager,
    );
    exercise = _ExerciseEndpoint(
      endpoints,
      serializationManager,
    );
    food = _FoodEndpoint(
      endpoints,
      serializationManager,
    );
    foodIntakeLog = _FoodIntakeLogEndpoint(
      endpoints,
      serializationManager,
    );
    nutrition = _NutritionEndpoint(
      endpoints,
      serializationManager,
    );
    nutritionPlan = _NutritionPlanEndpoint(
      endpoints,
      serializationManager,
    );
    adminUser = _AdminUserEndpoint(
      endpoints,
      serializationManager,
    );
    user = _UserEndpoint(
      endpoints,
      serializationManager,
    );
    workout = _WorkoutEndpoint(
      endpoints,
      serializationManager,
    );
  }
}

class _DashboardEndpoint {
  _DashboardEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i4.WeeklySummaryDto> getWeeklySummary(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'dashboard',
            method: 'getWeeklySummary',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'dashboard',
          methodName: 'getWeeklySummary',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i4.WeeklySummaryDto>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _ExerciseEndpoint {
  _ExerciseEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i5.Exercise>> getAllExercises(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'exercise',
            method: 'getAllExercises',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'exercise',
          methodName: 'getAllExercises',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i5.Exercise>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i5.Exercise> getExerciseById(
    _i1.TestSessionBuilder sessionBuilder,
    int id,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'exercise',
            method: 'getExerciseById',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'exercise',
          methodName: 'getExerciseById',
          parameters: _i1.testObjectToJson({'id': id}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i5.Exercise>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i5.Exercise> createExercise(
    _i1.TestSessionBuilder sessionBuilder, {
    required String name,
    String? description,
    required List<_i6.ExerciseCategory> category,
    required List<_i7.ExerciseMuscleGroup> muscleGroup,
    required _i8.ExerciseDifficulty difficulty,
    bool? requiresEquipment,
    String? equipmentNeeded,
    String? videoUrl,
    List<String>? images,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'exercise',
            method: 'createExercise',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'exercise',
          methodName: 'createExercise',
          parameters: _i1.testObjectToJson({
            'name': name,
            'description': description,
            'category': category,
            'muscleGroup': muscleGroup,
            'difficulty': difficulty,
            'requiresEquipment': requiresEquipment,
            'equipmentNeeded': equipmentNeeded,
            'videoUrl': videoUrl,
            'images': images,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i5.Exercise>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i5.Exercise> updateExercise(
    _i1.TestSessionBuilder sessionBuilder,
    _i5.Exercise exercise,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'exercise',
            method: 'updateExercise',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'exercise',
          methodName: 'updateExercise',
          parameters: _i1.testObjectToJson({'exercise': exercise}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i5.Exercise>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> deleteExercise(
    _i1.TestSessionBuilder sessionBuilder,
    int id,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'exercise',
            method: 'deleteExercise',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'exercise',
          methodName: 'deleteExercise',
          parameters: _i1.testObjectToJson({'id': id}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i9.ExerciseImage>> getExerciseImages(
    _i1.TestSessionBuilder sessionBuilder,
    int exerciseId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'exercise',
            method: 'getExerciseImages',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'exercise',
          methodName: 'getExerciseImages',
          parameters: _i1.testObjectToJson({'exerciseId': exerciseId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i9.ExerciseImage>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i9.ExerciseImage> addExerciseImage(
    _i1.TestSessionBuilder sessionBuilder, {
    required int exerciseId,
    required String imageUrl,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'exercise',
            method: 'addExerciseImage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'exercise',
          methodName: 'addExerciseImage',
          parameters: _i1.testObjectToJson({
            'exerciseId': exerciseId,
            'imageUrl': imageUrl,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i9.ExerciseImage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> deleteExerciseImage(
    _i1.TestSessionBuilder sessionBuilder,
    int imageId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'exercise',
            method: 'deleteExerciseImage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'exercise',
          methodName: 'deleteExerciseImage',
          parameters: _i1.testObjectToJson({'imageId': imageId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i9.ExerciseImage>> reorderImages(
    _i1.TestSessionBuilder sessionBuilder,
    int exerciseId,
    List<_i10.ExerciseImageOrder> newOrder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'exercise',
            method: 'reorderImages',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'exercise',
          methodName: 'reorderImages',
          parameters: _i1.testObjectToJson({
            'exerciseId': exerciseId,
            'newOrder': newOrder,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i9.ExerciseImage>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.StringList> getAllExerciseNames(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'exercise',
            method: 'getAllExerciseNames',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'exercise',
          methodName: 'getAllExerciseNames',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.StringList>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i5.Exercise>> searchExercises(
    _i1.TestSessionBuilder sessionBuilder, {
    List<_i6.ExerciseCategory>? categoriesIn,
    List<_i7.ExerciseMuscleGroup>? muscleGroupsIn,
    List<_i8.ExerciseDifficulty>? difficultiesIn,
    bool? includeExercisesRequiringEquipment,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'exercise',
            method: 'searchExercises',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'exercise',
          methodName: 'searchExercises',
          parameters: _i1.testObjectToJson({
            'categoriesIn': categoriesIn,
            'muscleGroupsIn': muscleGroupsIn,
            'difficultiesIn': difficultiesIn,
            'includeExercisesRequiringEquipment':
                includeExercisesRequiringEquipment,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i5.Exercise>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _FoodEndpoint {
  _FoodEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i12.FoodCategory>> getAllFoodCategories(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'food',
            method: 'getAllFoodCategories',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'food',
          methodName: 'getAllFoodCategories',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i12.FoodCategory>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i12.FoodCategory>> getParentFoodCategories(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'food',
            method: 'getParentFoodCategories',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'food',
          methodName: 'getParentFoodCategories',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i12.FoodCategory>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i12.FoodCategory> getFoodCategoryById(
    _i1.TestSessionBuilder sessionBuilder,
    int foodCategoryId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'food',
            method: 'getFoodCategoryById',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'food',
          methodName: 'getFoodCategoryById',
          parameters: _i1.testObjectToJson({'foodCategoryId': foodCategoryId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i12.FoodCategory>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i12.FoodCategory> createFoodCategory(
    _i1.TestSessionBuilder sessionBuilder, {
    required String name,
    required String slug,
    required String colorHex,
    required int displayOrder,
    required String iconName,
    int? parentCategoryId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'food',
            method: 'createFoodCategory',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'food',
          methodName: 'createFoodCategory',
          parameters: _i1.testObjectToJson({
            'name': name,
            'slug': slug,
            'colorHex': colorHex,
            'displayOrder': displayOrder,
            'iconName': iconName,
            'parentCategoryId': parentCategoryId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i12.FoodCategory>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i12.FoodCategory> updateFoodCategory(
    _i1.TestSessionBuilder sessionBuilder,
    int categoryId, {
    String? name,
    String? slug,
    String? colorHex,
    int? displayOrder,
    String? iconName,
    int? parentCategoryId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'food',
            method: 'updateFoodCategory',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'food',
          methodName: 'updateFoodCategory',
          parameters: _i1.testObjectToJson({
            'categoryId': categoryId,
            'name': name,
            'slug': slug,
            'colorHex': colorHex,
            'displayOrder': displayOrder,
            'iconName': iconName,
            'parentCategoryId': parentCategoryId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i12.FoodCategory>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> deleteFoodCategory(
    _i1.TestSessionBuilder sessionBuilder,
    int categoryId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'food',
            method: 'deleteFoodCategory',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'food',
          methodName: 'deleteFoodCategory',
          parameters: _i1.testObjectToJson({'categoryId': categoryId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i13.Food>> getFoods(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'food',
            method: 'getFoods',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'food',
          methodName: 'getFoods',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i13.Food>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i13.Food> getFoodById(
    _i1.TestSessionBuilder sessionBuilder,
    int foodId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'food',
            method: 'getFoodById',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'food',
          methodName: 'getFoodById',
          parameters: _i1.testObjectToJson({'foodId': foodId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i13.Food>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i13.Food> createFood(
    _i1.TestSessionBuilder sessionBuilder, {
    required String name,
    required int categoryId,
    required double calories,
    required double proteins,
    required double carbs,
    required double fats,
    required double fiber,
    required bool isLocal,
    String? brand,
    String? imageUrl,
    String? barcode,
    List<_i14.CreateServingSizeDto>? servingSizes,
    List<_i15.CreateMicronutrientDto>? micronutrients,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'food',
            method: 'createFood',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'food',
          methodName: 'createFood',
          parameters: _i1.testObjectToJson({
            'name': name,
            'categoryId': categoryId,
            'calories': calories,
            'proteins': proteins,
            'carbs': carbs,
            'fats': fats,
            'fiber': fiber,
            'isLocal': isLocal,
            'brand': brand,
            'imageUrl': imageUrl,
            'barcode': barcode,
            'servingSizes': servingSizes,
            'micronutrients': micronutrients,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i13.Food>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i13.Food> updateFood(
    _i1.TestSessionBuilder sessionBuilder,
    int foodId, {
    String? name,
    int? categoryId,
    double? calories,
    double? proteins,
    double? carbs,
    double? fats,
    double? fiber,
    bool? isLocal,
    String? brand,
    String? imageUrl,
    String? barcode,
    bool? isActive,
    List<_i14.CreateServingSizeDto>? servingSizes,
    List<_i15.CreateMicronutrientDto>? micronutrients,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'food',
            method: 'updateFood',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'food',
          methodName: 'updateFood',
          parameters: _i1.testObjectToJson({
            'foodId': foodId,
            'name': name,
            'categoryId': categoryId,
            'calories': calories,
            'proteins': proteins,
            'carbs': carbs,
            'fats': fats,
            'fiber': fiber,
            'isLocal': isLocal,
            'brand': brand,
            'imageUrl': imageUrl,
            'barcode': barcode,
            'isActive': isActive,
            'servingSizes': servingSizes,
            'micronutrients': micronutrients,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i13.Food>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> deleteFood(
    _i1.TestSessionBuilder sessionBuilder,
    int foodId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'food',
            method: 'deleteFood',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'food',
          methodName: 'deleteFood',
          parameters: _i1.testObjectToJson({'foodId': foodId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i16.FoodServingSize> createFoodServingSize(
    _i1.TestSessionBuilder sessionBuilder, {
    required int foodId,
    required String name,
    required double grams,
    required bool isDefault,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'food',
            method: 'createFoodServingSize',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'food',
          methodName: 'createFoodServingSize',
          parameters: _i1.testObjectToJson({
            'foodId': foodId,
            'name': name,
            'grams': grams,
            'isDefault': isDefault,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i16.FoodServingSize>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i16.FoodServingSize> updateFoodServingSize(
    _i1.TestSessionBuilder sessionBuilder,
    int servingSizeId, {
    String? name,
    double? grams,
    bool? isDefault,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'food',
            method: 'updateFoodServingSize',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'food',
          methodName: 'updateFoodServingSize',
          parameters: _i1.testObjectToJson({
            'servingSizeId': servingSizeId,
            'name': name,
            'grams': grams,
            'isDefault': isDefault,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i16.FoodServingSize>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> deleteFoodServingSize(
    _i1.TestSessionBuilder sessionBuilder,
    int servingSizeId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'food',
            method: 'deleteFoodServingSize',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'food',
          methodName: 'deleteFoodServingSize',
          parameters: _i1.testObjectToJson({'servingSizeId': servingSizeId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i17.FoodMicronutrient> createFoodMicronutrient(
    _i1.TestSessionBuilder sessionBuilder, {
    required int foodId,
    required String name,
    required double amount,
    required String unit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'food',
            method: 'createFoodMicronutrient',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'food',
          methodName: 'createFoodMicronutrient',
          parameters: _i1.testObjectToJson({
            'foodId': foodId,
            'name': name,
            'amount': amount,
            'unit': unit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i17.FoodMicronutrient>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i17.FoodMicronutrient> updateFoodMicronutrient(
    _i1.TestSessionBuilder sessionBuilder,
    int micronutrientId, {
    String? name,
    double? amount,
    String? unit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'food',
            method: 'updateFoodMicronutrient',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'food',
          methodName: 'updateFoodMicronutrient',
          parameters: _i1.testObjectToJson({
            'micronutrientId': micronutrientId,
            'name': name,
            'amount': amount,
            'unit': unit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i17.FoodMicronutrient>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> deleteFoodMicronutrient(
    _i1.TestSessionBuilder sessionBuilder,
    int micronutrientId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'food',
            method: 'deleteFoodMicronutrient',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'food',
          methodName: 'deleteFoodMicronutrient',
          parameters: _i1.testObjectToJson({
            'micronutrientId': micronutrientId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i18.SearchEndpointsResponseDto> searchFoods(
    _i1.TestSessionBuilder sessionBuilder, {
    required int categoryId,
    _i19.DietaryRestriction? dietaryRestriction,
    bool? isLocalOnly,
    List<int>? excludeFoodIds,
    int? limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'food',
            method: 'searchFoods',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'food',
          methodName: 'searchFoods',
          parameters: _i1.testObjectToJson({
            'categoryId': categoryId,
            'dietaryRestriction': dietaryRestriction,
            'isLocalOnly': isLocalOnly,
            'excludeFoodIds': excludeFoodIds,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i18.SearchEndpointsResponseDto>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i18.SearchEndpointsResponseDto> searchFoodsV2(
    _i1.TestSessionBuilder sessionBuilder, {
    required String query,
    int? categoryId,
    int? limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'food',
            method: 'searchFoodsV2',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'food',
          methodName: 'searchFoodsV2',
          parameters: _i1.testObjectToJson({
            'query': query,
            'categoryId': categoryId,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i18.SearchEndpointsResponseDto>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i20.FoodCatalogueDto> getFoodCatalogue(
    _i1.TestSessionBuilder sessionBuilder,
    List<int> excludeFoodIds,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'food',
            method: 'getFoodCatalogue',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'food',
          methodName: 'getFoodCatalogue',
          parameters: _i1.testObjectToJson({'excludeFoodIds': excludeFoodIds}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i20.FoodCatalogueDto>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _FoodIntakeLogEndpoint {
  _FoodIntakeLogEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i21.FoodIntakeLog> create(
    _i1.TestSessionBuilder sessionBuilder,
    _i22.CreateFoodIntakeLog dto,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'foodIntakeLog',
            method: 'create',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'foodIntakeLog',
          methodName: 'create',
          parameters: _i1.testObjectToJson({'dto': dto}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i21.FoodIntakeLog>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> delete(
    _i1.TestSessionBuilder sessionBuilder,
    int id,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'foodIntakeLog',
            method: 'delete',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'foodIntakeLog',
          methodName: 'delete',
          parameters: _i1.testObjectToJson({'id': id}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i21.FoodIntakeLog>> getByDate(
    _i1.TestSessionBuilder sessionBuilder,
    DateTime date,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'foodIntakeLog',
            method: 'getByDate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'foodIntakeLog',
          methodName: 'getByDate',
          parameters: _i1.testObjectToJson({'date': date}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i21.FoodIntakeLog>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _NutritionEndpoint {
  _NutritionEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i23.MacrosResponseDto> calculateMacros(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
    List<_i24.MealPlanType> mealTypes,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'nutrition',
            method: 'calculateMacros',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'nutrition',
          methodName: 'calculateMacros',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'mealTypes': mealTypes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i23.MacrosResponseDto>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _NutritionPlanEndpoint {
  _NutritionPlanEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i25.NutritionPlan> createNutritionPlan(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required DateTime startDate,
    required DateTime endDate,
    required double dailyCalories,
    required double dailyProteins,
    required double dailyCarbs,
    required double dailyFats,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'nutritionPlan',
            method: 'createNutritionPlan',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'nutritionPlan',
          methodName: 'createNutritionPlan',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'startDate': startDate,
            'endDate': endDate,
            'dailyCalories': dailyCalories,
            'dailyProteins': dailyProteins,
            'dailyCarbs': dailyCarbs,
            'dailyFats': dailyFats,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i25.NutritionPlan>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i25.NutritionPlan> getNutritionPlanById(
    _i1.TestSessionBuilder sessionBuilder,
    int planId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'nutritionPlan',
            method: 'getNutritionPlanById',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'nutritionPlan',
          methodName: 'getNutritionPlanById',
          parameters: _i1.testObjectToJson({'planId': planId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i25.NutritionPlan>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i26.CreatedMealPlanDto> createMealPlan(
    _i1.TestSessionBuilder sessionBuilder,
    _i27.CreateMealPlanDto mealPlanDto,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'nutritionPlan',
            method: 'createMealPlan',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'nutritionPlan',
          methodName: 'createMealPlan',
          parameters: _i1.testObjectToJson({'mealPlanDto': mealPlanDto}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i26.CreatedMealPlanDto>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i28.GenerateNutritionPlanProgressDto> updateNutritionPlanProgress(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int nutritionPlanId,
    required int currentDay,
    required int totalDays,
    required _i29.StreamStatus status,
    required String message,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'nutritionPlan',
            method: 'updateNutritionPlanProgress',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'nutritionPlan',
          methodName: 'updateNutritionPlanProgress',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'nutritionPlanId': nutritionPlanId,
            'currentDay': currentDay,
            'totalDays': totalDays,
            'status': status,
            'message': message,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i28.GenerateNutritionPlanProgressDto>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Stream<_i28.GenerateNutritionPlanProgressDto>
  requestNutritionPlanGeneration(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
    int weeks,
    List<_i24.MealPlanType> mealTypes,
  ) {
    var _localTestStreamManager =
        _i1.TestStreamManager<_i28.GenerateNutritionPlanProgressDto>();
    _i1.callStreamFunctionAndHandleExceptions(
      () async {
        var _localUniqueSession =
            (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
              endpoint: 'nutritionPlan',
              method: 'requestNutritionPlanGeneration',
            );
        var _localCallContext = await _endpointDispatch
            .getMethodStreamCallContext(
              createSessionCallback: (_) => _localUniqueSession,
              endpointPath: 'nutritionPlan',
              methodName: 'requestNutritionPlanGeneration',
              arguments: {
                'userId': userId,
                'weeks': weeks,
                'mealTypes': mealTypes,
              },
              requestedInputStreams: [],
              serializationManager: _serializationManager,
            );
        await _localTestStreamManager.callStreamMethod(
          _localCallContext,
          _localUniqueSession,
          {},
        );
      },
      _localTestStreamManager.outputStreamController,
    );
    return _localTestStreamManager.outputStreamController.stream;
  }

  _i3.Future<void> notifyErrorCreatingNutritionPlan(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'nutritionPlan',
            method: 'notifyErrorCreatingNutritionPlan',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'nutritionPlan',
          methodName: 'notifyErrorCreatingNutritionPlan',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i25.NutritionPlan> getActiveNutritionPlan(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'nutritionPlan',
            method: 'getActiveNutritionPlan',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'nutritionPlan',
          methodName: 'getActiveNutritionPlan',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i25.NutritionPlan>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i30.MealPlanFood> updateMealPlanFood(
    _i1.TestSessionBuilder sessionBuilder, {
    required int mealPlanFoodId,
    required _i31.UpdateMealPlanFoodDto updateDto,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'nutritionPlan',
            method: 'updateMealPlanFood',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'nutritionPlan',
          methodName: 'updateMealPlanFood',
          parameters: _i1.testObjectToJson({
            'mealPlanFoodId': mealPlanFoodId,
            'updateDto': updateDto,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i30.MealPlanFood>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteMealPlanFood(
    _i1.TestSessionBuilder sessionBuilder, {
    required int mealPlanFoodId,
    required int userId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'nutritionPlan',
            method: 'deleteMealPlanFood',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'nutritionPlan',
          methodName: 'deleteMealPlanFood',
          parameters: _i1.testObjectToJson({
            'mealPlanFoodId': mealPlanFoodId,
            'userId': userId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i30.MealPlanFood> addMealPlanFood(
    _i1.TestSessionBuilder sessionBuilder, {
    required int mealPlanId,
    required int foodId,
    required int servingSizeId,
    required double servingQuantity,
    required double quantityGrams,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'nutritionPlan',
            method: 'addMealPlanFood',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'nutritionPlan',
          methodName: 'addMealPlanFood',
          parameters: _i1.testObjectToJson({
            'mealPlanId': mealPlanId,
            'foodId': foodId,
            'servingSizeId': servingSizeId,
            'servingQuantity': servingQuantity,
            'quantityGrams': quantityGrams,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i30.MealPlanFood>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AdminUserEndpoint {
  _AdminUserEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i32.UserProfile> findUserProfile(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminUser',
            method: 'findUserProfile',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminUser',
          methodName: 'findUserProfile',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i32.UserProfile>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i33.UserFoodPreferencesResponseDto> getUserFoodPreferences(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminUser',
            method: 'getUserFoodPreferences',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminUser',
          methodName: 'getUserFoodPreferences',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i33.UserFoodPreferencesResponseDto>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _UserEndpoint {
  _UserEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i32.UserProfile> getCurrentUserProfile(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'user',
            method: 'getCurrentUserProfile',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'getCurrentUserProfile',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i32.UserProfile>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i32.UserProfile> createUserProfile(
    _i1.TestSessionBuilder sessionBuilder,
    _i32.UserProfile userProfile,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'user',
            method: 'createUserProfile',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'createUserProfile',
          parameters: _i1.testObjectToJson({'userProfile': userProfile}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i32.UserProfile>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> setAuthMethod(
    _i1.TestSessionBuilder sessionBuilder,
    _i34.AuthMethod authMethod,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'user',
            method: 'setAuthMethod',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'setAuthMethod',
          parameters: _i1.testObjectToJson({'authMethod': authMethod}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _WorkoutEndpoint {
  _WorkoutEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i35.WorkoutPlan> getActiveWorkoutPlan(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'workout',
            method: 'getActiveWorkoutPlan',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'workout',
          methodName: 'getActiveWorkoutPlan',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i35.WorkoutPlan>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i36.ExerciseLog>> getExerciseLogs(
    _i1.TestSessionBuilder sessionBuilder,
    DateTime startDate,
    DateTime endDate,
    List<int> exerciseIds,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'workout',
            method: 'getExerciseLogs',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'workout',
          methodName: 'getExerciseLogs',
          parameters: _i1.testObjectToJson({
            'startDate': startDate,
            'endDate': endDate,
            'exerciseIds': exerciseIds,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i36.ExerciseLog>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> deleteExerciseLog(
    _i1.TestSessionBuilder sessionBuilder,
    int logId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'workout',
            method: 'deleteExerciseLog',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'workout',
          methodName: 'deleteExerciseLog',
          parameters: _i1.testObjectToJson({'logId': logId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i35.WorkoutPlan> createBaseWorkoutPlan(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
    String name,
    DateTime startDate,
    DateTime endDate,
    _i8.ExerciseDifficulty difficultyLevel,
    int sessionsCount,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'workout',
            method: 'createBaseWorkoutPlan',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'workout',
          methodName: 'createBaseWorkoutPlan',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'name': name,
            'startDate': startDate,
            'endDate': endDate,
            'difficultyLevel': difficultyLevel,
            'sessionsCount': sessionsCount,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i35.WorkoutPlan>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> createWorkoutSession(
    _i1.TestSessionBuilder sessionBuilder,
    int workoutPlanId,
    _i37.CreateWorkoutSessionDto workoutSession,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'workout',
            method: 'createWorkoutSession',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'workout',
          methodName: 'createWorkoutSession',
          parameters: _i1.testObjectToJson({
            'workoutPlanId': workoutPlanId,
            'workoutSession': workoutSession,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> createWorkoutPlan(
    _i1.TestSessionBuilder sessionBuilder,
    _i38.CreateWorkoutPlanDto workoutPlan,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'workout',
            method: 'createWorkoutPlan',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'workout',
          methodName: 'createWorkoutPlan',
          parameters: _i1.testObjectToJson({'workoutPlan': workoutPlan}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> notifyErrorCreatingWorkoutPlan(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'workout',
            method: 'notifyErrorCreatingWorkoutPlan',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'workout',
          methodName: 'notifyErrorCreatingWorkoutPlan',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Stream<_i39.GenerateWorkoutPlanProgressDto> requestWorkoutPlanGeneration(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
    int numberOfWeeks,
  ) {
    var _localTestStreamManager =
        _i1.TestStreamManager<_i39.GenerateWorkoutPlanProgressDto>();
    _i1.callStreamFunctionAndHandleExceptions(
      () async {
        var _localUniqueSession =
            (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
              endpoint: 'workout',
              method: 'requestWorkoutPlanGeneration',
            );
        var _localCallContext = await _endpointDispatch
            .getMethodStreamCallContext(
              createSessionCallback: (_) => _localUniqueSession,
              endpointPath: 'workout',
              methodName: 'requestWorkoutPlanGeneration',
              arguments: {
                'userId': userId,
                'numberOfWeeks': numberOfWeeks,
              },
              requestedInputStreams: [],
              serializationManager: _serializationManager,
            );
        await _localTestStreamManager.callStreamMethod(
          _localCallContext,
          _localUniqueSession,
          {},
        );
      },
      _localTestStreamManager.outputStreamController,
    );
    return _localTestStreamManager.outputStreamController.stream;
  }

  _i3.Stream<String> listenToWorkoutTips(
    _i1.TestSessionBuilder sessionBuilder,
  ) {
    var _localTestStreamManager = _i1.TestStreamManager<String>();
    _i1.callStreamFunctionAndHandleExceptions(
      () async {
        var _localUniqueSession =
            (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
              endpoint: 'workout',
              method: 'listenToWorkoutTips',
            );
        var _localCallContext = await _endpointDispatch
            .getMethodStreamCallContext(
              createSessionCallback: (_) => _localUniqueSession,
              endpointPath: 'workout',
              methodName: 'listenToWorkoutTips',
              arguments: {},
              requestedInputStreams: [],
              serializationManager: _serializationManager,
            );
        await _localTestStreamManager.callStreamMethod(
          _localCallContext,
          _localUniqueSession,
          {},
        );
      },
      _localTestStreamManager.outputStreamController,
    );
    return _localTestStreamManager.outputStreamController.stream;
  }

  _i3.Future<_i36.ExerciseLog> logWorkoutExercise(
    _i1.TestSessionBuilder sessionBuilder,
    _i36.ExerciseLog log,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'workout',
            method: 'logWorkoutExercise',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'workout',
          methodName: 'logWorkoutExercise',
          parameters: _i1.testObjectToJson({'log': log}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i36.ExerciseLog>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i40.WorkoutSession>> getWorkoutHistory(
    _i1.TestSessionBuilder sessionBuilder,
    DateTime? startDate,
    DateTime? endDate,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'workout',
            method: 'getWorkoutHistory',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'workout',
          methodName: 'getWorkoutHistory',
          parameters: _i1.testObjectToJson({
            'startDate': startDate,
            'endDate': endDate,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i40.WorkoutSession>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i41.WorkoutProgressMetricsDto> getWorkoutProgressMetrics(
    _i1.TestSessionBuilder sessionBuilder,
    DateTime? startDate,
    DateTime? endDate,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'workout',
            method: 'getWorkoutProgressMetrics',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'workout',
          methodName: 'getWorkoutProgressMetrics',
          parameters: _i1.testObjectToJson({
            'startDate': startDate,
            'endDate': endDate,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i41.WorkoutProgressMetricsDto>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i42.WorkoutSessionsByDateDto>> getWorkoutSessionsByDateRange(
    _i1.TestSessionBuilder sessionBuilder,
    DateTime startDate,
    DateTime endDate,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'workout',
            method: 'getWorkoutSessionsByDateRange',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'workout',
          methodName: 'getWorkoutSessionsByDateRange',
          parameters: _i1.testObjectToJson({
            'startDate': startDate,
            'endDate': endDate,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i42.WorkoutSessionsByDateDto>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}
