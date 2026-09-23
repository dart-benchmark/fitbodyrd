import 'package:fitbodyrd_server/src/features/workouts/exceptions/workout_exceptions.dart';
import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import 'package:test/test.dart';

// Import the generated file, it contains everything you need.
import '../../../../integration/test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Workout endpoint', (sessionBuilder, endpoints) {
    const userId = 1;
    final authenticatedSessionBuilder = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        userId.toString(),
        {},
      ),
    );

    // Helper function to create a test UserProfile
    Future<UserProfile> createTestUserProfile({
      int? id,
      int? userInfoId,
      bool useSecondSession = false,
    }) async {
      final session = useSecondSession
          ? authenticatedSessionBuilder.copyWith(
              authentication: AuthenticationOverride.authenticationInfo(
                (userInfoId ?? id ?? userId).toString(),
                {},
              ),
            )
          : authenticatedSessionBuilder;
      final userProfile = UserProfile(
        id: id,
        userInfoId: userInfoId ?? userId,
        fullName: 'Test User',
        email: 'test@example.com',
        birthDate: DateTime(1990, 1, 1),
        sex: Sex.male,
        weightKgs: 75.0,
        heightMs: 1.75,
        bodyGoal: BodyGoal.loseWeight,
        activityLevel: ActivityLevel.sedentary,
        daysPerWeekExercise: 3,
        timePerExerciseSessionMinutes: 30,
        experienceLevel: ExerciseDifficulty.beginner,
      );
      final user = await endpoints.user.createUserProfile(session, userProfile);
      return user;
    }

    // Helper function to create a test Exercise
    Future<Exercise> createTestExercise({String? name}) async {
      final session = authenticatedSessionBuilder.build();
      final exercise = Exercise(
        name: name ?? 'Test Exercise',
        category: [ExerciseCategory.strength],
        muscleGroup: [ExerciseMuscleGroup.chest],
        difficulty: ExerciseDifficulty.beginner,
      );
      final inserted = await Exercise.db.insertRow(session, exercise);
      return inserted;
    }

    // Helper function to create a test WorkoutPlan
    Future<WorkoutPlan> createTestWorkoutPlan({
      int? userId,
      String? name,
      DateTime? startDate,
      DateTime? endDate,
      ExerciseDifficulty? difficultyLevel,
      Status? status,
      int? sessionsCount,
    }) async {
      final session = authenticatedSessionBuilder.build();
      final plan = WorkoutPlan(
        userId: userId ?? 1,
        name: name ?? 'Test Workout Plan',
        startDate: startDate ?? DateTime(2024, 1, 1),
        endDate: endDate ?? DateTime(2024, 1, 7),
        difficultyLevel: difficultyLevel ?? ExerciseDifficulty.beginner,
        status: status ?? Status.active,
        sessionsCount: sessionsCount,
      );
      final inserted = await WorkoutPlan.db.insertRow(session, plan);
      return inserted;
    }

    // Helper function to create a test WorkoutSession
    Future<WorkoutSession> createTestWorkoutSession({
      required int workoutPlanId,
      DateTime? date,
      String? dayName,
      String? focus,
    }) async {
      final session = authenticatedSessionBuilder.build();
      final workoutSession = WorkoutSession(
        workoutPlanId: workoutPlanId,
        date: date ?? DateTime(2024, 1, 1),
        dayName: dayName ?? 'Day 1',
        focus: focus ?? 'Chest',
        notes: null,
      );
      final inserted = await WorkoutSession.db.insertRow(
        session,
        workoutSession,
      );
      return inserted;
    }

    // Helper function to create a test WorkoutExercise
    Future<WorkoutExercise> createTestWorkoutExercise({
      required int workoutSessionId,
      required int exerciseId,
      int? order,
      int? sets,
      int? reps,
      int? restSeconds,
    }) async {
      final session = authenticatedSessionBuilder.build();
      final workoutExercise = WorkoutExercise(
        workoutSessionId: workoutSessionId,
        exerciseId: exerciseId,
        order: order ?? 1,
        sets: sets ?? 3,
        reps: reps ?? 10,
        restSeconds: restSeconds ?? 60,
      );
      final inserted = await WorkoutExercise.db.insertRow(
        session,
        workoutExercise,
      );
      return inserted;
    }

    // Helper function to create a test ExerciseLog
    Future<ExerciseLog> createTestExerciseLog({
      required int userId,
      required int exerciseId,
      DateTime? date,
      int? setsCompleted,
      int? repsCompleted,
      double? weightUsed,
      int? workoutExerciseId,
    }) async {
      final session = authenticatedSessionBuilder.build();
      final log = ExerciseLog(
        userId: userId,
        exerciseId: exerciseId,
        date: date ?? DateTime(2024, 1, 1),
        setsCompleted: setsCompleted ?? 3,
        repsCompleted: repsCompleted ?? 10,
        weightUsed: weightUsed,
        workoutExerciseId: workoutExerciseId,
      );
      final inserted = await ExerciseLog.db.insertRow(session, log);
      return inserted;
    }

    setUp(() async {
      final session = authenticatedSessionBuilder.build();
      // Create UserInfo for foreign key constraint
      await UserInfo.db.insertRow(
        session,
        UserInfo(
          id: userId,
          userIdentifier: 'test_user_$userId',
          created: DateTime(2024, 1, 1),
          scopeNames: ['user'],
          blocked: false,
        ),
      );
    });

    group('getActiveWorkoutPlan', () {
      test(
        'should return active workout plan with sessions and exercises',
        () async {
          // Arrange
          final userProfile = await createTestUserProfile();
          final exercise = await createTestExercise();
          final workoutPlan = await createTestWorkoutPlan(
            userId: userProfile.id!,
            status: Status.active,
          );
          final workoutSession = await createTestWorkoutSession(
            workoutPlanId: workoutPlan.id!,
          );
          await createTestWorkoutExercise(
            workoutSessionId: workoutSession.id!,
            exerciseId: exercise.id!,
          );

          // Act
          final result = await endpoints.workout.getActiveWorkoutPlan(
            authenticatedSessionBuilder,
            userProfile.id!,
          );

          // Assert
          expect(result, isNotNull);
          expect(result.id, equals(workoutPlan.id));
          expect(result.status, equals(Status.active));
          expect(result.sessions, isNotNull);
          expect(result.sessions!.isNotEmpty, isTrue);
          expect(result.sessions!.first.exercises, isNotNull);
          expect(result.sessions!.first.exercises!.isNotEmpty, isTrue);
        },
      );

      test(
        'should throw WorkoutExceptions.noActiveWorkoutPlan when no active plan exists',
        () async {
          // Arrange
          final userProfile = await createTestUserProfile();

          // Act & Assert
          await expectLater(
            endpoints.workout.getActiveWorkoutPlan(
              authenticatedSessionBuilder,
              userProfile.id!,
            ),
            throwsA(
              predicate<AppException>(
                (e) =>
                    e.errorCode ==
                    WorkoutExceptions.noActiveWorkoutPlan().errorCode,
              ),
            ),
          );
        },
      );

      test('should include sessions and exercises', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final exercise = await createTestExercise();
        final workoutPlan = await createTestWorkoutPlan(
          userId: userProfile.id!,
          status: Status.active,
        );
        final workoutSession = await createTestWorkoutSession(
          workoutPlanId: workoutPlan.id!,
        );
        await createTestWorkoutExercise(
          workoutSessionId: workoutSession.id!,
          exerciseId: exercise.id!,
        );

        // Act
        final result = await endpoints.workout.getActiveWorkoutPlan(
          authenticatedSessionBuilder,
          userProfile.id!,
        );

        // Assert
        expect(result.sessions, isNotNull);
        expect(result.sessions!.first.exercises, isNotNull);
        expect(result.sessions!.first.exercises!.first.exercise, isNotNull);
      });

      test('should order sessions by date and exercises by order', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final exercise1 = await createTestExercise(name: 'Exercise 1');
        final exercise2 = await createTestExercise(name: 'Exercise 2');
        final workoutPlan = await createTestWorkoutPlan(
          userId: userProfile.id!,
          status: Status.active,
        );
        await createTestWorkoutSession(
          workoutPlanId: workoutPlan.id!,
          date: DateTime(2024, 1, 2),
        );
        final session2 = await createTestWorkoutSession(
          workoutPlanId: workoutPlan.id!,
          date: DateTime(2024, 1, 1),
        );
        await createTestWorkoutExercise(
          workoutSessionId: session2.id!,
          exerciseId: exercise1.id!,
          order: 2,
        );
        await createTestWorkoutExercise(
          workoutSessionId: session2.id!,
          exerciseId: exercise2.id!,
          order: 1,
        );

        // Act
        final result = await endpoints.workout.getActiveWorkoutPlan(
          authenticatedSessionBuilder,
          userProfile.id!,
        );

        // Assert
        expect(result.sessions!.length, greaterThanOrEqualTo(2));
        // Sessions should be ordered by date
        final dates = result.sessions!.map((s) => s.date).toList();
        expect(
          dates[0].isBefore(dates[1]) || dates[0].isAtSameMomentAs(dates[1]),
          isTrue,
        );
        // Exercises should be ordered by order
        final exercises = result.sessions!.first.exercises!;
        expect(exercises[0].order, lessThanOrEqualTo(exercises[1].order));
      });
    });

    group('getExerciseLogs', () {
      test('should return logs within date range', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final exercise = await createTestExercise();
        await createTestExerciseLog(
          userId: userProfile.id!,
          exerciseId: exercise.id!,
          date: DateTime(2024, 1, 5),
        );
        await createTestExerciseLog(
          userId: userProfile.id!,
          exerciseId: exercise.id!,
          date: DateTime(2024, 1, 10), // Outside range
        );

        // Act
        final result = await endpoints.workout.getExerciseLogs(
          authenticatedSessionBuilder,
          DateTime(2024, 1, 1),
          DateTime(2024, 1, 7),
          [exercise.id!],
        );

        // Assert
        expect(result, isNotEmpty);
        expect(result.length, equals(1));
        expect(
          result.first.date.isAfter(
            DateTime(2024, 1, 1).subtract(const Duration(days: 1)),
          ),
          isTrue,
        );
        expect(
          result.first.date.isBefore(
            DateTime(2024, 1, 7).add(const Duration(days: 1)),
          ),
          isTrue,
        );
      });

      test('should filter by exercise IDs', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final exercise1 = await createTestExercise(name: 'Exercise 1');
        final exercise2 = await createTestExercise(name: 'Exercise 2');
        await createTestExerciseLog(
          userId: userProfile.id!,
          exerciseId: exercise1.id!,
        );
        await createTestExerciseLog(
          userId: userProfile.id!,
          exerciseId: exercise2.id!,
        );

        // Act
        final result = await endpoints.workout.getExerciseLogs(
          authenticatedSessionBuilder,
          DateTime(2024, 1, 1),
          DateTime(2024, 1, 7),
          [exercise1.id!],
        );

        // Assert
        expect(result, isNotEmpty);
        expect(result.every((log) => log.exerciseId == exercise1.id), isTrue);
      });

      test('should order by date', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final exercise = await createTestExercise();
        await createTestExerciseLog(
          userId: userProfile.id!,
          exerciseId: exercise.id!,
          date: DateTime(2024, 1, 3),
        );
        await createTestExerciseLog(
          userId: userProfile.id!,
          exerciseId: exercise.id!,
          date: DateTime(2024, 1, 1),
        );
        await createTestExerciseLog(
          userId: userProfile.id!,
          exerciseId: exercise.id!,
          date: DateTime(2024, 1, 2),
        );

        // Act
        final result = await endpoints.workout.getExerciseLogs(
          authenticatedSessionBuilder,
          DateTime(2024, 1, 1),
          DateTime(2024, 1, 7),
          [exercise.id!],
        );

        // Assert
        expect(result.length, equals(3));
        expect(
          result[0].date.isBefore(result[1].date) ||
              result[0].date.isAtSameMomentAs(result[1].date),
          isTrue,
        );
        expect(
          result[1].date.isBefore(result[2].date) ||
              result[1].date.isAtSameMomentAs(result[2].date),
          isTrue,
        );
      });

      test('should use authenticated user ID', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final exercise = await createTestExercise();
        await createTestExerciseLog(
          userId: userProfile.id!,
          exerciseId: exercise.id!,
        );

        // Act
        final result = await endpoints.workout.getExerciseLogs(
          authenticatedSessionBuilder,
          DateTime(2024, 1, 1),
          DateTime(2024, 1, 7),
          [exercise.id!],
        );

        // Assert
        expect(result, isNotEmpty);
        expect(result.every((log) => log.userId == userProfile.id), isTrue);
      });

      test('should return empty list when no logs match', () async {
        // Arrange
        await createTestUserProfile();
        final exercise = await createTestExercise();

        // Act
        final result = await endpoints.workout.getExerciseLogs(
          authenticatedSessionBuilder,
          DateTime(2024, 1, 1),
          DateTime(2024, 1, 7),
          [exercise.id!],
        );

        // Assert
        expect(result, isEmpty);
      });
    });

    group('deleteExerciseLog', () {
      test('should delete log and update session completion', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final exercise = await createTestExercise();
        final workoutPlan = await createTestWorkoutPlan(
          userId: userProfile.id!,
          status: Status.active,
        );
        final workoutSession = await createTestWorkoutSession(
          workoutPlanId: workoutPlan.id!,
        );
        final workoutExercise = await createTestWorkoutExercise(
          workoutSessionId: workoutSession.id!,
          exerciseId: exercise.id!,
        );
        final log = await createTestExerciseLog(
          userId: userProfile.id!,
          exerciseId: exercise.id!,
          workoutExerciseId: workoutExercise.id!,
        );

        // Act
        await endpoints.workout.deleteExerciseLog(
          authenticatedSessionBuilder,
          log.id!,
        );

        // Assert
        final session = authenticatedSessionBuilder.build();
        final deletedLog = await ExerciseLog.db.findById(session, log.id!);
        expect(deletedLog, isNull);
      });

      test(
        'should throw WorkoutExceptions.exerciseLogNotFound when log does not exist',
        () async {
          // Arrange
          await createTestUserProfile();

          // Act & Assert
          await expectLater(
            endpoints.workout.deleteExerciseLog(
              authenticatedSessionBuilder,
              99999,
            ),
            throwsA(
              predicate<AppException>(
                (e) =>
                    e.errorCode ==
                    WorkoutExceptions.exerciseLogNotFound().errorCode,
              ),
            ),
          );
        },
      );

      test(
        'should throw WorkoutExceptions.exerciseLogNotFound for different user',
        () async {
          // Arrange
          await createTestUserProfile();
          await UserInfo.db.insertRow(
            authenticatedSessionBuilder.build(),
            UserInfo(
              id: 2,
              userIdentifier: 'test_user_2',
              created: DateTime(2024, 1, 1),
              scopeNames: ['user'],
              blocked: false,
            ),
          );
          final userProfile2 = await createTestUserProfile(
            userInfoId: 2,
            id: 2,
            useSecondSession: true,
          );
          final exercise = await createTestExercise();
          final log = await createTestExerciseLog(
            userId: userProfile2.id!,
            exerciseId: exercise.id!,
          );

          // Act & Assert
          await expectLater(
            endpoints.workout.deleteExerciseLog(
              authenticatedSessionBuilder,
              log.id!,
            ),
            throwsA(
              predicate<AppException>(
                (e) =>
                    e.errorCode ==
                    WorkoutExceptions.exerciseLogNotFound().errorCode,
              ),
            ),
          );
        },
      );
    });

    group('createBaseWorkoutPlan', () {
      test('should create workout plan with all fields', () async {
        // Arrange
        final userProfile = await createTestUserProfile();

        // Act
        final result = await endpoints.workout.createBaseWorkoutPlan(
          authenticatedSessionBuilder,
          userProfile.id!,
          'Test Plan',
          DateTime(2024, 1, 1, 0, 0, 0),
          DateTime(2024, 1, 7, 0, 0, 0),
          ExerciseDifficulty.beginner,
          5,
        );

        // Assert
        expect(result, isNotNull);
        expect(result.id, isNotNull);
        expect(result.name, equals('Test Plan'));
        expect(result.userId, equals(userProfile.id));
        expect(
          result.startDate.toLocal(),
          equals(DateTime(2024, 1, 1, 0, 0, 0)),
        );
        expect(result.endDate.toLocal(), equals(DateTime(2024, 1, 7, 0, 0, 0)));
        expect(result.difficultyLevel, equals(ExerciseDifficulty.beginner));
        expect(result.sessionsCount, equals(5));
      });

      test(
        'should throw WorkoutExceptions.activeWorkoutPlanExists when active plan exists',
        () async {
          // Arrange
          final userProfile = await createTestUserProfile();
          await createTestWorkoutPlan(
            userId: userProfile.id!,
            status: Status.active,
          );

          // Act & Assert
          await expectLater(
            endpoints.workout.createBaseWorkoutPlan(
              authenticatedSessionBuilder,
              userProfile.id!,
              'Test Plan',
              DateTime(2024, 1, 1),
              DateTime(2024, 1, 7),
              ExerciseDifficulty.beginner,
              5,
            ),
            throwsA(
              predicate<AppException>(
                (e) =>
                    e.errorCode ==
                    WorkoutExceptions.activeWorkoutPlanExists().errorCode,
              ),
            ),
          );
        },
      );

      test('should create plan with Status.active', () async {
        // Arrange
        final userProfile = await createTestUserProfile();

        // Act
        final result = await endpoints.workout.createBaseWorkoutPlan(
          authenticatedSessionBuilder,
          userProfile.id!,
          'Test Plan',
          DateTime(2024, 1, 1),
          DateTime(2024, 1, 7),
          ExerciseDifficulty.beginner,
          5,
        );

        // Assert
        expect(result.status, equals(Status.active));
      });
    });

    group('createWorkoutSession', () {
      test('should create session with exercises in transaction', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final exercise = await createTestExercise();
        final workoutPlan = await createTestWorkoutPlan(
          userId: userProfile.id!,
          sessionsCount: 5,
        );
        final sessionDto = CreateWorkoutSessionDto(
          date: DateTime(2024, 1, 1),
          dayName: 'Day 1',
          focus: 'Chest',
          exercises: [
            CreateWorkoutExerciseDto(
              exerciseId: exercise.id!,
              order: 1,
              sets: 3,
              reps: 10,
              restSeconds: 60,
            ),
          ],
        );

        // Act
        await endpoints.workout.createWorkoutSession(
          authenticatedSessionBuilder,
          workoutPlan.id!,
          sessionDto,
        );

        // Assert
        final session = authenticatedSessionBuilder.build();
        final createdSessions = await WorkoutSession.db.find(
          session,
          where: (t) => t.workoutPlanId.equals(workoutPlan.id!),
        );
        expect(createdSessions, isNotEmpty);
        expect(createdSessions.first.focus, equals('Chest'));

        final exercises = await WorkoutExercise.db.find(
          session,
          where: (t) => t.workoutSessionId.equals(createdSessions.first.id!),
        );
        expect(exercises, isNotEmpty);
      });

      test(
        'should throw WorkoutExceptions.noActiveWorkoutPlan when workout plan not found',
        () async {
          // Arrange
          final sessionDto = CreateWorkoutSessionDto(
            date: DateTime(2024, 1, 1),
            dayName: 'Day 1',
            focus: 'Chest',
            exercises: [],
          );

          // Act & Assert
          await expectLater(
            endpoints.workout.createWorkoutSession(
              authenticatedSessionBuilder,
              99999,
              sessionDto,
            ),
            throwsA(
              predicate<AppException>(
                (e) =>
                    e.errorCode ==
                    WorkoutExceptions.noActiveWorkoutPlan().errorCode,
              ),
            ),
          );
        },
      );
    });

    group('createWorkoutPlan', () {
      test(
        'should create complete workout plan with sessions and exercises',
        () async {
          // Arrange
          final userProfile = await createTestUserProfile();
          final exercise = await createTestExercise();
          final workoutPlanDto = CreateWorkoutPlanDto(
            userId: userProfile.id!,
            name: 'Complete Plan',
            startDate: DateTime(2024, 1, 1),
            endDate: DateTime(2024, 1, 7),
            difficultyLevel: ExerciseDifficulty.beginner,
            sessions: [
              CreateWorkoutSessionDto(
                date: DateTime(2024, 1, 1),
                dayName: 'Day 1',
                focus: 'Chest',
                exercises: [
                  CreateWorkoutExerciseDto(
                    exerciseId: exercise.id!,
                    order: 1,
                    sets: 3,
                    reps: 10,
                    restSeconds: 60,
                  ),
                ],
              ),
            ],
          );

          // Act
          await endpoints.workout.createWorkoutPlan(
            authenticatedSessionBuilder,
            workoutPlanDto,
          );

          // Assert
          final session = authenticatedSessionBuilder.build();
          final createdPlans = await WorkoutPlan.db.find(
            session,
            where: (t) => t.userId.equals(userProfile.id!),
          );
          expect(createdPlans, isNotEmpty);
          expect(createdPlans.first.name, equals('Complete Plan'));

          final sessions = await WorkoutSession.db.find(
            session,
            where: (t) => t.workoutPlanId.equals(createdPlans.first.id!),
          );
          expect(sessions, isNotEmpty);
        },
      );

      test(
        'should throw WorkoutExceptions.activeWorkoutPlanExists when active plan exists',
        () async {
          // Arrange
          final userProfile = await createTestUserProfile();
          await createTestWorkoutPlan(
            userId: userProfile.id!,
            status: Status.active,
          );
          final workoutPlanDto = CreateWorkoutPlanDto(
            userId: userProfile.id!,
            name: 'New Plan',
            startDate: DateTime(2024, 1, 1),
            endDate: DateTime(2024, 1, 7),
            difficultyLevel: ExerciseDifficulty.beginner,
            sessions: [],
          );

          // Act & Assert
          await expectLater(
            endpoints.workout.createWorkoutPlan(
              authenticatedSessionBuilder,
              workoutPlanDto,
            ),
            throwsA(
              predicate<AppException>(
                (e) =>
                    e.errorCode ==
                    WorkoutExceptions.activeWorkoutPlanExists().errorCode,
              ),
            ),
          );
        },
      );

      test(
        'should throw WorkoutExceptions.errorCreatingWorkoutPlan when sessions is null',
        () async {
          // Arrange
          final userProfile = await createTestUserProfile();
          final workoutPlanDto = CreateWorkoutPlanDto(
            userId: userProfile.id!,
            name: 'New Plan',
            startDate: DateTime(2024, 1, 1),
            endDate: DateTime(2024, 1, 7),
            difficultyLevel: ExerciseDifficulty.beginner,
            sessions: null,
          );

          // Act & Assert
          await expectLater(
            endpoints.workout.createWorkoutPlan(
              authenticatedSessionBuilder,
              workoutPlanDto,
            ),
            throwsA(
              predicate<AppException>(
                (e) =>
                    e.errorCode ==
                    WorkoutExceptions.errorCreatingWorkoutPlan().errorCode,
              ),
            ),
          );
        },
      );
    });

    group('notifyErrorCreatingWorkoutPlan', () {
      test('should post error message to channel', () async {
        // Arrange
        final userProfile = await createTestUserProfile();

        // Act
        await endpoints.workout.notifyErrorCreatingWorkoutPlan(
          authenticatedSessionBuilder,
          userProfile.id!,
        );

        // Assert - Message posted to channel (no exception thrown)
        // If we get here without exception, the message was posted
        expect(userProfile.id, isNotNull);
      });
    });

    group('listenToWorkoutTips', () {
      test('should stream tips in order', () async {
        // Arrange
        final session = authenticatedSessionBuilder.build();
        final tip1 = WorkoutTip(content: 'Tip 1', order: 1);
        final tip2 = WorkoutTip(content: 'Tip 2', order: 2);
        await WorkoutTip.db.insertRow(session, tip1);
        await WorkoutTip.db.insertRow(session, tip2);

        // Act
        final stream = endpoints.workout.listenToWorkoutTips(
          authenticatedSessionBuilder,
        );
        final tips = <String>[];
        await for (final tip in stream.take(2)) {
          tips.add(tip);
        }

        // Assert
        expect(tips, isNotEmpty);
        expect(tips.length, equals(2));
      });

      test('should return default message when no tips exist', () async {
        // Act
        final stream = endpoints.workout.listenToWorkoutTips(
          authenticatedSessionBuilder,
        );
        final firstTip = await stream.first;

        // Assert
        expect(firstTip, equals('Preparando tu plan de entrenamiento...'));
      });
    });

    group('logWorkoutExercise', () {
      test('should create new log', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final exercise = await createTestExercise();
        final log = ExerciseLog(
          userId: userProfile.id!,
          exerciseId: exercise.id!,
          date: DateTime(2024, 1, 1),
          setsCompleted: 3,
          repsCompleted: 10,
          weightUsed: 50.0,
        );

        // Act
        final result = await endpoints.workout.logWorkoutExercise(
          authenticatedSessionBuilder,
          log,
        );

        // Assert
        expect(result, isNotNull);
        expect(result.id, isNotNull);
        expect(result.userId, equals(userProfile.id));
        expect(result.setsCompleted, equals(3));
        expect(result.repsCompleted, equals(10));
        expect(result.weightUsed, equals(50.0));
      });

      test('should update existing log for same day', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final exercise = await createTestExercise();
        final workoutPlan = await createTestWorkoutPlan(
          userId: userProfile.id!,
          status: Status.active,
        );
        final workoutSession = await createTestWorkoutSession(
          workoutPlanId: workoutPlan.id!,
        );
        final workoutExercise = await createTestWorkoutExercise(
          workoutSessionId: workoutSession.id!,
          exerciseId: exercise.id!,
        );
        final existingLog = await createTestExerciseLog(
          userId: userProfile.id!,
          exerciseId: exercise.id!,
          workoutExerciseId: workoutExercise.id!,
          date: DateTime(2024, 1, 1, 10, 0),
          setsCompleted: 2,
        );

        final updatedLog = ExerciseLog(
          id: existingLog.id,
          userId: userProfile.id!,
          exerciseId: exercise.id!,
          date: DateTime(2024, 1, 1, 15, 0), // Same day, different time
          setsCompleted: 3,
          repsCompleted: 12,
          workoutExerciseId: workoutExercise.id!,
        );

        // Act
        final result = await endpoints.workout.logWorkoutExercise(
          authenticatedSessionBuilder,
          updatedLog,
        );

        // Assert
        expect(result.id, equals(existingLog.id));
        expect(result.setsCompleted, equals(3));
        expect(result.repsCompleted, equals(12));
      });

      test('should match logs by day not time', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final exercise = await createTestExercise();
        final workoutPlan = await createTestWorkoutPlan(
          userId: userProfile.id!,
          status: Status.active,
        );
        final workoutSession = await createTestWorkoutSession(
          workoutPlanId: workoutPlan.id!,
        );
        final workoutExercise = await createTestWorkoutExercise(
          workoutSessionId: workoutSession.id!,
          exerciseId: exercise.id!,
        );
        await createTestExerciseLog(
          userId: userProfile.id!,
          exerciseId: exercise.id!,
          workoutExerciseId: workoutExercise.id!,
          date: DateTime(2024, 1, 1, 10, 0),
        );

        final newLog = ExerciseLog(
          userId: userProfile.id!,
          exerciseId: exercise.id!,
          date: DateTime(2024, 1, 1, 15, 30), // Same day, different time
          setsCompleted: 3,
          repsCompleted: 10,
          workoutExerciseId: workoutExercise.id!,
        );

        // Act
        await endpoints.workout.logWorkoutExercise(
          authenticatedSessionBuilder,
          newLog,
        );

        // Assert - Should update existing log, not create new one
        final session = authenticatedSessionBuilder.build();
        final allLogs = await ExerciseLog.db.find(
          session,
          where: (t) => t.exerciseId.equals(exercise.id!),
        );
        expect(allLogs.length, equals(1));
      });

      test('should use authenticated user ID', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final exercise = await createTestExercise();
        final log = ExerciseLog(
          userId: userProfile.id!,
          exerciseId: exercise.id!,
          date: DateTime(2024, 1, 1),
          setsCompleted: 3,
          repsCompleted: 10,
        );

        // Act
        final result = await endpoints.workout.logWorkoutExercise(
          authenticatedSessionBuilder,
          log,
        );

        // Assert
        expect(result.userId, equals(userProfile.id));
      });
    });

    group('getWorkoutHistory', () {
      test('should return all sessions for user', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final workoutPlan = await createTestWorkoutPlan(
          userId: userProfile.id!,
          status: Status.completed,
        );
        await createTestWorkoutSession(workoutPlanId: workoutPlan.id!);

        // Act
        final result = await endpoints.workout.getWorkoutHistory(
          authenticatedSessionBuilder,
          null,
          null,
        );

        // Assert
        expect(result, isNotEmpty);
      });

      test('should filter by startDate', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final workoutPlan = await createTestWorkoutPlan(
          userId: userProfile.id!,
          status: Status.completed,
        );
        await createTestWorkoutSession(
          workoutPlanId: workoutPlan.id!,
          date: DateTime(2024, 1, 5),
        );
        await createTestWorkoutSession(
          workoutPlanId: workoutPlan.id!,
          date: DateTime(2024, 1, 1), // Before startDate
        );

        // Act
        final result = await endpoints.workout.getWorkoutHistory(
          authenticatedSessionBuilder,
          DateTime(2024, 1, 3),
          null,
        );

        // Assert
        expect(result, isNotEmpty);
        expect(
          result.every((s) => s.date.isAfter(DateTime(2024, 1, 2))),
          isTrue,
        );
      });

      test('should filter by endDate', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final workoutPlan = await createTestWorkoutPlan(
          userId: userProfile.id!,
          status: Status.completed,
        );
        await createTestWorkoutSession(
          workoutPlanId: workoutPlan.id!,
          date: DateTime(2024, 1, 5),
        );
        await createTestWorkoutSession(
          workoutPlanId: workoutPlan.id!,
          date: DateTime(2024, 1, 10), // After endDate
        );

        // Act
        final result = await endpoints.workout.getWorkoutHistory(
          authenticatedSessionBuilder,
          null,
          DateTime(2024, 1, 7),
        );

        // Assert
        expect(result, isNotEmpty);
        expect(
          result.every((s) => s.date.isBefore(DateTime(2024, 1, 8))),
          isTrue,
        );
      });

      test('should filter by both dates', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final workoutPlan = await createTestWorkoutPlan(
          userId: userProfile.id!,
          status: Status.completed,
        );
        await createTestWorkoutSession(
          workoutPlanId: workoutPlan.id!,
          date: DateTime(2024, 1, 5),
        );
        await createTestWorkoutSession(
          workoutPlanId: workoutPlan.id!,
          date: DateTime(2024, 1, 1), // Before range
        );
        await createTestWorkoutSession(
          workoutPlanId: workoutPlan.id!,
          date: DateTime(2024, 1, 10), // After range
        );

        // Act
        final result = await endpoints.workout.getWorkoutHistory(
          authenticatedSessionBuilder,
          DateTime(2024, 1, 3),
          DateTime(2024, 1, 7),
        );

        // Assert
        expect(result, isNotEmpty);
        expect(
          result.every((s) {
            final date = DateTime(s.date.year, s.date.month, s.date.day);
            return date.isAfter(DateTime(2024, 1, 2)) &&
                date.isBefore(DateTime(2024, 1, 8));
          }),
          isTrue,
        );
      });

      test('should return empty list when no user profile', () async {
        // Act
        final result = await endpoints.workout.getWorkoutHistory(
          authenticatedSessionBuilder,
          null,
          null,
        );

        // Assert
        expect(result, isEmpty);
      });

      test('should include exercises and workout plan', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final workoutPlan = await createTestWorkoutPlan(
          userId: userProfile.id!,
          status: Status.completed,
        );
        final workoutSession = await createTestWorkoutSession(
          workoutPlanId: workoutPlan.id!,
        );
        final exercise = await createTestExercise();
        await createTestWorkoutExercise(
          workoutSessionId: workoutSession.id!,
          exerciseId: exercise.id!,
        );

        // Act
        final result = await endpoints.workout.getWorkoutHistory(
          authenticatedSessionBuilder,
          null,
          null,
        );

        // Assert
        expect(result, isNotEmpty);
        expect(result.first.exercises, isNotNull);
        expect(result.first.exercises!.isNotEmpty, isTrue);
        expect(result.first.workoutPlan, isNotNull);
      });

      test('should order by date descending', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final workoutPlan = await createTestWorkoutPlan(
          userId: userProfile.id!,
          status: Status.completed,
        );
        await createTestWorkoutSession(
          workoutPlanId: workoutPlan.id!,
          date: DateTime(2024, 1, 1),
        );
        await createTestWorkoutSession(
          workoutPlanId: workoutPlan.id!,
          date: DateTime(2024, 1, 5),
        );

        // Act
        final result = await endpoints.workout.getWorkoutHistory(
          authenticatedSessionBuilder,
          null,
          null,
        );

        // Assert
        expect(result.length, greaterThanOrEqualTo(2));
        expect(
          result[0].date.isAfter(result[1].date) ||
              result[0].date.isAtSameMomentAs(result[1].date),
          isTrue,
        );
      });
    });

    group('getWorkoutProgressMetrics', () {
      test('should calculate all metrics correctly', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final exercise = await createTestExercise();
        await createTestExerciseLog(
          userId: userProfile.id!,
          exerciseId: exercise.id!,
          date: DateTime(2024, 1, 1),
        );
        await createTestExerciseLog(
          userId: userProfile.id!,
          exerciseId: exercise.id!,
          date: DateTime(2024, 1, 2),
        );

        // Act
        final result = await endpoints.workout.getWorkoutProgressMetrics(
          authenticatedSessionBuilder,
          null,
          null,
        );

        // Assert
        expect(result, isNotNull);
        expect(result.totalWorkoutsCompleted, greaterThanOrEqualTo(2));
        expect(result.totalExercisesLogged, greaterThanOrEqualTo(2));
      });

      test('should count distinct workout dates', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final exercise = await createTestExercise();
        await createTestExerciseLog(
          userId: userProfile.id!,
          exerciseId: exercise.id!,
          date: DateTime(2024, 1, 1),
        );
        await createTestExerciseLog(
          userId: userProfile.id!,
          exerciseId: exercise.id!,
          date: DateTime(2024, 1, 1), // Same day
        );
        await createTestExerciseLog(
          userId: userProfile.id!,
          exerciseId: exercise.id!,
          date: DateTime(2024, 1, 2), // Different day
        );

        // Act
        final result = await endpoints.workout.getWorkoutProgressMetrics(
          authenticatedSessionBuilder,
          null,
          null,
        );

        // Assert
        expect(result.totalWorkoutsCompleted, equals(2)); // Two distinct dates
        expect(result.totalExercisesLogged, equals(3)); // Three logs
      });

      test('should return empty metrics when no user profile', () async {
        // Act
        final result = await endpoints.workout.getWorkoutProgressMetrics(
          authenticatedSessionBuilder,
          null,
          null,
        );

        // Assert
        expect(result.totalWorkoutsCompleted, equals(0));
        expect(result.currentStreak, equals(0));
        expect(result.longestStreak, equals(0));
        expect(result.averageWorkoutsPerWeek, equals(0.0));
        expect(result.totalExercisesLogged, equals(0));
      });

      test('should return zeros for all metrics when empty data', () async {
        // Arrange
        await createTestUserProfile();

        // Act
        final result = await endpoints.workout.getWorkoutProgressMetrics(
          authenticatedSessionBuilder,
          null,
          null,
        );

        // Assert
        expect(result.totalWorkoutsCompleted, equals(0));
        expect(result.currentStreak, equals(0));
        expect(result.longestStreak, equals(0));
        expect(result.averageWorkoutsPerWeek, equals(0.0));
        expect(result.totalExercisesLogged, equals(0));
        expect(result.workoutsThisWeek, equals(0));
        expect(result.workoutsThisMonth, equals(0));
      });
    });

    group('getWorkoutSessionsByDateRange', () {
      test('should group sessions by date', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final workoutPlan = await createTestWorkoutPlan(
          userId: userProfile.id!,
          status: Status.completed,
        );
        await createTestWorkoutSession(
          workoutPlanId: workoutPlan.id!,
          date: DateTime(2024, 1, 1),
        );
        await createTestWorkoutSession(
          workoutPlanId: workoutPlan.id!,
          date: DateTime(2024, 1, 2),
        );

        // Act
        final result = await endpoints.workout.getWorkoutSessionsByDateRange(
          authenticatedSessionBuilder,
          DateTime(2024, 1, 1),
          DateTime(2024, 1, 7),
        );

        // Assert
        expect(result, isNotEmpty);
        expect(result.length, greaterThanOrEqualTo(2));
      });

      test('should count completed exercises per date', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final workoutPlan = await createTestWorkoutPlan(
          userId: userProfile.id!,
          status: Status.completed,
        );
        final workoutSession = await createTestWorkoutSession(
          workoutPlanId: workoutPlan.id!,
          date: DateTime(2024, 1, 1),
        );
        final exercise = await createTestExercise();
        final workoutExercise = await createTestWorkoutExercise(
          workoutSessionId: workoutSession.id!,
          exerciseId: exercise.id!,
        );
        await createTestExerciseLog(
          userId: userProfile.id!,
          exerciseId: exercise.id!,
          workoutExerciseId: workoutExercise.id!,
          date: DateTime(2024, 1, 1),
        );

        // Act
        final result = await endpoints.workout.getWorkoutSessionsByDateRange(
          authenticatedSessionBuilder,
          DateTime(2024, 1, 1),
          DateTime(2024, 1, 7),
        );

        // Assert
        expect(result, isNotEmpty);
        final sessionForDate = result.firstWhere(
          (s) => s.date.year == 2024 && s.date.month == 1 && s.date.day == 1,
        );
        expect(sessionForDate.totalExercisesCompleted, greaterThanOrEqualTo(1));
      });

      test('should order dates descending', () async {
        // Arrange
        final userProfile = await createTestUserProfile();
        final workoutPlan = await createTestWorkoutPlan(
          userId: userProfile.id!,
          status: Status.completed,
        );
        await createTestWorkoutSession(
          workoutPlanId: workoutPlan.id!,
          date: DateTime(2024, 1, 1),
        );
        await createTestWorkoutSession(
          workoutPlanId: workoutPlan.id!,
          date: DateTime(2024, 1, 5),
        );

        // Act
        final result = await endpoints.workout.getWorkoutSessionsByDateRange(
          authenticatedSessionBuilder,
          DateTime(2024, 1, 1),
          DateTime(2024, 1, 7),
        );

        // Assert
        expect(result.length, greaterThanOrEqualTo(2));
        expect(
          result[0].date.isAfter(result[1].date) ||
              result[0].date.isAtSameMomentAs(result[1].date),
          isTrue,
        );
      });

      test('should return empty list when no user profile', () async {
        // Act
        final result = await endpoints.workout.getWorkoutSessionsByDateRange(
          authenticatedSessionBuilder,
          DateTime(2024, 1, 1),
          DateTime(2024, 1, 7),
        );

        // Assert
        expect(result, isEmpty);
      });
    });
  });
}
