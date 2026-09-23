import 'package:fitbodyrd_server/src/generated/protocol.dart';

abstract class NutritionPlanUtils {
  static CreatedMealPlanVarianceDto calculateVariance({
    required CreatedMealPlanTotalsDto actual,
    required NutritionPlan target,
  }) {
    return CreatedMealPlanVarianceDto(
      calories: actual.calories - target.dailyCalories,
      proteins: actual.proteins - target.dailyProteins,
      carbs: actual.carbs - target.dailyCarbs,
      fats: actual.fats - target.dailyFats,
    );
  }

  static double calculateProgressPercentage({
    required int daysCompleted,
    required int totalDays,
  }) {
    if (totalDays == 0) return 0.0;
    return (daysCompleted / totalDays) * 100;
  }
}
