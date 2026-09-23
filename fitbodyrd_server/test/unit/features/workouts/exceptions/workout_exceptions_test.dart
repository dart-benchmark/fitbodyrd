import 'package:fitbodyrd_server/src/features/workouts/exceptions/workout_exceptions.dart';
import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  group('WorkoutExceptions', () {
    group('activeWorkoutPlanExists', () {
      test('should create exception with correct module', () {
        // Act
        final exception = WorkoutExceptions.activeWorkoutPlanExists();

        // Assert
        expect(exception.module, equals('workout'));
      });

      test('should create exception with correct errorCode', () {
        // Act
        final exception = WorkoutExceptions.activeWorkoutPlanExists();

        // Assert
        expect(exception.errorCode, equals(7000));
      });

      test('should create exception with correct httpStatus', () {
        // Act
        final exception = WorkoutExceptions.activeWorkoutPlanExists();

        // Assert
        expect(exception.httpStatus, equals(400));
      });

      test('should create exception with correct message', () {
        // Act
        final exception = WorkoutExceptions.activeWorkoutPlanExists();

        // Assert
        expect(exception.message, equals('Active workout plan already exists.'));
      });

      test('should create AppException instance', () {
        // Act
        final exception = WorkoutExceptions.activeWorkoutPlanExists();

        // Assert
        expect(exception, isA<AppException>());
      });
    });

    group('noActiveWorkoutPlan', () {
      test('should create exception with correct module', () {
        // Act
        final exception = WorkoutExceptions.noActiveWorkoutPlan();

        // Assert
        expect(exception.module, equals('workout'));
      });

      test('should create exception with correct errorCode', () {
        // Act
        final exception = WorkoutExceptions.noActiveWorkoutPlan();

        // Assert
        expect(exception.errorCode, equals(7001));
      });

      test('should create exception with correct httpStatus', () {
        // Act
        final exception = WorkoutExceptions.noActiveWorkoutPlan();

        // Assert
        expect(exception.httpStatus, equals(404));
      });

      test('should create exception with correct message', () {
        // Act
        final exception = WorkoutExceptions.noActiveWorkoutPlan();

        // Assert
        expect(exception.message, equals('No active workout plan found.'));
      });

      test('should create AppException instance', () {
        // Act
        final exception = WorkoutExceptions.noActiveWorkoutPlan();

        // Assert
        expect(exception, isA<AppException>());
      });
    });

    group('errorCreatingWorkoutPlan', () {
      test('should create exception with correct module', () {
        // Act
        final exception = WorkoutExceptions.errorCreatingWorkoutPlan();

        // Assert
        expect(exception.module, equals('workout'));
      });

      test('should create exception with correct errorCode', () {
        // Act
        final exception = WorkoutExceptions.errorCreatingWorkoutPlan();

        // Assert
        expect(exception.errorCode, equals(7002));
      });

      test('should create exception with correct httpStatus', () {
        // Act
        final exception = WorkoutExceptions.errorCreatingWorkoutPlan();

        // Assert
        expect(exception.httpStatus, equals(500));
      });

      test('should create exception with correct message', () {
        // Act
        final exception = WorkoutExceptions.errorCreatingWorkoutPlan();

        // Assert
        expect(exception.message, equals('Error creating workout plan.'));
      });

      test('should create AppException instance', () {
        // Act
        final exception = WorkoutExceptions.errorCreatingWorkoutPlan();

        // Assert
        expect(exception, isA<AppException>());
      });
    });

    group('exerciseLogNotFound', () {
      test('should create exception with correct module', () {
        // Act
        final exception = WorkoutExceptions.exerciseLogNotFound();

        // Assert
        expect(exception.module, equals('workout'));
      });

      test('should create exception with correct errorCode', () {
        // Act
        final exception = WorkoutExceptions.exerciseLogNotFound();

        // Assert
        expect(exception.errorCode, equals(7003));
      });

      test('should create exception with correct httpStatus', () {
        // Act
        final exception = WorkoutExceptions.exerciseLogNotFound();

        // Assert
        expect(exception.httpStatus, equals(404));
      });

      test('should create exception with correct message', () {
        // Act
        final exception = WorkoutExceptions.exerciseLogNotFound();

        // Assert
        expect(exception.message,
            equals('Exercise log not found or does not belong to the user.'));
      });

      test('should create AppException instance', () {
        // Act
        final exception = WorkoutExceptions.exerciseLogNotFound();

        // Assert
        expect(exception, isA<AppException>());
      });
    });
  });
}

