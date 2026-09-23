import 'package:fitbodyrd_server/src/generated/errors/models/app_exception.dart';

abstract class FoodExceptions {
  static const String module = 'food';

  // Category exceptions: 3000-3099
  static AppException categoryNotFound(int categoryId) {
    return AppException(
      module: module,
      errorCode: 3000,
      httpStatus: 404,
      message: 'Food category with ID $categoryId not found.',
    );
  }

  static AppException categoryHasFoods(int categoryId) {
    return AppException(
      module: module,
      errorCode: 3001,
      httpStatus: 400,
      message:
          'Food category with ID $categoryId has associated foods and cannot be deleted.',
    );
  }

  static AppException categoryHasSubcategories(int categoryId) {
    return AppException(
      module: module,
      errorCode: 3002,
      httpStatus: 400,
      message:
          'Food category with ID $categoryId has subcategories and cannot be deleted.',
    );
  }

  // Food item exceptions: 3100-3199
  static AppException foodNotFound(int foodId) {
    return AppException(
      module: module,
      errorCode: 3100,
      httpStatus: 404,
      message: 'Food item with ID $foodId not found.',
    );
  }

  // Serving size exceptions: 3200-3299
  static AppException servingSizeNotFound(int servingSizeId) {
    return AppException(
      module: module,
      errorCode: 3200,
      httpStatus: 404,
      message: 'Serving size with ID $servingSizeId not found.',
    );
  }

  // Micronutrient exceptions: 3300-3399
  static AppException micronutrientNotFound(int micronutrientId) {
    return AppException(
      module: module,
      errorCode: 3300,
      httpStatus: 404,
      message: 'Micronutrient with ID $micronutrientId not found.',
    );
  }
}
