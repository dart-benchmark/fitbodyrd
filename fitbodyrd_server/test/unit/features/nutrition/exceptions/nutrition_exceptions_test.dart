import 'package:fitbodyrd_server/src/features/nutrition/exceptions/nutrition_exceptions.dart';
import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  group('NutritionExceptions', () {
    group('invalidMealTypesCount', () {
      test('should create exception with correct module', () {
        // Act
        final exception = NutritionExceptions.invalidMealTypesCount(1);

        // Assert
        expect(exception.module, equals('nutrition'));
      });

      test('should create exception with correct errorCode', () {
        // Act
        final exception = NutritionExceptions.invalidMealTypesCount(1);

        // Assert
        expect(exception.errorCode, equals(4000));
      });

      test('should create exception with correct httpStatus', () {
        // Act
        final exception = NutritionExceptions.invalidMealTypesCount(1);

        // Assert
        expect(exception.httpStatus, equals(400));
      });

      test('should create exception with message including count', () {
        // Act
        final exception1 = NutritionExceptions.invalidMealTypesCount(1);
        final exception2 = NutritionExceptions.invalidMealTypesCount(6);
        final exception3 = NutritionExceptions.invalidMealTypesCount(10);

        // Assert
        expect(exception1.message, contains('1'));
        expect(exception1.message, contains('Invalid number of meal types'));
        expect(exception1.message, contains('Must be between 2 and 5'));

        expect(exception2.message, contains('6'));
        expect(exception2.message, contains('Invalid number of meal types'));
        expect(exception2.message, contains('Must be between 2 and 5'));

        expect(exception3.message, contains('10'));
        expect(exception3.message, contains('Invalid number of meal types'));
        expect(exception3.message, contains('Must be between 2 and 5'));
      });

      test('should create AppException instance', () {
        // Act
        final exception = NutritionExceptions.invalidMealTypesCount(1);

        // Assert
        expect(exception, isA<AppException>());
      });

      test('should have consistent exception message format', () {
        // Act
        final exception = NutritionExceptions.invalidMealTypesCount(3);

        // Assert
        expect(
            exception.message,
            matches(
                r'Invalid number of meal types: \d+\. Must be between 2 and 5\.'));
      });
    });
  });
}
