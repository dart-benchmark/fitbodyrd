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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:fitbodyrd_client/src/protocol/features/dashboard/dto/weekly_summary.dto.dart'
    as _i3;
import 'package:fitbodyrd_client/src/protocol/features/exercise/models/exercise.dart'
    as _i4;
import 'package:fitbodyrd_client/src/protocol/features/exercise/models/exercise_category.dart'
    as _i5;
import 'package:fitbodyrd_client/src/protocol/features/exercise/models/exercise_muscle_group.dart'
    as _i6;
import 'package:fitbodyrd_client/src/protocol/common/models/exercise_difficulty.dart'
    as _i7;
import 'package:fitbodyrd_client/src/protocol/features/exercise/models/exercise_image.dart'
    as _i8;
import 'package:fitbodyrd_client/src/protocol/features/exercise/models/exercise_image_order.dart'
    as _i9;
import 'package:fitbodyrd_client/src/protocol/common/models/string_list.dart'
    as _i10;
import 'package:fitbodyrd_client/src/protocol/features/food/models/food_category.dart'
    as _i11;
import 'package:fitbodyrd_client/src/protocol/features/food/models/food.dart'
    as _i12;
import 'package:fitbodyrd_client/src/protocol/features/food/dto/create_serving_size.dto.dart'
    as _i13;
import 'package:fitbodyrd_client/src/protocol/features/food/dto/create_micronutrient.dto.dart'
    as _i14;
import 'package:fitbodyrd_client/src/protocol/features/food/models/food_serving_size.dart'
    as _i15;
import 'package:fitbodyrd_client/src/protocol/features/food/models/food_micronutrient.dart'
    as _i16;
import 'package:fitbodyrd_client/src/protocol/features/food/dto/search_endpoints_response.dto.dart'
    as _i17;
import 'package:fitbodyrd_client/src/protocol/features/food/models/dietary_restriction.dart'
    as _i18;
import 'package:fitbodyrd_client/src/protocol/features/food/dto/food_catalogue.dto.dart'
    as _i19;
import 'package:fitbodyrd_client/src/protocol/features/nutrition/models/food_intake_log.dart'
    as _i20;
import 'package:fitbodyrd_client/src/protocol/features/nutrition/dto/create_food_intake_log.dto.dart'
    as _i21;
import 'package:fitbodyrd_client/src/protocol/features/nutrition/dto/macros_response.dto.dart'
    as _i22;
import 'package:fitbodyrd_client/src/protocol/features/nutrition_plan/models/meal_type.dart'
    as _i23;
import 'package:fitbodyrd_client/src/protocol/features/nutrition_plan/models/nutrition_plan.dart'
    as _i24;
import 'package:fitbodyrd_client/src/protocol/features/nutrition_plan/dto/created_meal_plan.dto.dart'
    as _i25;
import 'package:fitbodyrd_client/src/protocol/features/nutrition_plan/dto/create_meal_plan.dto.dart'
    as _i26;
import 'package:fitbodyrd_client/src/protocol/features/nutrition_plan/dto/generate_nutrition_plan_progress.dto.dart'
    as _i27;
import 'package:fitbodyrd_client/src/protocol/common/models/stream_status.dart'
    as _i28;
import 'package:fitbodyrd_client/src/protocol/features/nutrition_plan/models/meal_plan_food.dart'
    as _i29;
import 'package:fitbodyrd_client/src/protocol/features/nutrition_plan/dto/update_meal_plan_food.dto.dart'
    as _i30;
import 'package:fitbodyrd_client/src/protocol/features/user/models/app_user.dart'
    as _i31;
import 'package:fitbodyrd_client/src/protocol/features/user/dto/user_food_preferences_response.dto.dart'
    as _i32;
import 'package:fitbodyrd_client/src/protocol/features/user/models/auth_method.dart'
    as _i33;
import 'package:fitbodyrd_client/src/protocol/features/workouts/models/workout_plan.dart'
    as _i34;
import 'package:fitbodyrd_client/src/protocol/features/workouts/models/exercise_log.dart'
    as _i35;
import 'package:fitbodyrd_client/src/protocol/features/workouts/dto/create_workout_session.dto.dart'
    as _i36;
import 'package:fitbodyrd_client/src/protocol/features/workouts/dto/create_workout_plan.dto.dart'
    as _i37;
import 'package:fitbodyrd_client/src/protocol/features/workouts/dto/generate_workout_plan_progress.dto.dart'
    as _i38;
import 'package:fitbodyrd_client/src/protocol/features/workouts/models/workout_session.dart'
    as _i39;
import 'package:fitbodyrd_client/src/protocol/features/workouts/dto/workout_progress_metrics.dto.dart'
    as _i40;
import 'package:fitbodyrd_client/src/protocol/features/workouts/dto/workout_sessions_by_date.dto.dart'
    as _i41;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i42;
import 'protocol.dart' as _i43;

/// {@category Endpoint}
class EndpointDashboard extends _i1.EndpointRef {
  EndpointDashboard(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dashboard';

  _i2.Future<_i3.WeeklySummaryDto> getWeeklySummary() =>
      caller.callServerEndpoint<_i3.WeeklySummaryDto>(
        'dashboard',
        'getWeeklySummary',
        {},
      );
}

/// {@category Endpoint}
class EndpointExercise extends _i1.EndpointRef {
  EndpointExercise(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'exercise';

  _i2.Future<List<_i4.Exercise>> getAllExercises() =>
      caller.callServerEndpoint<List<_i4.Exercise>>(
        'exercise',
        'getAllExercises',
        {},
      );

  _i2.Future<_i4.Exercise> getExerciseById(int id) =>
      caller.callServerEndpoint<_i4.Exercise>(
        'exercise',
        'getExerciseById',
        {'id': id},
      );

  _i2.Future<_i4.Exercise> createExercise({
    required String name,
    String? description,
    required List<_i5.ExerciseCategory> category,
    required List<_i6.ExerciseMuscleGroup> muscleGroup,
    required _i7.ExerciseDifficulty difficulty,
    bool? requiresEquipment,
    String? equipmentNeeded,
    String? videoUrl,
    List<String>? images,
  }) => caller.callServerEndpoint<_i4.Exercise>(
    'exercise',
    'createExercise',
    {
      'name': name,
      'description': description,
      'category': category,
      'muscleGroup': muscleGroup,
      'difficulty': difficulty,
      'requiresEquipment': requiresEquipment,
      'equipmentNeeded': equipmentNeeded,
      'videoUrl': videoUrl,
      'images': images,
    },
  );

  _i2.Future<_i4.Exercise> updateExercise(_i4.Exercise exercise) =>
      caller.callServerEndpoint<_i4.Exercise>(
        'exercise',
        'updateExercise',
        {'exercise': exercise},
      );

  _i2.Future<void> deleteExercise(int id) => caller.callServerEndpoint<void>(
    'exercise',
    'deleteExercise',
    {'id': id},
  );

  _i2.Future<List<_i8.ExerciseImage>> getExerciseImages(int exerciseId) =>
      caller.callServerEndpoint<List<_i8.ExerciseImage>>(
        'exercise',
        'getExerciseImages',
        {'exerciseId': exerciseId},
      );

  _i2.Future<_i8.ExerciseImage> addExerciseImage({
    required int exerciseId,
    required String imageUrl,
  }) => caller.callServerEndpoint<_i8.ExerciseImage>(
    'exercise',
    'addExerciseImage',
    {
      'exerciseId': exerciseId,
      'imageUrl': imageUrl,
    },
  );

  _i2.Future<void> deleteExerciseImage(int imageId) =>
      caller.callServerEndpoint<void>(
        'exercise',
        'deleteExerciseImage',
        {'imageId': imageId},
      );

  _i2.Future<List<_i8.ExerciseImage>> reorderImages(
    int exerciseId,
    List<_i9.ExerciseImageOrder> newOrder,
  ) => caller.callServerEndpoint<List<_i8.ExerciseImage>>(
    'exercise',
    'reorderImages',
    {
      'exerciseId': exerciseId,
      'newOrder': newOrder,
    },
  );

  _i2.Future<_i10.StringList> getAllExerciseNames() =>
      caller.callServerEndpoint<_i10.StringList>(
        'exercise',
        'getAllExerciseNames',
        {},
      );

  _i2.Future<List<_i4.Exercise>> searchExercises({
    List<_i5.ExerciseCategory>? categoriesIn,
    List<_i6.ExerciseMuscleGroup>? muscleGroupsIn,
    List<_i7.ExerciseDifficulty>? difficultiesIn,
    bool? includeExercisesRequiringEquipment,
  }) => caller.callServerEndpoint<List<_i4.Exercise>>(
    'exercise',
    'searchExercises',
    {
      'categoriesIn': categoriesIn,
      'muscleGroupsIn': muscleGroupsIn,
      'difficultiesIn': difficultiesIn,
      'includeExercisesRequiringEquipment': includeExercisesRequiringEquipment,
    },
  );
}

/// {@category Endpoint}
class EndpointFood extends _i1.EndpointRef {
  EndpointFood(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'food';

  _i2.Future<List<_i11.FoodCategory>> getAllFoodCategories() =>
      caller.callServerEndpoint<List<_i11.FoodCategory>>(
        'food',
        'getAllFoodCategories',
        {},
      );

  _i2.Future<List<_i11.FoodCategory>> getParentFoodCategories() =>
      caller.callServerEndpoint<List<_i11.FoodCategory>>(
        'food',
        'getParentFoodCategories',
        {},
      );

  _i2.Future<_i11.FoodCategory> getFoodCategoryById(int foodCategoryId) =>
      caller.callServerEndpoint<_i11.FoodCategory>(
        'food',
        'getFoodCategoryById',
        {'foodCategoryId': foodCategoryId},
      );

  _i2.Future<_i11.FoodCategory> createFoodCategory({
    required String name,
    required String slug,
    required String colorHex,
    required int displayOrder,
    required String iconName,
    int? parentCategoryId,
  }) => caller.callServerEndpoint<_i11.FoodCategory>(
    'food',
    'createFoodCategory',
    {
      'name': name,
      'slug': slug,
      'colorHex': colorHex,
      'displayOrder': displayOrder,
      'iconName': iconName,
      'parentCategoryId': parentCategoryId,
    },
  );

  _i2.Future<_i11.FoodCategory> updateFoodCategory(
    int categoryId, {
    String? name,
    String? slug,
    String? colorHex,
    int? displayOrder,
    String? iconName,
    int? parentCategoryId,
  }) => caller.callServerEndpoint<_i11.FoodCategory>(
    'food',
    'updateFoodCategory',
    {
      'categoryId': categoryId,
      'name': name,
      'slug': slug,
      'colorHex': colorHex,
      'displayOrder': displayOrder,
      'iconName': iconName,
      'parentCategoryId': parentCategoryId,
    },
  );

  _i2.Future<void> deleteFoodCategory(int categoryId) =>
      caller.callServerEndpoint<void>(
        'food',
        'deleteFoodCategory',
        {'categoryId': categoryId},
      );

  _i2.Future<List<_i12.Food>> getFoods() =>
      caller.callServerEndpoint<List<_i12.Food>>(
        'food',
        'getFoods',
        {},
      );

  _i2.Future<_i12.Food> getFoodById(int foodId) =>
      caller.callServerEndpoint<_i12.Food>(
        'food',
        'getFoodById',
        {'foodId': foodId},
      );

  _i2.Future<_i12.Food> createFood({
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
    List<_i13.CreateServingSizeDto>? servingSizes,
    List<_i14.CreateMicronutrientDto>? micronutrients,
  }) => caller.callServerEndpoint<_i12.Food>(
    'food',
    'createFood',
    {
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
    },
  );

  _i2.Future<_i12.Food> updateFood(
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
    List<_i13.CreateServingSizeDto>? servingSizes,
    List<_i14.CreateMicronutrientDto>? micronutrients,
  }) => caller.callServerEndpoint<_i12.Food>(
    'food',
    'updateFood',
    {
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
    },
  );

  _i2.Future<void> deleteFood(int foodId) => caller.callServerEndpoint<void>(
    'food',
    'deleteFood',
    {'foodId': foodId},
  );

  _i2.Future<_i15.FoodServingSize> createFoodServingSize({
    required int foodId,
    required String name,
    required double grams,
    required bool isDefault,
  }) => caller.callServerEndpoint<_i15.FoodServingSize>(
    'food',
    'createFoodServingSize',
    {
      'foodId': foodId,
      'name': name,
      'grams': grams,
      'isDefault': isDefault,
    },
  );

  _i2.Future<_i15.FoodServingSize> updateFoodServingSize(
    int servingSizeId, {
    String? name,
    double? grams,
    bool? isDefault,
  }) => caller.callServerEndpoint<_i15.FoodServingSize>(
    'food',
    'updateFoodServingSize',
    {
      'servingSizeId': servingSizeId,
      'name': name,
      'grams': grams,
      'isDefault': isDefault,
    },
  );

  _i2.Future<void> deleteFoodServingSize(int servingSizeId) =>
      caller.callServerEndpoint<void>(
        'food',
        'deleteFoodServingSize',
        {'servingSizeId': servingSizeId},
      );

  _i2.Future<_i16.FoodMicronutrient> createFoodMicronutrient({
    required int foodId,
    required String name,
    required double amount,
    required String unit,
  }) => caller.callServerEndpoint<_i16.FoodMicronutrient>(
    'food',
    'createFoodMicronutrient',
    {
      'foodId': foodId,
      'name': name,
      'amount': amount,
      'unit': unit,
    },
  );

  _i2.Future<_i16.FoodMicronutrient> updateFoodMicronutrient(
    int micronutrientId, {
    String? name,
    double? amount,
    String? unit,
  }) => caller.callServerEndpoint<_i16.FoodMicronutrient>(
    'food',
    'updateFoodMicronutrient',
    {
      'micronutrientId': micronutrientId,
      'name': name,
      'amount': amount,
      'unit': unit,
    },
  );

  _i2.Future<void> deleteFoodMicronutrient(int micronutrientId) =>
      caller.callServerEndpoint<void>(
        'food',
        'deleteFoodMicronutrient',
        {'micronutrientId': micronutrientId},
      );

  _i2.Future<_i17.SearchEndpointsResponseDto> searchFoods({
    required int categoryId,
    _i18.DietaryRestriction? dietaryRestriction,
    bool? isLocalOnly,
    List<int>? excludeFoodIds,
    int? limit,
  }) => caller.callServerEndpoint<_i17.SearchEndpointsResponseDto>(
    'food',
    'searchFoods',
    {
      'categoryId': categoryId,
      'dietaryRestriction': dietaryRestriction,
      'isLocalOnly': isLocalOnly,
      'excludeFoodIds': excludeFoodIds,
      'limit': limit,
    },
  );

  _i2.Future<_i17.SearchEndpointsResponseDto> searchFoodsV2({
    required String query,
    int? categoryId,
    int? limit,
  }) => caller.callServerEndpoint<_i17.SearchEndpointsResponseDto>(
    'food',
    'searchFoodsV2',
    {
      'query': query,
      'categoryId': categoryId,
      'limit': limit,
    },
  );

  _i2.Future<_i19.FoodCatalogueDto> getFoodCatalogue(
    List<int> excludeFoodIds,
  ) => caller.callServerEndpoint<_i19.FoodCatalogueDto>(
    'food',
    'getFoodCatalogue',
    {'excludeFoodIds': excludeFoodIds},
  );
}

/// {@category Endpoint}
class EndpointFoodIntakeLog extends _i1.EndpointRef {
  EndpointFoodIntakeLog(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'foodIntakeLog';

  _i2.Future<_i20.FoodIntakeLog> create(_i21.CreateFoodIntakeLog dto) =>
      caller.callServerEndpoint<_i20.FoodIntakeLog>(
        'foodIntakeLog',
        'create',
        {'dto': dto},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
    'foodIntakeLog',
    'delete',
    {'id': id},
  );

  _i2.Future<List<_i20.FoodIntakeLog>> getByDate(DateTime date) =>
      caller.callServerEndpoint<List<_i20.FoodIntakeLog>>(
        'foodIntakeLog',
        'getByDate',
        {'date': date},
      );
}

/// {@category Endpoint}
class EndpointNutrition extends _i1.EndpointRef {
  EndpointNutrition(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'nutrition';

  _i2.Future<_i22.MacrosResponseDto> calculateMacros(
    int userId,
    List<_i23.MealPlanType> mealTypes,
  ) => caller.callServerEndpoint<_i22.MacrosResponseDto>(
    'nutrition',
    'calculateMacros',
    {
      'userId': userId,
      'mealTypes': mealTypes,
    },
  );
}

/// {@category Endpoint}
class EndpointNutritionPlan extends _i1.EndpointRef {
  EndpointNutritionPlan(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'nutritionPlan';

  _i2.Future<_i24.NutritionPlan> createNutritionPlan({
    required int userId,
    required DateTime startDate,
    required DateTime endDate,
    required double dailyCalories,
    required double dailyProteins,
    required double dailyCarbs,
    required double dailyFats,
  }) => caller.callServerEndpoint<_i24.NutritionPlan>(
    'nutritionPlan',
    'createNutritionPlan',
    {
      'userId': userId,
      'startDate': startDate,
      'endDate': endDate,
      'dailyCalories': dailyCalories,
      'dailyProteins': dailyProteins,
      'dailyCarbs': dailyCarbs,
      'dailyFats': dailyFats,
    },
  );

  _i2.Future<_i24.NutritionPlan> getNutritionPlanById(int planId) =>
      caller.callServerEndpoint<_i24.NutritionPlan>(
        'nutritionPlan',
        'getNutritionPlanById',
        {'planId': planId},
      );

  _i2.Future<_i25.CreatedMealPlanDto> createMealPlan(
    _i26.CreateMealPlanDto mealPlanDto,
  ) => caller.callServerEndpoint<_i25.CreatedMealPlanDto>(
    'nutritionPlan',
    'createMealPlan',
    {'mealPlanDto': mealPlanDto},
  );

  _i2.Future<_i27.GenerateNutritionPlanProgressDto>
  updateNutritionPlanProgress({
    required int userId,
    required int nutritionPlanId,
    required int currentDay,
    required int totalDays,
    required _i28.StreamStatus status,
    required String message,
  }) => caller.callServerEndpoint<_i27.GenerateNutritionPlanProgressDto>(
    'nutritionPlan',
    'updateNutritionPlanProgress',
    {
      'userId': userId,
      'nutritionPlanId': nutritionPlanId,
      'currentDay': currentDay,
      'totalDays': totalDays,
      'status': status,
      'message': message,
    },
  );

  _i2.Stream<_i27.GenerateNutritionPlanProgressDto>
  requestNutritionPlanGeneration(
    int userId,
    int weeks,
    List<_i23.MealPlanType> mealTypes,
  ) =>
      caller.callStreamingServerEndpoint<
        _i2.Stream<_i27.GenerateNutritionPlanProgressDto>,
        _i27.GenerateNutritionPlanProgressDto
      >(
        'nutritionPlan',
        'requestNutritionPlanGeneration',
        {
          'userId': userId,
          'weeks': weeks,
          'mealTypes': mealTypes,
        },
        {},
      );

  _i2.Future<void> notifyErrorCreatingNutritionPlan(int userId) =>
      caller.callServerEndpoint<void>(
        'nutritionPlan',
        'notifyErrorCreatingNutritionPlan',
        {'userId': userId},
      );

  _i2.Future<_i24.NutritionPlan> getActiveNutritionPlan(int userId) =>
      caller.callServerEndpoint<_i24.NutritionPlan>(
        'nutritionPlan',
        'getActiveNutritionPlan',
        {'userId': userId},
      );

  _i2.Future<_i29.MealPlanFood> updateMealPlanFood({
    required int mealPlanFoodId,
    required _i30.UpdateMealPlanFoodDto updateDto,
  }) => caller.callServerEndpoint<_i29.MealPlanFood>(
    'nutritionPlan',
    'updateMealPlanFood',
    {
      'mealPlanFoodId': mealPlanFoodId,
      'updateDto': updateDto,
    },
  );

  _i2.Future<bool> deleteMealPlanFood({
    required int mealPlanFoodId,
    required int userId,
  }) => caller.callServerEndpoint<bool>(
    'nutritionPlan',
    'deleteMealPlanFood',
    {
      'mealPlanFoodId': mealPlanFoodId,
      'userId': userId,
    },
  );

  _i2.Future<_i29.MealPlanFood> addMealPlanFood({
    required int mealPlanId,
    required int foodId,
    required int servingSizeId,
    required double servingQuantity,
    required double quantityGrams,
  }) => caller.callServerEndpoint<_i29.MealPlanFood>(
    'nutritionPlan',
    'addMealPlanFood',
    {
      'mealPlanId': mealPlanId,
      'foodId': foodId,
      'servingSizeId': servingSizeId,
      'servingQuantity': servingQuantity,
      'quantityGrams': quantityGrams,
    },
  );
}

/// {@category Endpoint}
class EndpointAdminUser extends _i1.EndpointRef {
  EndpointAdminUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'adminUser';

  _i2.Future<_i31.UserProfile> findUserProfile(int userId) =>
      caller.callServerEndpoint<_i31.UserProfile>(
        'adminUser',
        'findUserProfile',
        {'userId': userId},
      );

  _i2.Future<_i32.UserFoodPreferencesResponseDto> getUserFoodPreferences(
    int userId,
  ) => caller.callServerEndpoint<_i32.UserFoodPreferencesResponseDto>(
    'adminUser',
    'getUserFoodPreferences',
    {'userId': userId},
  );
}

/// {@category Endpoint}
class EndpointUser extends _i1.EndpointRef {
  EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  _i2.Future<_i31.UserProfile> getCurrentUserProfile() =>
      caller.callServerEndpoint<_i31.UserProfile>(
        'user',
        'getCurrentUserProfile',
        {},
      );

  _i2.Future<_i31.UserProfile> createUserProfile(
    _i31.UserProfile userProfile,
  ) => caller.callServerEndpoint<_i31.UserProfile>(
    'user',
    'createUserProfile',
    {'userProfile': userProfile},
  );

  _i2.Future<void> setAuthMethod(_i33.AuthMethod authMethod) =>
      caller.callServerEndpoint<void>(
        'user',
        'setAuthMethod',
        {'authMethod': authMethod},
      );
}

/// {@category Endpoint}
class EndpointWorkout extends _i1.EndpointRef {
  EndpointWorkout(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'workout';

  _i2.Future<_i34.WorkoutPlan> getActiveWorkoutPlan(int userId) =>
      caller.callServerEndpoint<_i34.WorkoutPlan>(
        'workout',
        'getActiveWorkoutPlan',
        {'userId': userId},
      );

  _i2.Future<List<_i35.ExerciseLog>> getExerciseLogs(
    DateTime startDate,
    DateTime endDate,
    List<int> exerciseIds,
  ) => caller.callServerEndpoint<List<_i35.ExerciseLog>>(
    'workout',
    'getExerciseLogs',
    {
      'startDate': startDate,
      'endDate': endDate,
      'exerciseIds': exerciseIds,
    },
  );

  _i2.Future<void> deleteExerciseLog(int logId) =>
      caller.callServerEndpoint<void>(
        'workout',
        'deleteExerciseLog',
        {'logId': logId},
      );

  _i2.Future<_i34.WorkoutPlan> createBaseWorkoutPlan(
    int userId,
    String name,
    DateTime startDate,
    DateTime endDate,
    _i7.ExerciseDifficulty difficultyLevel,
    int sessionsCount,
  ) => caller.callServerEndpoint<_i34.WorkoutPlan>(
    'workout',
    'createBaseWorkoutPlan',
    {
      'userId': userId,
      'name': name,
      'startDate': startDate,
      'endDate': endDate,
      'difficultyLevel': difficultyLevel,
      'sessionsCount': sessionsCount,
    },
  );

  _i2.Future<void> createWorkoutSession(
    int workoutPlanId,
    _i36.CreateWorkoutSessionDto workoutSession,
  ) => caller.callServerEndpoint<void>(
    'workout',
    'createWorkoutSession',
    {
      'workoutPlanId': workoutPlanId,
      'workoutSession': workoutSession,
    },
  );

  _i2.Future<void> createWorkoutPlan(_i37.CreateWorkoutPlanDto workoutPlan) =>
      caller.callServerEndpoint<void>(
        'workout',
        'createWorkoutPlan',
        {'workoutPlan': workoutPlan},
      );

  _i2.Future<void> notifyErrorCreatingWorkoutPlan(int userId) =>
      caller.callServerEndpoint<void>(
        'workout',
        'notifyErrorCreatingWorkoutPlan',
        {'userId': userId},
      );

  _i2.Stream<_i38.GenerateWorkoutPlanProgressDto> requestWorkoutPlanGeneration(
    int userId,
    int numberOfWeeks,
  ) =>
      caller.callStreamingServerEndpoint<
        _i2.Stream<_i38.GenerateWorkoutPlanProgressDto>,
        _i38.GenerateWorkoutPlanProgressDto
      >(
        'workout',
        'requestWorkoutPlanGeneration',
        {
          'userId': userId,
          'numberOfWeeks': numberOfWeeks,
        },
        {},
      );

  _i2.Stream<String> listenToWorkoutTips() =>
      caller.callStreamingServerEndpoint<_i2.Stream<String>, String>(
        'workout',
        'listenToWorkoutTips',
        {},
        {},
      );

  _i2.Future<_i35.ExerciseLog> logWorkoutExercise(_i35.ExerciseLog log) =>
      caller.callServerEndpoint<_i35.ExerciseLog>(
        'workout',
        'logWorkoutExercise',
        {'log': log},
      );

  _i2.Future<List<_i39.WorkoutSession>> getWorkoutHistory(
    DateTime? startDate,
    DateTime? endDate,
  ) => caller.callServerEndpoint<List<_i39.WorkoutSession>>(
    'workout',
    'getWorkoutHistory',
    {
      'startDate': startDate,
      'endDate': endDate,
    },
  );

  _i2.Future<_i40.WorkoutProgressMetricsDto> getWorkoutProgressMetrics(
    DateTime? startDate,
    DateTime? endDate,
  ) => caller.callServerEndpoint<_i40.WorkoutProgressMetricsDto>(
    'workout',
    'getWorkoutProgressMetrics',
    {
      'startDate': startDate,
      'endDate': endDate,
    },
  );

  _i2.Future<List<_i41.WorkoutSessionsByDateDto>> getWorkoutSessionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) => caller.callServerEndpoint<List<_i41.WorkoutSessionsByDateDto>>(
    'workout',
    'getWorkoutSessionsByDateRange',
    {
      'startDate': startDate,
      'endDate': endDate,
    },
  );
}

class Modules {
  Modules(Client client) {
    auth = _i42.Caller(client);
  }

  late final _i42.Caller auth;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i43.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    dashboard = EndpointDashboard(this);
    exercise = EndpointExercise(this);
    food = EndpointFood(this);
    foodIntakeLog = EndpointFoodIntakeLog(this);
    nutrition = EndpointNutrition(this);
    nutritionPlan = EndpointNutritionPlan(this);
    adminUser = EndpointAdminUser(this);
    user = EndpointUser(this);
    workout = EndpointWorkout(this);
    modules = Modules(this);
  }

  late final EndpointDashboard dashboard;

  late final EndpointExercise exercise;

  late final EndpointFood food;

  late final EndpointFoodIntakeLog foodIntakeLog;

  late final EndpointNutrition nutrition;

  late final EndpointNutritionPlan nutritionPlan;

  late final EndpointAdminUser adminUser;

  late final EndpointUser user;

  late final EndpointWorkout workout;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
    'dashboard': dashboard,
    'exercise': exercise,
    'food': food,
    'foodIntakeLog': foodIntakeLog,
    'nutrition': nutrition,
    'nutritionPlan': nutritionPlan,
    'adminUser': adminUser,
    'user': user,
    'workout': workout,
  };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {
    'auth': modules.auth,
  };
}
