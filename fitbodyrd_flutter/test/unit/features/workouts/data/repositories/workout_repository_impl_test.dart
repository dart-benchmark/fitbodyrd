import 'dart:async';

import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/workouts/data/repositories/workout_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:record_result/record_result.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

// Mock classes
class MockClient extends Mock implements Client {}

class MockSessionManager extends Mock implements SessionManager {}

class MockEndpointWorkout extends Mock implements EndpointWorkout {}

// Helper functions for mock data
WorkoutPlan createMockWorkoutPlan({
  int id = 1,
  DateTime? startDate,
  DateTime? endDate,
}) {
  final today = startDate ?? DateTime(2024, 6, 15);
  return WorkoutPlan(
    id: id,
    userId: 1,
    name: 'Test Workout Plan',
    difficultyLevel: ExerciseDifficulty.beginner,
    startDate: today,
    endDate: endDate ?? today.add(const Duration(days: 14)),
    status: Status.active,
    sessions: [],
  );
}

WorkoutSession createMockWorkoutSession({
  int id = 1,
  DateTime? date,
  List<WorkoutExercise>? exercises,
}) {
  final targetDate = date ?? DateTime(2024, 6, 15);
  return WorkoutSession(
    id: id,
    workoutPlanId: 1,
    date: targetDate,
    dayName: 'Monday',
    focus: 'Upper Body',
    sessionComplete: false,
    exercises: exercises ?? [],
  );
}

ExerciseLog createMockExerciseLog({
  int? id,
  int exerciseId = 1,
  DateTime? date,
}) {
  return ExerciseLog(
    id: id,
    userId: 1,
    exerciseId: exerciseId,
    date: date ?? DateTime(2024, 6, 15),
    setsCompleted: 3,
    repsCompleted: 10,
    weightUsed: 50.0,
  );
}

WorkoutProgressMetricsDto createMockWorkoutProgressMetrics() {
  return WorkoutProgressMetricsDto(
    totalWorkoutsCompleted: 10,
    currentStreak: 5,
    longestStreak: 10,
    averageWorkoutsPerWeek: 3.0,
    totalExercisesLogged: 50,
    workoutsThisWeek: 3,
    workoutsThisMonth: 12,
  );
}

WorkoutSessionsByDateDto createMockWorkoutSessionsByDate({
  DateTime? date,
  List<WorkoutSession>? sessions,
  int totalExercisesCompleted = 0,
}) {
  return WorkoutSessionsByDateDto(
    date: date ?? DateTime(2024, 6, 15),
    sessions: sessions ?? [],
    totalExercisesCompleted: totalExercisesCompleted,
  );
}

void main() {
  group('WorkoutRepositoryImpl', () {
    late WorkoutRepositoryImpl repository;
    late MockClient mockClient;
    late MockSessionManager mockSessionManager;
    late MockEndpointWorkout mockEndpointWorkout;

    setUp(() {
      mockClient = MockClient();
      mockSessionManager = MockSessionManager();
      mockEndpointWorkout = MockEndpointWorkout();

      when(() => mockClient.workout).thenReturn(mockEndpointWorkout);

      // Mock signed in user
      when(() => mockSessionManager.signedInUser).thenReturn(
        UserInfo(
          id: 1,
          userIdentifier: 'test_user_1',
          userName: 'test_user',
          email: 'test@example.com',
          created: DateTime(2024),
          scopeNames: ['user'],
          blocked: false,
        ),
      );

      registerFallbackValue(Object());
      registerFallbackValue(createMockExerciseLog());

      repository = WorkoutRepositoryImpl(
        client: mockClient,
        sessionManager: mockSessionManager,
      );
    });

    group('getActiveWorkoutPlan', () {
      test('should return WorkoutPlan on success', () async {
        // Arrange
        final mockPlan = createMockWorkoutPlan();
        when(() => mockEndpointWorkout.getActiveWorkoutPlan(any()))
            .thenAnswer((_) async => mockPlan);

        // Act
        final result = await repository.getActiveWorkoutPlan();

        // Assert
        result.fold(
          (plan) {
            expect(plan, equals(mockPlan));
            expect(plan?.id, equals(1));
          },
          (failure) =>
              fail('Expected success, but got failure: ${failure.message}'),
        );
        verify(() => mockEndpointWorkout.getActiveWorkoutPlan(1)).called(1);
      });

      test('should return ServerFailure when AppException is thrown', () async {
        // Arrange
        final appException = AppException(
          module: 'workout',
          message: 'No active plan found',
          errorCode: 7001,
          httpStatus: 404,
        );
        when(() => mockEndpointWorkout.getActiveWorkoutPlan(any()))
            .thenThrow(appException);

        // Act
        final result = await repository.getActiveWorkoutPlan();

        // Assert
        result.fold(
          (plan) => fail('Expected failure, but got success: $plan'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.statusCode, equals(7001));
            expect(failure.message, equals('No active plan found'));
          },
        );
      });

      test('should throw Exception when user is not signed in', () {
        // Arrange
        when(() => mockSessionManager.signedInUser).thenReturn(null);

        // Act & Assert
        expect(
          () => repository.getActiveWorkoutPlan(),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('logWorkoutExercise', () {
      test('should return ExerciseLog on success', () async {
        // Arrange
        final mockLog = createMockExerciseLog(id: 1);
        when(() => mockEndpointWorkout.logWorkoutExercise(any()))
            .thenAnswer((_) async => mockLog);

        // Act
        final result = await repository.logWorkoutExercise(mockLog);

        // Assert
        result.fold(
          (log) {
            expect(log, equals(mockLog));
            expect(log?.id, equals(1));
          },
          (failure) =>
              fail('Expected success, but got failure: ${failure.message}'),
        );
        verify(() => mockEndpointWorkout.logWorkoutExercise(mockLog)).called(1);
      });

      test('should return ServerFailure when AppException is thrown', () async {
        // Arrange
        final mockLog = createMockExerciseLog();
        final appException = AppException(
          module: 'workout',
          message: 'Failed to log exercise',
          errorCode: 500,
          httpStatus: 500,
        );
        when(() => mockEndpointWorkout.logWorkoutExercise(any()))
            .thenThrow(appException);

        // Act
        final result = await repository.logWorkoutExercise(mockLog);

        // Assert
        result.fold(
          (log) => fail('Expected failure, but got success: $log'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.statusCode, equals(500));
          },
        );
      });
    });

    group('getExerciseLogs', () {
      test('should return list of ExerciseLog on success', () async {
        // Arrange
        final startDate = DateTime(2024, 6);
        final endDate = DateTime(2024, 6, 15);
        final exerciseIds = [1, 2];
        final mockLogs = [
          createMockExerciseLog(id: 1, date: startDate),
          createMockExerciseLog(id: 2, exerciseId: 2, date: endDate),
        ];
        when(
          () => mockEndpointWorkout.getExerciseLogs(
            any(),
            any(),
            any(),
          ),
        ).thenAnswer((_) async => mockLogs);

        // Act
        final result = await repository.getExerciseLogs(
          startDate: startDate,
          endDate: endDate,
          exerciseIds: exerciseIds,
        );

        // Assert
        result.fold(
          (logs) {
            expect(logs?.length, equals(2));
            expect(logs?.first.id, equals(1));
            expect(logs?.last.id, equals(2));
          },
          (failure) =>
              fail('Expected success, but got failure: ${failure.message}'),
        );
        verify(
          () => mockEndpointWorkout.getExerciseLogs(
            startDate,
            endDate,
            exerciseIds,
          ),
        ).called(1);
      });

      test('should return ServerFailure when AppException is thrown', () async {
        // Arrange
        final startDate = DateTime(2024, 6);
        final endDate = DateTime(2024, 6, 15);
        final exerciseIds = [1, 2];
        final appException = AppException(
          module: 'workout',
          message: 'Failed to fetch logs',
          errorCode: 500,
          httpStatus: 500,
        );
        when(
          () => mockEndpointWorkout.getExerciseLogs(
            any(),
            any(),
            any(),
          ),
        ).thenThrow(appException);

        // Act
        final result = await repository.getExerciseLogs(
          startDate: startDate,
          endDate: endDate,
          exerciseIds: exerciseIds,
        );

        // Assert
        result.fold(
          (logs) => fail('Expected failure, but got success: $logs'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.statusCode, equals(500));
          },
        );
      });
    });

    group('deleteExerciseLog', () {
      test('should return void on success', () async {
        // Arrange
        const logId = 1;
        when(() => mockEndpointWorkout.deleteExerciseLog(any()))
            .thenAnswer((_) async => {});

        // Act
        final result = await repository.deleteExerciseLog(logId);

        // Assert
        result.fold(
          (_) => expect(true, isTrue), // Success case
          (failure) =>
              fail('Expected success, but got failure: ${failure.message}'),
        );
        verify(() => mockEndpointWorkout.deleteExerciseLog(logId)).called(1);
      });

      test('should return ServerFailure when AppException is thrown', () async {
        // Arrange
        const logId = 1;
        final appException = AppException(
          module: 'workout',
          message: 'Failed to delete log',
          errorCode: 500,
          httpStatus: 500,
        );
        when(() => mockEndpointWorkout.deleteExerciseLog(any()))
            .thenThrow(appException);

        // Act
        final result = await repository.deleteExerciseLog(logId);

        // Assert
        result.fold(
          (_) => fail('Expected failure, but got success'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.statusCode, equals(500));
          },
        );
      });
    });

    group('getWorkoutHistory', () {
      test('should return list of WorkoutSession on success', () async {
        // Arrange
        final startDate = DateTime(2024, 6);
        final endDate = DateTime(2024, 6, 15);
        final mockSessions = [
          createMockWorkoutSession(date: startDate),
          createMockWorkoutSession(id: 2, date: endDate),
        ];
        when(
          () => mockEndpointWorkout.getWorkoutHistory(
            any(),
            any(),
          ),
        ).thenAnswer((_) async => mockSessions);

        // Act
        final result = await repository.getWorkoutHistory(
          startDate: startDate,
          endDate: endDate,
        );

        // Assert
        result.fold(
          (sessions) {
            expect(sessions?.length, equals(2));
            expect(sessions?.first.id, equals(1));
            expect(sessions?.last.id, equals(2));
          },
          (failure) =>
              fail('Expected success, but got failure: ${failure.message}'),
        );
        verify(
          () => mockEndpointWorkout.getWorkoutHistory(
            startDate,
            endDate,
          ),
        ).called(1);
      });

      test('should return ServerFailure when AppException is thrown', () async {
        // Arrange
        final startDate = DateTime(2024, 6);
        final endDate = DateTime(2024, 6, 15);
        final appException = AppException(
          module: 'workout',
          message: 'Failed to fetch history',
          errorCode: 500,
          httpStatus: 500,
        );
        when(
          () => mockEndpointWorkout.getWorkoutHistory(
            any(),
            any(),
          ),
        ).thenThrow(appException);

        // Act
        final result = await repository.getWorkoutHistory(
          startDate: startDate,
          endDate: endDate,
        );

        // Assert
        result.fold(
          (sessions) => fail('Expected failure, but got success: $sessions'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.statusCode, equals(500));
          },
        );
      });
    });

    group('getWorkoutProgressMetrics', () {
      test('should return WorkoutProgressMetricsDto on success', () async {
        // Arrange
        final startDate = DateTime(2024, 6);
        final endDate = DateTime(2024, 6, 15);
        final mockMetrics = createMockWorkoutProgressMetrics();
        when(
          () => mockEndpointWorkout.getWorkoutProgressMetrics(
            any(),
            any(),
          ),
        ).thenAnswer((_) async => mockMetrics);

        // Act
        final result = await repository.getWorkoutProgressMetrics(
          startDate: startDate,
          endDate: endDate,
        );

        // Assert
        result.fold(
          (metrics) {
            expect(metrics, equals(mockMetrics));
            expect(metrics?.totalWorkoutsCompleted, equals(10));
            expect(metrics?.currentStreak, equals(5));
          },
          (failure) =>
              fail('Expected success, but got failure: ${failure.message}'),
        );
        verify(
          () => mockEndpointWorkout.getWorkoutProgressMetrics(
            startDate,
            endDate,
          ),
        ).called(1);
      });

      test('should return ServerFailure when AppException is thrown', () async {
        // Arrange
        final startDate = DateTime(2024, 6);
        final endDate = DateTime(2024, 6, 15);
        final appException = AppException(
          module: 'workout',
          message: 'Failed to fetch metrics',
          errorCode: 500,
          httpStatus: 500,
        );
        when(
          () => mockEndpointWorkout.getWorkoutProgressMetrics(
            any(),
            any(),
          ),
        ).thenThrow(appException);

        // Act
        final result = await repository.getWorkoutProgressMetrics(
          startDate: startDate,
          endDate: endDate,
        );

        // Assert
        result.fold(
          (metrics) => fail('Expected failure, but got success: $metrics'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.statusCode, equals(500));
          },
        );
      });
    });

    group('getWorkoutSessionsByDateRange', () {
      test('should return list of WorkoutSessionsByDateDto on success',
          () async {
        // Arrange
        final startDate = DateTime(2024, 6);
        final endDate = DateTime(2024, 6, 15);
        final mockSessionsByDate = [
          createMockWorkoutSessionsByDate(date: startDate),
          createMockWorkoutSessionsByDate(date: endDate),
        ];
        when(
          () => mockEndpointWorkout.getWorkoutSessionsByDateRange(
            any(),
            any(),
          ),
        ).thenAnswer((_) async => mockSessionsByDate);

        // Act
        final result = await repository.getWorkoutSessionsByDateRange(
          startDate: startDate,
          endDate: endDate,
        );

        // Assert
        result.fold(
          (sessionsByDate) {
            expect(sessionsByDate?.length, equals(2));
            expect(sessionsByDate?.first.date, equals(startDate));
            expect(sessionsByDate?.last.date, equals(endDate));
          },
          (failure) =>
              fail('Expected success, but got failure: ${failure.message}'),
        );
        verify(
          () => mockEndpointWorkout.getWorkoutSessionsByDateRange(
            startDate,
            endDate,
          ),
        ).called(1);
      });

      test('should return ServerFailure when AppException is thrown', () async {
        // Arrange
        final startDate = DateTime(2024, 6);
        final endDate = DateTime(2024, 6, 15);
        final appException = AppException(
          module: 'workout',
          message: 'Failed to fetch sessions by date',
          errorCode: 500,
          httpStatus: 500,
        );
        when(
          () => mockEndpointWorkout.getWorkoutSessionsByDateRange(
            any(),
            any(),
          ),
        ).thenThrow(appException);

        // Act
        final result = await repository.getWorkoutSessionsByDateRange(
          startDate: startDate,
          endDate: endDate,
        );

        // Assert
        result.fold(
          (sessionsByDate) =>
              fail('Expected failure, but got success: $sessionsByDate'),
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.statusCode, equals(500));
          },
        );
      });
    });

    group('requestWorkoutPlanGeneration', () {
      test('should return stream of progress updates', () async {
        // Arrange
        const numberOfWeeks = 4;
        final progress1 = GenerateWorkoutPlanProgressDto(
          success: false,
          status: StreamStatus.waiting,
          message: 'Generating plan...',
          progressPercentage: 50.0,
          currentDay: 1,
          totalDays: 14,
          updatedAt: DateTime(2024, 6, 15),
        );
        final progress2 = GenerateWorkoutPlanProgressDto(
          success: true,
          status: StreamStatus.completed,
          message: 'Plan generated',
          progressPercentage: 100.0,
          currentDay: 14,
          totalDays: 14,
          updatedAt: DateTime(2024, 6, 15),
        );
        final streamController =
            StreamController<GenerateWorkoutPlanProgressDto>();
        when(
          () => mockEndpointWorkout.requestWorkoutPlanGeneration(
            any(),
            any(),
          ),
        ).thenAnswer((_) => streamController.stream);

        // Act
        final stream = repository.requestWorkoutPlanGeneration(
          numberOfWeeks: numberOfWeeks,
        );

        // Assert
        final events = <GenerateWorkoutPlanProgressDto>[];
        final subscription = stream.listen(events.add);

        streamController
          ..add(progress1)
          ..add(progress2);
        await streamController.close();
        await subscription.cancel();

        expect(events.length, equals(2));
        expect(events.first.status, equals(StreamStatus.waiting));
        expect(events.last.status, equals(StreamStatus.completed));
        verify(
          () => mockEndpointWorkout.requestWorkoutPlanGeneration(
            1,
            numberOfWeeks,
          ),
        ).called(1);
      });
    });

    group('listenToWorkoutTips', () {
      test('should return stream of tips', () async {
        // Arrange
        final tip1 = 'Tip 1';
        final tip2 = 'Tip 2';
        final streamController = StreamController<String>();
        when(() => mockEndpointWorkout.listenToWorkoutTips())
            .thenAnswer((_) => streamController.stream);

        // Act
        final stream = repository.listenToWorkoutTips();

        // Assert
        final events = <String>[];
        final subscription = stream.listen(events.add);

        streamController
          ..add(tip1)
          ..add(tip2);
        await streamController.close();
        await subscription.cancel();

        expect(events.length, equals(2));
        expect(events.first, equals('Tip 1'));
        expect(events.last, equals('Tip 2'));
        verify(() => mockEndpointWorkout.listenToWorkoutTips()).called(1);
      });
    });
  });
}
