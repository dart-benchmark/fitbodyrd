import 'package:fitbodyrd_server/src/features/exercise/exceptions/exercise_exceptions.dart';
import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  group('ExerciseExceptions', () {
    group('equipmentMissing', () {
      test('should create exception with correct module', () {
        // Act
        final exception = ExerciseExceptions.equipmentMissing();

        // Assert
        expect(exception.module, equals('exercise'));
      });

      test('should create exception with correct errorCode', () {
        // Act
        final exception = ExerciseExceptions.equipmentMissing();

        // Assert
        expect(exception.errorCode, equals(2000));
      });

      test('should create exception with correct httpStatus', () {
        // Act
        final exception = ExerciseExceptions.equipmentMissing();

        // Assert
        expect(exception.httpStatus, equals(400));
      });

      test('should create exception with correct message', () {
        // Act
        final exception = ExerciseExceptions.equipmentMissing();

        // Assert
        expect(exception.message,
            equals('Required equipment is missing for the exercise.'));
      });

      test('should create AppException instance', () {
        // Act
        final exception = ExerciseExceptions.equipmentMissing();

        // Assert
        expect(exception, isA<AppException>());
      });
    });

    group('imageNotFound', () {
      test('should create exception with correct module', () {
        // Act
        final exception = ExerciseExceptions.imageNotFound();

        // Assert
        expect(exception.module, equals('exercise'));
      });

      test('should create exception with correct errorCode', () {
        // Act
        final exception = ExerciseExceptions.imageNotFound();

        // Assert
        expect(exception.errorCode, equals(2001));
      });

      test('should create exception with correct httpStatus', () {
        // Act
        final exception = ExerciseExceptions.imageNotFound();

        // Assert
        expect(exception.httpStatus, equals(404));
      });

      test('should create exception with correct message', () {
        // Act
        final exception = ExerciseExceptions.imageNotFound();

        // Assert
        expect(exception.message, equals('Exercise image not found.'));
      });

      test('should create AppException instance', () {
        // Act
        final exception = ExerciseExceptions.imageNotFound();

        // Assert
        expect(exception, isA<AppException>());
      });
    });

    group('invalidImageOrder', () {
      test('should create exception with correct module', () {
        // Act
        final exception = ExerciseExceptions.invalidImageOrder();

        // Assert
        expect(exception.module, equals('exercise'));
      });

      test('should create exception with correct errorCode', () {
        // Act
        final exception = ExerciseExceptions.invalidImageOrder();

        // Assert
        expect(exception.errorCode, equals(2002));
      });

      test('should create exception with correct httpStatus', () {
        // Act
        final exception = ExerciseExceptions.invalidImageOrder();

        // Assert
        expect(exception.httpStatus, equals(400));
      });

      test('should create exception with correct message', () {
        // Act
        final exception = ExerciseExceptions.invalidImageOrder();

        // Assert
        expect(exception.message, equals('Invalid image order provided.'));
      });

      test('should create AppException instance', () {
        // Act
        final exception = ExerciseExceptions.invalidImageOrder();

        // Assert
        expect(exception, isA<AppException>());
      });
    });

    group('nameAlreadyExists', () {
      test('should create exception with correct module', () {
        // Act
        final exception = ExerciseExceptions.nameAlreadyExists();

        // Assert
        expect(exception.module, equals('exercise'));
      });

      test('should create exception with correct errorCode', () {
        // Act
        final exception = ExerciseExceptions.nameAlreadyExists();

        // Assert
        expect(exception.errorCode, equals(2003));
      });

      test('should create exception with correct httpStatus', () {
        // Act
        final exception = ExerciseExceptions.nameAlreadyExists();

        // Assert
        expect(exception.httpStatus, equals(400));
      });

      test('should create exception with correct message', () {
        // Act
        final exception = ExerciseExceptions.nameAlreadyExists();

        // Assert
        expect(exception.message,
            equals('An exercise with the same name already exists.'));
      });

      test('should create AppException instance', () {
        // Act
        final exception = ExerciseExceptions.nameAlreadyExists();

        // Assert
        expect(exception, isA<AppException>());
      });
    });

    group('exerciseNotFound', () {
      test('should create exception with correct module', () {
        // Act
        final exception = ExerciseExceptions.exerciseNotFound();

        // Assert
        expect(exception.module, equals('exercise'));
      });

      test('should create exception with correct errorCode', () {
        // Act
        final exception = ExerciseExceptions.exerciseNotFound();

        // Assert
        expect(exception.errorCode, equals(2004));
      });

      test('should create exception with correct httpStatus', () {
        // Act
        final exception = ExerciseExceptions.exerciseNotFound();

        // Assert
        expect(exception.httpStatus, equals(404));
      });

      test('should create exception with correct message', () {
        // Act
        final exception = ExerciseExceptions.exerciseNotFound();

        // Assert
        expect(exception.message, equals('Exercise not found.'));
      });

      test('should create AppException instance', () {
        // Act
        final exception = ExerciseExceptions.exerciseNotFound();

        // Assert
        expect(exception, isA<AppException>());
      });
    });
  });
}

