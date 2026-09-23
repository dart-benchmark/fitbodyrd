import 'package:fitbodyrd_server/src/generated/protocol.dart';

abstract class NutritionExceptions {
  static const String module = 'nutrition';

  static AppException invalidMealTypesCount(int count) {
    return AppException(
      module: module,
      errorCode: 4000,
      httpStatus: 400,
      message: 'Invalid number of meal types: $count. Must be between 2 and 5.',
    );
  }
}
