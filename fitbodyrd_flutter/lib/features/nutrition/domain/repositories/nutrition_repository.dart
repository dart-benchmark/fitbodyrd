import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:record_result/record_result.dart';

abstract class NutritionRepository {
  FutureResult<NutritionPlan> getActiveNutritionPlan();

  Stream<GenerateNutritionPlanProgressDto> requestNutritionPlanGeneration({
    required int weeks,
    required List<MealPlanType> mealTypes,
  });
  FutureResult<List<FoodIntakeLog>> getFoodIntakeLogs(DateTime date);

  FutureResult<FoodIntakeLog> logFoodIntake(CreateFoodIntakeLog dto);

  FutureResult<void> deleteFoodIntakeLog(int id);

  FutureResult<MealPlanFood> updateMealPlanFood({
    required int mealPlanFoodId,
    required double servingQuantity,
    required int servingSizeId,
    required double quantityGrams,
  });

  FutureResult<bool> deleteMealPlanFood({
    required int mealPlanFoodId,
  });

  FutureResult<List<Food>> searchFoods({
    required String query,
    int? categoryId,
    int? limit,
  });

  FutureResult<MealPlanFood> addMealPlanFood({
    required int mealPlanId,
    required int foodId,
    required int servingSizeId,
    required double servingQuantity,
    required double quantityGrams,
  });
}
