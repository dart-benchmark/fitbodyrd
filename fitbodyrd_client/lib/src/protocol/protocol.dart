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
import 'common/models/activity_level.dart' as _i2;
import 'common/models/body_goal.dart' as _i3;
import 'common/models/exercise_difficulty.dart' as _i4;
import 'common/models/sex.dart' as _i5;
import 'common/models/status.dart' as _i6;
import 'common/models/stream_status.dart' as _i7;
import 'common/models/string_list.dart' as _i8;
import 'common/models/weight_category.dart' as _i9;
import 'errors/models/app_exception.dart' as _i10;
import 'errors/models/generic_exception.dart' as _i11;
import 'features/dashboard/dto/weekly_summary.dto.dart' as _i12;
import 'features/email/models/email_template.dart' as _i13;
import 'features/email/models/email_templates_enum.dart' as _i14;
import 'features/exercise/models/exercise.dart' as _i15;
import 'features/exercise/models/exercise_alternative.dart' as _i16;
import 'features/exercise/models/exercise_category.dart' as _i17;
import 'features/exercise/models/exercise_image.dart' as _i18;
import 'features/exercise/models/exercise_image_order.dart' as _i19;
import 'features/exercise/models/exercise_muscle_group.dart' as _i20;
import 'features/food/dto/create_micronutrient.dto.dart' as _i21;
import 'features/food/dto/create_serving_size.dto.dart' as _i22;
import 'features/food/dto/food_catalogue.dto.dart' as _i23;
import 'features/food/dto/food_category_detail.dto.dart' as _i24;
import 'features/food/dto/search_endpoints_response.dto.dart' as _i25;
import 'features/food/models/dietary_restriction.dart' as _i26;
import 'features/food/models/food.dart' as _i27;
import 'features/food/models/food_category.dart' as _i28;
import 'features/food/models/food_category_list.dart' as _i29;
import 'features/food/models/food_micronutrient.dart' as _i30;
import 'features/food/models/food_serving_size.dart' as _i31;
import 'features/food/models/user_food_preference.dart' as _i32;
import 'features/food/models/user_food_preference_type.dart' as _i33;
import 'features/nutrition/dto/create_food_intake_log.dto.dart' as _i34;
import 'features/nutrition/dto/macros_response.dto.dart' as _i35;
import 'features/nutrition/dto/meal_distribution.dto.dart' as _i36;
import 'features/nutrition/dto/meal_individual_distribution.dto.dart' as _i37;
import 'features/nutrition/models/food_intake_log.dart' as _i38;
import 'features/nutrition_plan/dto/create_meal_plan.dto.dart' as _i39;
import 'features/nutrition_plan/dto/create_meal_plan_detail.dto.dart' as _i40;
import 'features/nutrition_plan/dto/create_meal_plan_food.dto.dart' as _i41;
import 'features/nutrition_plan/dto/created_meal_plan.dto.dart' as _i42;
import 'features/nutrition_plan/dto/created_meal_plan_id.dto.dart' as _i43;
import 'features/nutrition_plan/dto/created_meal_plan_totals.dto.dart' as _i44;
import 'features/nutrition_plan/dto/created_meal_plan_variance.dto.dart'
    as _i45;
import 'features/nutrition_plan/dto/generate_nutrition_plan_progress.dto.dart'
    as _i46;
import 'features/nutrition_plan/dto/update_meal_plan_food.dto.dart' as _i47;
import 'features/nutrition_plan/models/meal_plan.dart' as _i48;
import 'features/nutrition_plan/models/meal_plan_food.dart' as _i49;
import 'features/nutrition_plan/models/meal_type.dart' as _i50;
import 'features/nutrition_plan/models/nutrition_plan.dart' as _i51;
import 'features/user/dto/user_food_preferences_response.dto.dart' as _i52;
import 'features/user/models/app_user.dart' as _i53;
import 'features/user/models/auth_method.dart' as _i54;
import 'features/workouts/dto/create_workout_exercise.dto.dart' as _i55;
import 'features/workouts/dto/create_workout_plan.dto.dart' as _i56;
import 'features/workouts/dto/create_workout_session.dto.dart' as _i57;
import 'features/workouts/dto/generate_workout_plan_progress.dto.dart' as _i58;
import 'features/workouts/dto/workout_progress_metrics.dto.dart' as _i59;
import 'features/workouts/dto/workout_sessions_by_date.dto.dart' as _i60;
import 'features/workouts/models/exercise_log.dart' as _i61;
import 'features/workouts/models/workout_exercise.dart' as _i62;
import 'features/workouts/models/workout_plan.dart' as _i63;
import 'features/workouts/models/workout_session.dart' as _i64;
import 'features/workouts/models/workout_tip.dart' as _i65;
import 'package:fitbodyrd_client/src/protocol/features/exercise/models/exercise.dart'
    as _i66;
import 'package:fitbodyrd_client/src/protocol/features/exercise/models/exercise_category.dart'
    as _i67;
import 'package:fitbodyrd_client/src/protocol/features/exercise/models/exercise_muscle_group.dart'
    as _i68;
import 'package:fitbodyrd_client/src/protocol/features/exercise/models/exercise_image.dart'
    as _i69;
import 'package:fitbodyrd_client/src/protocol/features/exercise/models/exercise_image_order.dart'
    as _i70;
import 'package:fitbodyrd_client/src/protocol/common/models/exercise_difficulty.dart'
    as _i71;
import 'package:fitbodyrd_client/src/protocol/features/food/models/food_category.dart'
    as _i72;
import 'package:fitbodyrd_client/src/protocol/features/food/models/food.dart'
    as _i73;
import 'package:fitbodyrd_client/src/protocol/features/food/dto/create_serving_size.dto.dart'
    as _i74;
import 'package:fitbodyrd_client/src/protocol/features/food/dto/create_micronutrient.dto.dart'
    as _i75;
import 'package:fitbodyrd_client/src/protocol/features/nutrition/models/food_intake_log.dart'
    as _i76;
import 'package:fitbodyrd_client/src/protocol/features/nutrition_plan/models/meal_type.dart'
    as _i77;
import 'package:fitbodyrd_client/src/protocol/features/workouts/models/exercise_log.dart'
    as _i78;
import 'package:fitbodyrd_client/src/protocol/features/workouts/models/workout_session.dart'
    as _i79;
import 'package:fitbodyrd_client/src/protocol/features/workouts/dto/workout_sessions_by_date.dto.dart'
    as _i80;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i81;
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
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

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

    if (t == _i2.ActivityLevel) {
      return _i2.ActivityLevel.fromJson(data) as T;
    }
    if (t == _i3.BodyGoal) {
      return _i3.BodyGoal.fromJson(data) as T;
    }
    if (t == _i4.ExerciseDifficulty) {
      return _i4.ExerciseDifficulty.fromJson(data) as T;
    }
    if (t == _i5.Sex) {
      return _i5.Sex.fromJson(data) as T;
    }
    if (t == _i6.Status) {
      return _i6.Status.fromJson(data) as T;
    }
    if (t == _i7.StreamStatus) {
      return _i7.StreamStatus.fromJson(data) as T;
    }
    if (t == _i8.StringList) {
      return _i8.StringList.fromJson(data) as T;
    }
    if (t == _i9.WeightCategory) {
      return _i9.WeightCategory.fromJson(data) as T;
    }
    if (t == _i10.AppException) {
      return _i10.AppException.fromJson(data) as T;
    }
    if (t == _i11.GenericException) {
      return _i11.GenericException.fromJson(data) as T;
    }
    if (t == _i12.WeeklySummaryDto) {
      return _i12.WeeklySummaryDto.fromJson(data) as T;
    }
    if (t == _i13.EmailTemplate) {
      return _i13.EmailTemplate.fromJson(data) as T;
    }
    if (t == _i14.EmailTemplatesEnum) {
      return _i14.EmailTemplatesEnum.fromJson(data) as T;
    }
    if (t == _i15.Exercise) {
      return _i15.Exercise.fromJson(data) as T;
    }
    if (t == _i16.ExerciseAlternative) {
      return _i16.ExerciseAlternative.fromJson(data) as T;
    }
    if (t == _i17.ExerciseCategory) {
      return _i17.ExerciseCategory.fromJson(data) as T;
    }
    if (t == _i18.ExerciseImage) {
      return _i18.ExerciseImage.fromJson(data) as T;
    }
    if (t == _i19.ExerciseImageOrder) {
      return _i19.ExerciseImageOrder.fromJson(data) as T;
    }
    if (t == _i20.ExerciseMuscleGroup) {
      return _i20.ExerciseMuscleGroup.fromJson(data) as T;
    }
    if (t == _i21.CreateMicronutrientDto) {
      return _i21.CreateMicronutrientDto.fromJson(data) as T;
    }
    if (t == _i22.CreateServingSizeDto) {
      return _i22.CreateServingSizeDto.fromJson(data) as T;
    }
    if (t == _i23.FoodCatalogueDto) {
      return _i23.FoodCatalogueDto.fromJson(data) as T;
    }
    if (t == _i24.FoodCategoryDetailDto) {
      return _i24.FoodCategoryDetailDto.fromJson(data) as T;
    }
    if (t == _i25.SearchEndpointsResponseDto) {
      return _i25.SearchEndpointsResponseDto.fromJson(data) as T;
    }
    if (t == _i26.DietaryRestriction) {
      return _i26.DietaryRestriction.fromJson(data) as T;
    }
    if (t == _i27.Food) {
      return _i27.Food.fromJson(data) as T;
    }
    if (t == _i28.FoodCategory) {
      return _i28.FoodCategory.fromJson(data) as T;
    }
    if (t == _i29.FoodCategoryList) {
      return _i29.FoodCategoryList.fromJson(data) as T;
    }
    if (t == _i30.FoodMicronutrient) {
      return _i30.FoodMicronutrient.fromJson(data) as T;
    }
    if (t == _i31.FoodServingSize) {
      return _i31.FoodServingSize.fromJson(data) as T;
    }
    if (t == _i32.UserFoodPreference) {
      return _i32.UserFoodPreference.fromJson(data) as T;
    }
    if (t == _i33.UserFoodPreferenceType) {
      return _i33.UserFoodPreferenceType.fromJson(data) as T;
    }
    if (t == _i34.CreateFoodIntakeLog) {
      return _i34.CreateFoodIntakeLog.fromJson(data) as T;
    }
    if (t == _i35.MacrosResponseDto) {
      return _i35.MacrosResponseDto.fromJson(data) as T;
    }
    if (t == _i36.MealDistributionDto) {
      return _i36.MealDistributionDto.fromJson(data) as T;
    }
    if (t == _i37.MealIndividualDistributionDto) {
      return _i37.MealIndividualDistributionDto.fromJson(data) as T;
    }
    if (t == _i38.FoodIntakeLog) {
      return _i38.FoodIntakeLog.fromJson(data) as T;
    }
    if (t == _i39.CreateMealPlanDto) {
      return _i39.CreateMealPlanDto.fromJson(data) as T;
    }
    if (t == _i40.CreateMealPlanDetailDto) {
      return _i40.CreateMealPlanDetailDto.fromJson(data) as T;
    }
    if (t == _i41.CreateMealPlanFoodDto) {
      return _i41.CreateMealPlanFoodDto.fromJson(data) as T;
    }
    if (t == _i42.CreatedMealPlanDto) {
      return _i42.CreatedMealPlanDto.fromJson(data) as T;
    }
    if (t == _i43.CreatedMealPlanIdDto) {
      return _i43.CreatedMealPlanIdDto.fromJson(data) as T;
    }
    if (t == _i44.CreatedMealPlanTotalsDto) {
      return _i44.CreatedMealPlanTotalsDto.fromJson(data) as T;
    }
    if (t == _i45.CreatedMealPlanVarianceDto) {
      return _i45.CreatedMealPlanVarianceDto.fromJson(data) as T;
    }
    if (t == _i46.GenerateNutritionPlanProgressDto) {
      return _i46.GenerateNutritionPlanProgressDto.fromJson(data) as T;
    }
    if (t == _i47.UpdateMealPlanFoodDto) {
      return _i47.UpdateMealPlanFoodDto.fromJson(data) as T;
    }
    if (t == _i48.MealPlan) {
      return _i48.MealPlan.fromJson(data) as T;
    }
    if (t == _i49.MealPlanFood) {
      return _i49.MealPlanFood.fromJson(data) as T;
    }
    if (t == _i50.MealPlanType) {
      return _i50.MealPlanType.fromJson(data) as T;
    }
    if (t == _i51.NutritionPlan) {
      return _i51.NutritionPlan.fromJson(data) as T;
    }
    if (t == _i52.UserFoodPreferencesResponseDto) {
      return _i52.UserFoodPreferencesResponseDto.fromJson(data) as T;
    }
    if (t == _i53.UserProfile) {
      return _i53.UserProfile.fromJson(data) as T;
    }
    if (t == _i54.AuthMethod) {
      return _i54.AuthMethod.fromJson(data) as T;
    }
    if (t == _i55.CreateWorkoutExerciseDto) {
      return _i55.CreateWorkoutExerciseDto.fromJson(data) as T;
    }
    if (t == _i56.CreateWorkoutPlanDto) {
      return _i56.CreateWorkoutPlanDto.fromJson(data) as T;
    }
    if (t == _i57.CreateWorkoutSessionDto) {
      return _i57.CreateWorkoutSessionDto.fromJson(data) as T;
    }
    if (t == _i58.GenerateWorkoutPlanProgressDto) {
      return _i58.GenerateWorkoutPlanProgressDto.fromJson(data) as T;
    }
    if (t == _i59.WorkoutProgressMetricsDto) {
      return _i59.WorkoutProgressMetricsDto.fromJson(data) as T;
    }
    if (t == _i60.WorkoutSessionsByDateDto) {
      return _i60.WorkoutSessionsByDateDto.fromJson(data) as T;
    }
    if (t == _i61.ExerciseLog) {
      return _i61.ExerciseLog.fromJson(data) as T;
    }
    if (t == _i62.WorkoutExercise) {
      return _i62.WorkoutExercise.fromJson(data) as T;
    }
    if (t == _i63.WorkoutPlan) {
      return _i63.WorkoutPlan.fromJson(data) as T;
    }
    if (t == _i64.WorkoutSession) {
      return _i64.WorkoutSession.fromJson(data) as T;
    }
    if (t == _i65.WorkoutTip) {
      return _i65.WorkoutTip.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.ActivityLevel?>()) {
      return (data != null ? _i2.ActivityLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.BodyGoal?>()) {
      return (data != null ? _i3.BodyGoal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.ExerciseDifficulty?>()) {
      return (data != null ? _i4.ExerciseDifficulty.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Sex?>()) {
      return (data != null ? _i5.Sex.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Status?>()) {
      return (data != null ? _i6.Status.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.StreamStatus?>()) {
      return (data != null ? _i7.StreamStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.StringList?>()) {
      return (data != null ? _i8.StringList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.WeightCategory?>()) {
      return (data != null ? _i9.WeightCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.AppException?>()) {
      return (data != null ? _i10.AppException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.GenericException?>()) {
      return (data != null ? _i11.GenericException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.WeeklySummaryDto?>()) {
      return (data != null ? _i12.WeeklySummaryDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.EmailTemplate?>()) {
      return (data != null ? _i13.EmailTemplate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.EmailTemplatesEnum?>()) {
      return (data != null ? _i14.EmailTemplatesEnum.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.Exercise?>()) {
      return (data != null ? _i15.Exercise.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.ExerciseAlternative?>()) {
      return (data != null ? _i16.ExerciseAlternative.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.ExerciseCategory?>()) {
      return (data != null ? _i17.ExerciseCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.ExerciseImage?>()) {
      return (data != null ? _i18.ExerciseImage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.ExerciseImageOrder?>()) {
      return (data != null ? _i19.ExerciseImageOrder.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.ExerciseMuscleGroup?>()) {
      return (data != null ? _i20.ExerciseMuscleGroup.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.CreateMicronutrientDto?>()) {
      return (data != null ? _i21.CreateMicronutrientDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.CreateServingSizeDto?>()) {
      return (data != null ? _i22.CreateServingSizeDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.FoodCatalogueDto?>()) {
      return (data != null ? _i23.FoodCatalogueDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.FoodCategoryDetailDto?>()) {
      return (data != null ? _i24.FoodCategoryDetailDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.SearchEndpointsResponseDto?>()) {
      return (data != null
              ? _i25.SearchEndpointsResponseDto.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i26.DietaryRestriction?>()) {
      return (data != null ? _i26.DietaryRestriction.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i27.Food?>()) {
      return (data != null ? _i27.Food.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.FoodCategory?>()) {
      return (data != null ? _i28.FoodCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.FoodCategoryList?>()) {
      return (data != null ? _i29.FoodCategoryList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.FoodMicronutrient?>()) {
      return (data != null ? _i30.FoodMicronutrient.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.FoodServingSize?>()) {
      return (data != null ? _i31.FoodServingSize.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.UserFoodPreference?>()) {
      return (data != null ? _i32.UserFoodPreference.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i33.UserFoodPreferenceType?>()) {
      return (data != null ? _i33.UserFoodPreferenceType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i34.CreateFoodIntakeLog?>()) {
      return (data != null ? _i34.CreateFoodIntakeLog.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i35.MacrosResponseDto?>()) {
      return (data != null ? _i35.MacrosResponseDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.MealDistributionDto?>()) {
      return (data != null ? _i36.MealDistributionDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i37.MealIndividualDistributionDto?>()) {
      return (data != null
              ? _i37.MealIndividualDistributionDto.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i38.FoodIntakeLog?>()) {
      return (data != null ? _i38.FoodIntakeLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.CreateMealPlanDto?>()) {
      return (data != null ? _i39.CreateMealPlanDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.CreateMealPlanDetailDto?>()) {
      return (data != null ? _i40.CreateMealPlanDetailDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i41.CreateMealPlanFoodDto?>()) {
      return (data != null ? _i41.CreateMealPlanFoodDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i42.CreatedMealPlanDto?>()) {
      return (data != null ? _i42.CreatedMealPlanDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i43.CreatedMealPlanIdDto?>()) {
      return (data != null ? _i43.CreatedMealPlanIdDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i44.CreatedMealPlanTotalsDto?>()) {
      return (data != null
              ? _i44.CreatedMealPlanTotalsDto.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i45.CreatedMealPlanVarianceDto?>()) {
      return (data != null
              ? _i45.CreatedMealPlanVarianceDto.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i46.GenerateNutritionPlanProgressDto?>()) {
      return (data != null
              ? _i46.GenerateNutritionPlanProgressDto.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i47.UpdateMealPlanFoodDto?>()) {
      return (data != null ? _i47.UpdateMealPlanFoodDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i48.MealPlan?>()) {
      return (data != null ? _i48.MealPlan.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.MealPlanFood?>()) {
      return (data != null ? _i49.MealPlanFood.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.MealPlanType?>()) {
      return (data != null ? _i50.MealPlanType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.NutritionPlan?>()) {
      return (data != null ? _i51.NutritionPlan.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.UserFoodPreferencesResponseDto?>()) {
      return (data != null
              ? _i52.UserFoodPreferencesResponseDto.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i53.UserProfile?>()) {
      return (data != null ? _i53.UserProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.AuthMethod?>()) {
      return (data != null ? _i54.AuthMethod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.CreateWorkoutExerciseDto?>()) {
      return (data != null
              ? _i55.CreateWorkoutExerciseDto.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i56.CreateWorkoutPlanDto?>()) {
      return (data != null ? _i56.CreateWorkoutPlanDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i57.CreateWorkoutSessionDto?>()) {
      return (data != null ? _i57.CreateWorkoutSessionDto.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i58.GenerateWorkoutPlanProgressDto?>()) {
      return (data != null
              ? _i58.GenerateWorkoutPlanProgressDto.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i59.WorkoutProgressMetricsDto?>()) {
      return (data != null
              ? _i59.WorkoutProgressMetricsDto.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i60.WorkoutSessionsByDateDto?>()) {
      return (data != null
              ? _i60.WorkoutSessionsByDateDto.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i61.ExerciseLog?>()) {
      return (data != null ? _i61.ExerciseLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.WorkoutExercise?>()) {
      return (data != null ? _i62.WorkoutExercise.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.WorkoutPlan?>()) {
      return (data != null ? _i63.WorkoutPlan.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.WorkoutSession?>()) {
      return (data != null ? _i64.WorkoutSession.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.WorkoutTip?>()) {
      return (data != null ? _i65.WorkoutTip.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i17.ExerciseCategory>) {
      return (data as List)
              .map((e) => deserialize<_i17.ExerciseCategory>(e))
              .toList()
          as T;
    }
    if (t == List<_i20.ExerciseMuscleGroup>) {
      return (data as List)
              .map((e) => deserialize<_i20.ExerciseMuscleGroup>(e))
              .toList()
          as T;
    }
    if (t == List<_i18.ExerciseImage>) {
      return (data as List)
              .map((e) => deserialize<_i18.ExerciseImage>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i18.ExerciseImage>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i18.ExerciseImage>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i16.ExerciseAlternative>) {
      return (data as List)
              .map((e) => deserialize<_i16.ExerciseAlternative>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i16.ExerciseAlternative>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i16.ExerciseAlternative>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i24.FoodCategoryDetailDto>) {
      return (data as List)
              .map((e) => deserialize<_i24.FoodCategoryDetailDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i27.Food>) {
      return (data as List).map((e) => deserialize<_i27.Food>(e)).toList() as T;
    }
    if (t == List<_i30.FoodMicronutrient>) {
      return (data as List)
              .map((e) => deserialize<_i30.FoodMicronutrient>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i30.FoodMicronutrient>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i30.FoodMicronutrient>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i31.FoodServingSize>) {
      return (data as List)
              .map((e) => deserialize<_i31.FoodServingSize>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i31.FoodServingSize>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i31.FoodServingSize>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i28.FoodCategory>) {
      return (data as List)
              .map((e) => deserialize<_i28.FoodCategory>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i28.FoodCategory>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i28.FoodCategory>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == _i1.getType<List<_i27.Food>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<_i27.Food>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i40.CreateMealPlanDetailDto>) {
      return (data as List)
              .map((e) => deserialize<_i40.CreateMealPlanDetailDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i41.CreateMealPlanFoodDto>) {
      return (data as List)
              .map((e) => deserialize<_i41.CreateMealPlanFoodDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i43.CreatedMealPlanIdDto>) {
      return (data as List)
              .map((e) => deserialize<_i43.CreatedMealPlanIdDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i49.MealPlanFood>) {
      return (data as List)
              .map((e) => deserialize<_i49.MealPlanFood>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i49.MealPlanFood>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i49.MealPlanFood>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i48.MealPlan>) {
      return (data as List).map((e) => deserialize<_i48.MealPlan>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i48.MealPlan>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i48.MealPlan>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i32.UserFoodPreference>) {
      return (data as List)
              .map((e) => deserialize<_i32.UserFoodPreference>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i57.CreateWorkoutSessionDto>) {
      return (data as List)
              .map((e) => deserialize<_i57.CreateWorkoutSessionDto>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i57.CreateWorkoutSessionDto>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i57.CreateWorkoutSessionDto>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i55.CreateWorkoutExerciseDto>) {
      return (data as List)
              .map((e) => deserialize<_i55.CreateWorkoutExerciseDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i64.WorkoutSession>) {
      return (data as List)
              .map((e) => deserialize<_i64.WorkoutSession>(e))
              .toList()
          as T;
    }
    if (t == List<_i61.ExerciseLog>) {
      return (data as List)
              .map((e) => deserialize<_i61.ExerciseLog>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i61.ExerciseLog>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i61.ExerciseLog>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == _i1.getType<List<_i64.WorkoutSession>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i64.WorkoutSession>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i62.WorkoutExercise>) {
      return (data as List)
              .map((e) => deserialize<_i62.WorkoutExercise>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i62.WorkoutExercise>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i62.WorkoutExercise>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i66.Exercise>) {
      return (data as List).map((e) => deserialize<_i66.Exercise>(e)).toList()
          as T;
    }
    if (t == List<_i67.ExerciseCategory>) {
      return (data as List)
              .map((e) => deserialize<_i67.ExerciseCategory>(e))
              .toList()
          as T;
    }
    if (t == List<_i68.ExerciseMuscleGroup>) {
      return (data as List)
              .map((e) => deserialize<_i68.ExerciseMuscleGroup>(e))
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
    if (t == List<_i69.ExerciseImage>) {
      return (data as List)
              .map((e) => deserialize<_i69.ExerciseImage>(e))
              .toList()
          as T;
    }
    if (t == List<_i70.ExerciseImageOrder>) {
      return (data as List)
              .map((e) => deserialize<_i70.ExerciseImageOrder>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i67.ExerciseCategory>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i67.ExerciseCategory>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == _i1.getType<List<_i68.ExerciseMuscleGroup>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i68.ExerciseMuscleGroup>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i71.ExerciseDifficulty>) {
      return (data as List)
              .map((e) => deserialize<_i71.ExerciseDifficulty>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i71.ExerciseDifficulty>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i71.ExerciseDifficulty>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i72.FoodCategory>) {
      return (data as List)
              .map((e) => deserialize<_i72.FoodCategory>(e))
              .toList()
          as T;
    }
    if (t == List<_i73.Food>) {
      return (data as List).map((e) => deserialize<_i73.Food>(e)).toList() as T;
    }
    if (t == List<_i74.CreateServingSizeDto>) {
      return (data as List)
              .map((e) => deserialize<_i74.CreateServingSizeDto>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i74.CreateServingSizeDto>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i74.CreateServingSizeDto>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i75.CreateMicronutrientDto>) {
      return (data as List)
              .map((e) => deserialize<_i75.CreateMicronutrientDto>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i75.CreateMicronutrientDto>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i75.CreateMicronutrientDto>(e))
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
    if (t == List<_i76.FoodIntakeLog>) {
      return (data as List)
              .map((e) => deserialize<_i76.FoodIntakeLog>(e))
              .toList()
          as T;
    }
    if (t == List<_i77.MealPlanType>) {
      return (data as List)
              .map((e) => deserialize<_i77.MealPlanType>(e))
              .toList()
          as T;
    }
    if (t == List<_i78.ExerciseLog>) {
      return (data as List)
              .map((e) => deserialize<_i78.ExerciseLog>(e))
              .toList()
          as T;
    }
    if (t == List<_i79.WorkoutSession>) {
      return (data as List)
              .map((e) => deserialize<_i79.WorkoutSession>(e))
              .toList()
          as T;
    }
    if (t == List<_i80.WorkoutSessionsByDateDto>) {
      return (data as List)
              .map((e) => deserialize<_i80.WorkoutSessionsByDateDto>(e))
              .toList()
          as T;
    }
    try {
      return _i81.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.ActivityLevel => 'ActivityLevel',
      _i3.BodyGoal => 'BodyGoal',
      _i4.ExerciseDifficulty => 'ExerciseDifficulty',
      _i5.Sex => 'Sex',
      _i6.Status => 'Status',
      _i7.StreamStatus => 'StreamStatus',
      _i8.StringList => 'StringList',
      _i9.WeightCategory => 'WeightCategory',
      _i10.AppException => 'AppException',
      _i11.GenericException => 'GenericException',
      _i12.WeeklySummaryDto => 'WeeklySummaryDto',
      _i13.EmailTemplate => 'EmailTemplate',
      _i14.EmailTemplatesEnum => 'EmailTemplatesEnum',
      _i15.Exercise => 'Exercise',
      _i16.ExerciseAlternative => 'ExerciseAlternative',
      _i17.ExerciseCategory => 'ExerciseCategory',
      _i18.ExerciseImage => 'ExerciseImage',
      _i19.ExerciseImageOrder => 'ExerciseImageOrder',
      _i20.ExerciseMuscleGroup => 'ExerciseMuscleGroup',
      _i21.CreateMicronutrientDto => 'CreateMicronutrientDto',
      _i22.CreateServingSizeDto => 'CreateServingSizeDto',
      _i23.FoodCatalogueDto => 'FoodCatalogueDto',
      _i24.FoodCategoryDetailDto => 'FoodCategoryDetailDto',
      _i25.SearchEndpointsResponseDto => 'SearchEndpointsResponseDto',
      _i26.DietaryRestriction => 'DietaryRestriction',
      _i27.Food => 'Food',
      _i28.FoodCategory => 'FoodCategory',
      _i29.FoodCategoryList => 'FoodCategoryList',
      _i30.FoodMicronutrient => 'FoodMicronutrient',
      _i31.FoodServingSize => 'FoodServingSize',
      _i32.UserFoodPreference => 'UserFoodPreference',
      _i33.UserFoodPreferenceType => 'UserFoodPreferenceType',
      _i34.CreateFoodIntakeLog => 'CreateFoodIntakeLog',
      _i35.MacrosResponseDto => 'MacrosResponseDto',
      _i36.MealDistributionDto => 'MealDistributionDto',
      _i37.MealIndividualDistributionDto => 'MealIndividualDistributionDto',
      _i38.FoodIntakeLog => 'FoodIntakeLog',
      _i39.CreateMealPlanDto => 'CreateMealPlanDto',
      _i40.CreateMealPlanDetailDto => 'CreateMealPlanDetailDto',
      _i41.CreateMealPlanFoodDto => 'CreateMealPlanFoodDto',
      _i42.CreatedMealPlanDto => 'CreatedMealPlanDto',
      _i43.CreatedMealPlanIdDto => 'CreatedMealPlanIdDto',
      _i44.CreatedMealPlanTotalsDto => 'CreatedMealPlanTotalsDto',
      _i45.CreatedMealPlanVarianceDto => 'CreatedMealPlanVarianceDto',
      _i46.GenerateNutritionPlanProgressDto =>
        'GenerateNutritionPlanProgressDto',
      _i47.UpdateMealPlanFoodDto => 'UpdateMealPlanFoodDto',
      _i48.MealPlan => 'MealPlan',
      _i49.MealPlanFood => 'MealPlanFood',
      _i50.MealPlanType => 'MealPlanType',
      _i51.NutritionPlan => 'NutritionPlan',
      _i52.UserFoodPreferencesResponseDto => 'UserFoodPreferencesResponseDto',
      _i53.UserProfile => 'UserProfile',
      _i54.AuthMethod => 'AuthMethod',
      _i55.CreateWorkoutExerciseDto => 'CreateWorkoutExerciseDto',
      _i56.CreateWorkoutPlanDto => 'CreateWorkoutPlanDto',
      _i57.CreateWorkoutSessionDto => 'CreateWorkoutSessionDto',
      _i58.GenerateWorkoutPlanProgressDto => 'GenerateWorkoutPlanProgressDto',
      _i59.WorkoutProgressMetricsDto => 'WorkoutProgressMetricsDto',
      _i60.WorkoutSessionsByDateDto => 'WorkoutSessionsByDateDto',
      _i61.ExerciseLog => 'ExerciseLog',
      _i62.WorkoutExercise => 'WorkoutExercise',
      _i63.WorkoutPlan => 'WorkoutPlan',
      _i64.WorkoutSession => 'WorkoutSession',
      _i65.WorkoutTip => 'WorkoutTip',
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
      case _i2.ActivityLevel():
        return 'ActivityLevel';
      case _i3.BodyGoal():
        return 'BodyGoal';
      case _i4.ExerciseDifficulty():
        return 'ExerciseDifficulty';
      case _i5.Sex():
        return 'Sex';
      case _i6.Status():
        return 'Status';
      case _i7.StreamStatus():
        return 'StreamStatus';
      case _i8.StringList():
        return 'StringList';
      case _i9.WeightCategory():
        return 'WeightCategory';
      case _i10.AppException():
        return 'AppException';
      case _i11.GenericException():
        return 'GenericException';
      case _i12.WeeklySummaryDto():
        return 'WeeklySummaryDto';
      case _i13.EmailTemplate():
        return 'EmailTemplate';
      case _i14.EmailTemplatesEnum():
        return 'EmailTemplatesEnum';
      case _i15.Exercise():
        return 'Exercise';
      case _i16.ExerciseAlternative():
        return 'ExerciseAlternative';
      case _i17.ExerciseCategory():
        return 'ExerciseCategory';
      case _i18.ExerciseImage():
        return 'ExerciseImage';
      case _i19.ExerciseImageOrder():
        return 'ExerciseImageOrder';
      case _i20.ExerciseMuscleGroup():
        return 'ExerciseMuscleGroup';
      case _i21.CreateMicronutrientDto():
        return 'CreateMicronutrientDto';
      case _i22.CreateServingSizeDto():
        return 'CreateServingSizeDto';
      case _i23.FoodCatalogueDto():
        return 'FoodCatalogueDto';
      case _i24.FoodCategoryDetailDto():
        return 'FoodCategoryDetailDto';
      case _i25.SearchEndpointsResponseDto():
        return 'SearchEndpointsResponseDto';
      case _i26.DietaryRestriction():
        return 'DietaryRestriction';
      case _i27.Food():
        return 'Food';
      case _i28.FoodCategory():
        return 'FoodCategory';
      case _i29.FoodCategoryList():
        return 'FoodCategoryList';
      case _i30.FoodMicronutrient():
        return 'FoodMicronutrient';
      case _i31.FoodServingSize():
        return 'FoodServingSize';
      case _i32.UserFoodPreference():
        return 'UserFoodPreference';
      case _i33.UserFoodPreferenceType():
        return 'UserFoodPreferenceType';
      case _i34.CreateFoodIntakeLog():
        return 'CreateFoodIntakeLog';
      case _i35.MacrosResponseDto():
        return 'MacrosResponseDto';
      case _i36.MealDistributionDto():
        return 'MealDistributionDto';
      case _i37.MealIndividualDistributionDto():
        return 'MealIndividualDistributionDto';
      case _i38.FoodIntakeLog():
        return 'FoodIntakeLog';
      case _i39.CreateMealPlanDto():
        return 'CreateMealPlanDto';
      case _i40.CreateMealPlanDetailDto():
        return 'CreateMealPlanDetailDto';
      case _i41.CreateMealPlanFoodDto():
        return 'CreateMealPlanFoodDto';
      case _i42.CreatedMealPlanDto():
        return 'CreatedMealPlanDto';
      case _i43.CreatedMealPlanIdDto():
        return 'CreatedMealPlanIdDto';
      case _i44.CreatedMealPlanTotalsDto():
        return 'CreatedMealPlanTotalsDto';
      case _i45.CreatedMealPlanVarianceDto():
        return 'CreatedMealPlanVarianceDto';
      case _i46.GenerateNutritionPlanProgressDto():
        return 'GenerateNutritionPlanProgressDto';
      case _i47.UpdateMealPlanFoodDto():
        return 'UpdateMealPlanFoodDto';
      case _i48.MealPlan():
        return 'MealPlan';
      case _i49.MealPlanFood():
        return 'MealPlanFood';
      case _i50.MealPlanType():
        return 'MealPlanType';
      case _i51.NutritionPlan():
        return 'NutritionPlan';
      case _i52.UserFoodPreferencesResponseDto():
        return 'UserFoodPreferencesResponseDto';
      case _i53.UserProfile():
        return 'UserProfile';
      case _i54.AuthMethod():
        return 'AuthMethod';
      case _i55.CreateWorkoutExerciseDto():
        return 'CreateWorkoutExerciseDto';
      case _i56.CreateWorkoutPlanDto():
        return 'CreateWorkoutPlanDto';
      case _i57.CreateWorkoutSessionDto():
        return 'CreateWorkoutSessionDto';
      case _i58.GenerateWorkoutPlanProgressDto():
        return 'GenerateWorkoutPlanProgressDto';
      case _i59.WorkoutProgressMetricsDto():
        return 'WorkoutProgressMetricsDto';
      case _i60.WorkoutSessionsByDateDto():
        return 'WorkoutSessionsByDateDto';
      case _i61.ExerciseLog():
        return 'ExerciseLog';
      case _i62.WorkoutExercise():
        return 'WorkoutExercise';
      case _i63.WorkoutPlan():
        return 'WorkoutPlan';
      case _i64.WorkoutSession():
        return 'WorkoutSession';
      case _i65.WorkoutTip():
        return 'WorkoutTip';
    }
    className = _i81.Protocol().getClassNameForObject(data);
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
      return deserialize<_i2.ActivityLevel>(data['data']);
    }
    if (dataClassName == 'BodyGoal') {
      return deserialize<_i3.BodyGoal>(data['data']);
    }
    if (dataClassName == 'ExerciseDifficulty') {
      return deserialize<_i4.ExerciseDifficulty>(data['data']);
    }
    if (dataClassName == 'Sex') {
      return deserialize<_i5.Sex>(data['data']);
    }
    if (dataClassName == 'Status') {
      return deserialize<_i6.Status>(data['data']);
    }
    if (dataClassName == 'StreamStatus') {
      return deserialize<_i7.StreamStatus>(data['data']);
    }
    if (dataClassName == 'StringList') {
      return deserialize<_i8.StringList>(data['data']);
    }
    if (dataClassName == 'WeightCategory') {
      return deserialize<_i9.WeightCategory>(data['data']);
    }
    if (dataClassName == 'AppException') {
      return deserialize<_i10.AppException>(data['data']);
    }
    if (dataClassName == 'GenericException') {
      return deserialize<_i11.GenericException>(data['data']);
    }
    if (dataClassName == 'WeeklySummaryDto') {
      return deserialize<_i12.WeeklySummaryDto>(data['data']);
    }
    if (dataClassName == 'EmailTemplate') {
      return deserialize<_i13.EmailTemplate>(data['data']);
    }
    if (dataClassName == 'EmailTemplatesEnum') {
      return deserialize<_i14.EmailTemplatesEnum>(data['data']);
    }
    if (dataClassName == 'Exercise') {
      return deserialize<_i15.Exercise>(data['data']);
    }
    if (dataClassName == 'ExerciseAlternative') {
      return deserialize<_i16.ExerciseAlternative>(data['data']);
    }
    if (dataClassName == 'ExerciseCategory') {
      return deserialize<_i17.ExerciseCategory>(data['data']);
    }
    if (dataClassName == 'ExerciseImage') {
      return deserialize<_i18.ExerciseImage>(data['data']);
    }
    if (dataClassName == 'ExerciseImageOrder') {
      return deserialize<_i19.ExerciseImageOrder>(data['data']);
    }
    if (dataClassName == 'ExerciseMuscleGroup') {
      return deserialize<_i20.ExerciseMuscleGroup>(data['data']);
    }
    if (dataClassName == 'CreateMicronutrientDto') {
      return deserialize<_i21.CreateMicronutrientDto>(data['data']);
    }
    if (dataClassName == 'CreateServingSizeDto') {
      return deserialize<_i22.CreateServingSizeDto>(data['data']);
    }
    if (dataClassName == 'FoodCatalogueDto') {
      return deserialize<_i23.FoodCatalogueDto>(data['data']);
    }
    if (dataClassName == 'FoodCategoryDetailDto') {
      return deserialize<_i24.FoodCategoryDetailDto>(data['data']);
    }
    if (dataClassName == 'SearchEndpointsResponseDto') {
      return deserialize<_i25.SearchEndpointsResponseDto>(data['data']);
    }
    if (dataClassName == 'DietaryRestriction') {
      return deserialize<_i26.DietaryRestriction>(data['data']);
    }
    if (dataClassName == 'Food') {
      return deserialize<_i27.Food>(data['data']);
    }
    if (dataClassName == 'FoodCategory') {
      return deserialize<_i28.FoodCategory>(data['data']);
    }
    if (dataClassName == 'FoodCategoryList') {
      return deserialize<_i29.FoodCategoryList>(data['data']);
    }
    if (dataClassName == 'FoodMicronutrient') {
      return deserialize<_i30.FoodMicronutrient>(data['data']);
    }
    if (dataClassName == 'FoodServingSize') {
      return deserialize<_i31.FoodServingSize>(data['data']);
    }
    if (dataClassName == 'UserFoodPreference') {
      return deserialize<_i32.UserFoodPreference>(data['data']);
    }
    if (dataClassName == 'UserFoodPreferenceType') {
      return deserialize<_i33.UserFoodPreferenceType>(data['data']);
    }
    if (dataClassName == 'CreateFoodIntakeLog') {
      return deserialize<_i34.CreateFoodIntakeLog>(data['data']);
    }
    if (dataClassName == 'MacrosResponseDto') {
      return deserialize<_i35.MacrosResponseDto>(data['data']);
    }
    if (dataClassName == 'MealDistributionDto') {
      return deserialize<_i36.MealDistributionDto>(data['data']);
    }
    if (dataClassName == 'MealIndividualDistributionDto') {
      return deserialize<_i37.MealIndividualDistributionDto>(data['data']);
    }
    if (dataClassName == 'FoodIntakeLog') {
      return deserialize<_i38.FoodIntakeLog>(data['data']);
    }
    if (dataClassName == 'CreateMealPlanDto') {
      return deserialize<_i39.CreateMealPlanDto>(data['data']);
    }
    if (dataClassName == 'CreateMealPlanDetailDto') {
      return deserialize<_i40.CreateMealPlanDetailDto>(data['data']);
    }
    if (dataClassName == 'CreateMealPlanFoodDto') {
      return deserialize<_i41.CreateMealPlanFoodDto>(data['data']);
    }
    if (dataClassName == 'CreatedMealPlanDto') {
      return deserialize<_i42.CreatedMealPlanDto>(data['data']);
    }
    if (dataClassName == 'CreatedMealPlanIdDto') {
      return deserialize<_i43.CreatedMealPlanIdDto>(data['data']);
    }
    if (dataClassName == 'CreatedMealPlanTotalsDto') {
      return deserialize<_i44.CreatedMealPlanTotalsDto>(data['data']);
    }
    if (dataClassName == 'CreatedMealPlanVarianceDto') {
      return deserialize<_i45.CreatedMealPlanVarianceDto>(data['data']);
    }
    if (dataClassName == 'GenerateNutritionPlanProgressDto') {
      return deserialize<_i46.GenerateNutritionPlanProgressDto>(data['data']);
    }
    if (dataClassName == 'UpdateMealPlanFoodDto') {
      return deserialize<_i47.UpdateMealPlanFoodDto>(data['data']);
    }
    if (dataClassName == 'MealPlan') {
      return deserialize<_i48.MealPlan>(data['data']);
    }
    if (dataClassName == 'MealPlanFood') {
      return deserialize<_i49.MealPlanFood>(data['data']);
    }
    if (dataClassName == 'MealPlanType') {
      return deserialize<_i50.MealPlanType>(data['data']);
    }
    if (dataClassName == 'NutritionPlan') {
      return deserialize<_i51.NutritionPlan>(data['data']);
    }
    if (dataClassName == 'UserFoodPreferencesResponseDto') {
      return deserialize<_i52.UserFoodPreferencesResponseDto>(data['data']);
    }
    if (dataClassName == 'UserProfile') {
      return deserialize<_i53.UserProfile>(data['data']);
    }
    if (dataClassName == 'AuthMethod') {
      return deserialize<_i54.AuthMethod>(data['data']);
    }
    if (dataClassName == 'CreateWorkoutExerciseDto') {
      return deserialize<_i55.CreateWorkoutExerciseDto>(data['data']);
    }
    if (dataClassName == 'CreateWorkoutPlanDto') {
      return deserialize<_i56.CreateWorkoutPlanDto>(data['data']);
    }
    if (dataClassName == 'CreateWorkoutSessionDto') {
      return deserialize<_i57.CreateWorkoutSessionDto>(data['data']);
    }
    if (dataClassName == 'GenerateWorkoutPlanProgressDto') {
      return deserialize<_i58.GenerateWorkoutPlanProgressDto>(data['data']);
    }
    if (dataClassName == 'WorkoutProgressMetricsDto') {
      return deserialize<_i59.WorkoutProgressMetricsDto>(data['data']);
    }
    if (dataClassName == 'WorkoutSessionsByDateDto') {
      return deserialize<_i60.WorkoutSessionsByDateDto>(data['data']);
    }
    if (dataClassName == 'ExerciseLog') {
      return deserialize<_i61.ExerciseLog>(data['data']);
    }
    if (dataClassName == 'WorkoutExercise') {
      return deserialize<_i62.WorkoutExercise>(data['data']);
    }
    if (dataClassName == 'WorkoutPlan') {
      return deserialize<_i63.WorkoutPlan>(data['data']);
    }
    if (dataClassName == 'WorkoutSession') {
      return deserialize<_i64.WorkoutSession>(data['data']);
    }
    if (dataClassName == 'WorkoutTip') {
      return deserialize<_i65.WorkoutTip>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i81.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
