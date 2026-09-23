import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

abstract class NutritionPlanExceptions {
  static const String module = 'nutrition_plan';

  static AppException activePlanAlreadyExists(int userId) {
    return AppException(
      module: module,
      errorCode: 5000,
      httpStatus: 409,
      message: 'Active nutrition plan already exists for user with ID $userId.',
    );
  }

  static AppException invalidNutritionValues() {
    return AppException(
      module: module,
      errorCode: 5001,
      httpStatus: 400,
      message:
          'Invalid nutrition values: daily calories, proteins, carbs, and fats must be greater than zero.',
    );
  }

  static AppException invalidDailyCalories(double dailyCalories) {
    return AppException(
      module: module,
      errorCode: 5002,
      httpStatus: 400,
      message:
          'Invalid daily calories: $dailyCalories. It must be between 1200 and 5000.',
    );
  }

  static AppException invalidDateRange(DateTime startDate, DateTime endDate) {
    return AppException(
      module: module,
      errorCode: 5003,
      httpStatus: 400,
      message:
          'Invalid date range: end date $endDate is before start date $startDate.',
    );
  }

  static AppException nutritionPlanNotFound(int planId) {
    return AppException(
      module: module,
      errorCode: 5004,
      httpStatus: 404,
      message: 'Nutrition plan with ID $planId not found.',
    );
  }

  static AppException noActiveNutritionPlan(int userId) {
    return AppException(
      module: module,
      errorCode: 5005,
      httpStatus: 404,
      message: 'No active nutrition plan found for user with ID $userId.',
    );
  }

  static AppException databaseException(
    DatabaseQueryException e,
  ) {
    final info = _extractIdAndTableFromDatabaseException(e.detail);

    return AppException(
      module: module,
      errorCode: 5006,
      httpStatus: 500,
      message: info != null
          ? "id: ${info.id} doesn't exists on table: ${info.table}"
          : 'Database error: ${e.message}',
    );
  }

  static AppException invalidQuantity() {
    return AppException(
      module: module,
      errorCode: 5007,
      httpStatus: 400,
      message:
          'Invalid quantity: serving quantity and quantity in grams must be greater than zero.',
    );
  }

  static AppException mealPlanFoodNotFound(int mealPlanFoodId) {
    return AppException(
      module: module,
      errorCode: 5008,
      httpStatus: 404,
      message: 'Meal plan food with ID $mealPlanFoodId not found.',
    );
  }

  static AppException servingSizeNotFound(int servingSizeId) {
    return AppException(
      module: module,
      errorCode: 5009,
      httpStatus: 404,
      message: 'Serving size with ID $servingSizeId not found.',
    );
  }

  static AppException servingSizeMismatch(
      int servingSizeFoodId, int mealPlanFoodId) {
    return AppException(
      module: module,
      errorCode: 5010,
      httpStatus: 400,
      message:
          'Serving size (food ID: $servingSizeFoodId) does not match the meal plan food (food ID: $mealPlanFoodId).',
    );
  }

  static AppException mealPlanNotFound(int mealPlanId) {
    return AppException(
      module: module,
      errorCode: 5011,
      httpStatus: 404,
      message: 'Meal plan with ID $mealPlanId not found.',
    );
  }

  static AppException foodAlreadyInMealPlan(int foodId, int mealPlanId) {
    return AppException(
      module: module,
      errorCode: 5012,
      httpStatus: 409,
      message:
          'Food with ID $foodId already exists in meal plan with ID $mealPlanId.',
    );
  }

  static ({int id, String table})? _extractIdAndTableFromDatabaseException(
    String? input,
  ) {
    if (input == null) return null;
    final regex = RegExp(r'\((\d+)\).*table\s+"([^"]+)"');
    final match = regex.firstMatch(input);

    if (match != null) {
      final id = int.parse(match.group(1)!);
      final table = match.group(2)!;
      return (id: id, table: table);
    }
    return null;
  }
}
