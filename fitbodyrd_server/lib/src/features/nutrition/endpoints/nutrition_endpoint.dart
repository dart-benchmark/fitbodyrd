import 'package:fitbodyrd_server/src/features/nutrition/exceptions/nutrition_exceptions.dart';
import 'package:fitbodyrd_server/src/features/user/endpoints/admin_user_endpoint.dart';
import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class NutritionEndpoint extends Endpoint {
  Future<MacrosResponseDto> calculateMacros(
    Session session,
    int userId,
    List<MealPlanType> mealTypes,
  ) async {
    final uniqueMealTypes = mealTypes.toSet().toList();
    if (uniqueMealTypes.length < 2 || uniqueMealTypes.length > 5) {
      throw NutritionExceptions.invalidMealTypesCount(uniqueMealTypes.length);
    }

    final userProfile =
        await AdminUserEndpoint().findUserProfile(session, userId);

    // Calculate BMR using Mifflin-St Jeor equation
    final weightKg = userProfile.weightKgs;
    final heightCm = userProfile.heightMs * 100;
    final age = userProfile.age!;

    double bmr;
    if (userProfile.sex == Sex.male) {
      bmr = (10 * weightKg) + (6.25 * heightCm) - (5 * age) + 5;
    } else {
      // For female and other
      bmr = (10 * weightKg) + (6.25 * heightCm) - (5 * age) - 161;
    }

    // Calculate TDEE based on activity level
    double activityFactor;
    switch (userProfile.activityLevel) {
      case ActivityLevel.sedentary:
        activityFactor = 1.2;
        break;
      case ActivityLevel.lightlyActive:
        activityFactor = 1.375;
        break;
      case ActivityLevel.moderatelyActive:
        activityFactor = 1.55;
        break;
      case ActivityLevel.active:
        activityFactor = 1.725;
        break;
      case ActivityLevel.veryActive:
        activityFactor = 1.9;
        break;
    }
    final tdee = bmr * activityFactor;

    // Calculate caloric adjustment based on body goal
    double caloricAdjustment;
    switch (userProfile.bodyGoal) {
      case BodyGoal.loseWeight:
        caloricAdjustment = -500;
        break;
      case BodyGoal.maintainWeight:
        caloricAdjustment = 0;
        break;
      case BodyGoal.gainMuscleMass:
        caloricAdjustment = 300;
        break;
    }
    final targetCalories = tdee + caloricAdjustment;

    // Calculate macro percentages based on body goal
    double proteinPercentage;
    double carbsPercentage;
    double fatsPercentage;
    switch (userProfile.bodyGoal) {
      case BodyGoal.loseWeight:
        proteinPercentage = 30;
        carbsPercentage = 40;
        fatsPercentage = 30;
        break;
      case BodyGoal.maintainWeight:
        proteinPercentage = 25;
        carbsPercentage = 45;
        fatsPercentage = 30;
        break;
      case BodyGoal.gainMuscleMass:
        proteinPercentage = 30;
        carbsPercentage = 45;
        fatsPercentage = 25;
        break;
    }

    // Calculate daily macros in grams
    final dailyProteins = (targetCalories * (proteinPercentage / 100)) / 4;
    final dailyCarbs = (targetCalories * (carbsPercentage / 100)) / 4;
    final dailyFats = (targetCalories * (fatsPercentage / 100)) / 9;
    final proteinGramsPerKg = dailyProteins / weightKg;

    // Calculate meal distribution based on meal types
    final mealWeights = {
      MealPlanType.breakfast: 3.0,
      MealPlanType.brunch: 4.0,
      MealPlanType.lunch: 4.5,
      MealPlanType.snack: 1.0,
      MealPlanType.dinner: 3.5,
    };

    // Calculate total weight
    final totalWeight = uniqueMealTypes.fold<double>(
      0.0,
      (sum, mealType) => sum + mealWeights[mealType]!,
    );

    // Create meal distribution
    MealIndividualDistributionDto? createMealDistribution(
        MealPlanType mealType) {
      if (!uniqueMealTypes.contains(mealType)) return null;

      final weight = mealWeights[mealType]!;
      final percentage = (weight / totalWeight) * 100;
      final calories = targetCalories * (percentage / 100);
      final proteins = dailyProteins * (percentage / 100);
      final carbs = dailyCarbs * (percentage / 100);
      final fats = dailyFats * (percentage / 100);

      return MealIndividualDistributionDto(
        calories: calories,
        proteins: proteins,
        carbs: carbs,
        fats: fats,
        percentage: percentage,
      );
    }

    final mealDistribution = MealDistributionDto(
      breakfast: createMealDistribution(MealPlanType.breakfast),
      brunch: createMealDistribution(MealPlanType.brunch),
      lunch: createMealDistribution(MealPlanType.lunch),
      snack: createMealDistribution(MealPlanType.snack),
      dinner: createMealDistribution(MealPlanType.dinner),
    );

    return MacrosResponseDto(
      bmr: bmr,
      tdee: tdee,
      targetCalories: targetCalories,
      caloricAdjustment: caloricAdjustment,
      dailyProteins: dailyProteins,
      dailyCarbs: dailyCarbs,
      dailyFats: dailyFats,
      proteinPercentage: proteinPercentage,
      carbsPercentage: carbsPercentage,
      fatsPercentage: fatsPercentage,
      proteinGramsPerKg: proteinGramsPerKg,
      mealDistribution: mealDistribution,
    );
  }
}
