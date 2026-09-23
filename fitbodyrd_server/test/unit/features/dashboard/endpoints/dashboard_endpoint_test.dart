import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import 'package:test/test.dart';

// Import the generated file, it contains everything you need.
import '../../../../integration/test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Dashboard endpoint', (sessionBuilder, endpoints) {
    const userId = 1;
    final authenticatedSessionBuilder = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        userId.toString(),
        {},
      ),
    );

    final unauthenticatedSessionBuilder = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.unauthenticated(),
    );

    // Helper function to create a test UserProfile
    UserProfile createTestUserProfile({
      int? id,
      int? userInfoId,
      String fullName = 'Test User',
      String email = 'test@example.com',
    }) {
      return UserProfile(
        id: id,
        userInfoId: userInfoId ?? userId,
        fullName: fullName,
        email: email,
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
    }

    // Helper to get Monday of a given week
    DateTime getMondayOfWeek(DateTime date) {
      final dayOfWeek = date.weekday;
      final daysToSubtract = dayOfWeek - 1;
      return DateTime(
        date.year,
        date.month,
        date.day,
      ).subtract(Duration(days: daysToSubtract));
    }

    group('getWeeklySummary', () {
      test('should return weekly summary with data', () async {
        // Arrange
        final session = authenticatedSessionBuilder.build();
        // Create UserInfo and UserProfile
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
        final userProfile = createTestUserProfile();
        await UserProfile.db.insertRow(session, userProfile);
        // Fetch the inserted profile to get the generated ID
        final insertedProfile = await UserProfile.db.findFirstRow(
          session,
          where: (t) => t.userInfoId.equals(userId),
        );
        final userProfileId = insertedProfile!.id!;

        // Create workout plan and sessions for current week
        // Note: The endpoint uses DateTime.now() internally, so we need to use current date
        final now = DateTime.now();
        final weekStart = getMondayOfWeek(now);
        final weekEnd = weekStart.add(const Duration(days: 6));

        final workoutPlan = WorkoutPlan(
          userId: userProfileId,
          name: 'Test Plan',
          startDate: weekStart,
          endDate: weekEnd,
          difficultyLevel: ExerciseDifficulty.beginner,
          sessionsCount: 3,
        );
        await WorkoutPlan.db.insertRow(session, workoutPlan);
        // Fetch the inserted plan to get the generated ID
        final insertedPlan = await WorkoutPlan.db.findFirstRow(
          session,
          where: (t) => t.userId.equals(userProfileId),
        );
        final workoutPlanId = insertedPlan!.id!;

        // Create scheduled sessions (some completed, some not)
        final session1 = WorkoutSession(
          workoutPlanId: workoutPlanId,
          date: weekStart.add(const Duration(days: 1)), // Tuesday
          dayName: 'Tuesday',
          focus: 'Upper Body',
          sessionComplete: true,
        );
        final session2 = WorkoutSession(
          workoutPlanId: workoutPlanId,
          date: weekStart.add(const Duration(days: 3)), // Thursday
          dayName: 'Thursday',
          focus: 'Lower Body',
          sessionComplete: false,
        );
        await WorkoutSession.db.insertRow(session, session1);
        await WorkoutSession.db.insertRow(session, session2);

        // Create exercises first (required for foreign key)
        final exercise1 = Exercise(
          name: 'Push Up',
          category: [ExerciseCategory.strength],
          muscleGroup: [ExerciseMuscleGroup.chest],
          difficulty: ExerciseDifficulty.beginner,
        );
        final exercise2 = Exercise(
          name: 'Squat',
          category: [ExerciseCategory.strength],
          muscleGroup: [ExerciseMuscleGroup.legs],
          difficulty: ExerciseDifficulty.beginner,
        );
        await Exercise.db.insertRow(session, exercise1);
        await Exercise.db.insertRow(session, exercise2);
        final insertedExercise1 = await Exercise.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Push Up'),
        );
        final insertedExercise2 = await Exercise.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Squat'),
        );
        final exercise1Id = insertedExercise1!.id!;
        final exercise2Id = insertedExercise2!.id!;

        // Create exercise logs
        final exerciseLog1 = ExerciseLog(
          userId: userProfileId,
          exerciseId: exercise1Id,
          date: weekStart.add(const Duration(days: 1)),
          setsCompleted: 3,
          repsCompleted: 10,
          weightUsed: 50.0,
        );
        final exerciseLog2 = ExerciseLog(
          userId: userProfileId,
          exerciseId: exercise2Id,
          date: weekStart.add(const Duration(days: 2)),
          setsCompleted: 3,
          repsCompleted: 12,
          weightUsed: 30.0,
        );
        await ExerciseLog.db.insertRow(session, exerciseLog1);
        await ExerciseLog.db.insertRow(session, exerciseLog2);

        // Create food category first (required for Food foreign key)
        final foodCategory = FoodCategory(
          name: 'Test Category',
          slug: 'test-category',
          iconName: 'test-icon',
          colorHex: '#000000',
          displayOrder: 0,
        );
        await FoodCategory.db.insertRow(session, foodCategory);
        final insertedCategory = await FoodCategory.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Test Category'),
        );
        final categoryId = insertedCategory!.id!;

        // Create foods first (required for foreign key)
        final food1 = Food(
          name: 'Chicken Breast',
          categoryId: categoryId,
          calories: 165.0,
          proteins: 31.0,
          carbs: 0.0,
          fats: 3.6,
          fiber: 0.0,
        );
        final food2 = Food(
          name: 'Brown Rice',
          categoryId: categoryId,
          calories: 111.0,
          proteins: 2.6,
          carbs: 23.0,
          fats: 0.9,
          fiber: 1.8,
        );
        final food3 = Food(
          name: 'Broccoli',
          categoryId: categoryId,
          calories: 34.0,
          proteins: 2.8,
          carbs: 7.0,
          fats: 0.4,
          fiber: 2.6,
        );
        await Food.db.insertRow(session, food1);
        await Food.db.insertRow(session, food2);
        await Food.db.insertRow(session, food3);
        final insertedFood1 = await Food.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Chicken Breast'),
        );
        final insertedFood2 = await Food.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Brown Rice'),
        );
        final insertedFood3 = await Food.db.findFirstRow(
          session,
          where: (t) => t.name.equals('Broccoli'),
        );
        final food1Id = insertedFood1!.id!;
        final food2Id = insertedFood2!.id!;
        final food3Id = insertedFood3!.id!;

        // Create food intake logs
        final foodLog1 = FoodIntakeLog(
          userId: userProfileId,
          foodId: food1Id,
          date: weekStart.add(const Duration(days: 1)),
          mealType: MealPlanType.breakfast,
          servingQuantity: 1.0,
          quantityGrams: 100.0,
        );
        final foodLog2 = FoodIntakeLog(
          userId: userProfileId,
          foodId: food2Id,
          date: weekStart.add(const Duration(days: 1)), // Same day
          mealType: MealPlanType.lunch,
          servingQuantity: 1.5,
          quantityGrams: 150.0,
        );
        final foodLog3 = FoodIntakeLog(
          userId: userProfileId,
          foodId: food3Id,
          date: weekStart.add(const Duration(days: 3)), // Different day
          mealType: MealPlanType.dinner,
          servingQuantity: 2.0,
          quantityGrams: 200.0,
        );
        await FoodIntakeLog.db.insertRow(session, foodLog1);
        await FoodIntakeLog.db.insertRow(session, foodLog2);
        await FoodIntakeLog.db.insertRow(session, foodLog3);

        // Act
        final result = await endpoints.dashboard.getWeeklySummary(
          authenticatedSessionBuilder,
        );

        // Assert
        expect(result, isNotNull);
        expect(result.workoutsScheduled, equals(2));
        expect(result.workoutsCompleted, equals(1));
        expect(result.totalExercisesLogged, equals(2));
        expect(result.nutritionDaysLogged, equals(2)); // 2 distinct days
        expect(result.totalMealsLogged, equals(3));
        expect(result.weekStartDate, isNotNull);
        expect(result.weekEndDate, isNotNull);
      });

      test(
        'should return empty summary when user profile does not exist',
        () async {
          // Arrange - no user profile in database
          // Act
          final result = await endpoints.dashboard.getWeeklySummary(
            authenticatedSessionBuilder,
          );

          // Assert
          expect(result, isNotNull);
          expect(result.workoutsScheduled, equals(0));
          expect(result.workoutsCompleted, equals(0));
          expect(result.totalExercisesLogged, equals(0));
          expect(result.nutritionDaysLogged, equals(0));
          expect(result.totalMealsLogged, equals(0));
          expect(result.weekStartDate, isNotNull);
          expect(result.weekEndDate, isNotNull);
        },
      );

      test('should calculate week correctly (Monday to Sunday)', () async {
        // Arrange
        final session = authenticatedSessionBuilder.build();
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
        final userProfile = createTestUserProfile();
        await UserProfile.db.insertRow(session, userProfile);

        // Act
        final result = await endpoints.dashboard.getWeeklySummary(
          authenticatedSessionBuilder,
        );

        // Assert
        expect(result.weekStartDate, isNotNull);
        expect(result.weekEndDate, isNotNull);
        // Week should start on Monday
        expect(result.weekStartDate.weekday, equals(1)); // Monday
        // Week should end on Sunday
        expect(result.weekEndDate.weekday, equals(7)); // Sunday
        // Week end should be 6 days after week start
        final daysDifference = result.weekEndDate
            .difference(result.weekStartDate)
            .inDays;
        expect(daysDifference, equals(6));
      });

      test('should aggregate workout data correctly', () async {
        // Arrange
        final session = authenticatedSessionBuilder.build();
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
        final userProfile = createTestUserProfile();
        await UserProfile.db.insertRow(session, userProfile);
        // Fetch the inserted profile to get the generated ID
        final insertedProfile = await UserProfile.db.findFirstRow(
          session,
          where: (t) => t.userInfoId.equals(userId),
        );
        final userProfileId = insertedProfile!.id!;

        // Use current date since endpoint uses DateTime.now()
        final now = DateTime.now();
        final weekStart = getMondayOfWeek(now);

        final workoutPlan = WorkoutPlan(
          userId: userProfileId,
          name: 'Test Plan',
          startDate: weekStart,
          endDate: weekStart.add(const Duration(days: 6)),
          difficultyLevel: ExerciseDifficulty.beginner,
          sessionsCount: 5,
        );
        await WorkoutPlan.db.insertRow(session, workoutPlan);
        // Fetch the inserted plan to get the generated ID
        final insertedPlan = await WorkoutPlan.db.findFirstRow(
          session,
          where: (t) => t.userId.equals(userProfileId),
        );
        final workoutPlanId = insertedPlan!.id!;

        // Create 3 scheduled sessions: 2 completed, 1 not completed
        final completedSession1 = WorkoutSession(
          workoutPlanId: workoutPlanId,
          date: weekStart.add(const Duration(days: 1)),
          dayName: 'Tuesday',
          focus: 'Upper Body',
          sessionComplete: true,
        );
        final completedSession2 = WorkoutSession(
          workoutPlanId: workoutPlanId,
          date: weekStart.add(const Duration(days: 2)),
          dayName: 'Wednesday',
          focus: 'Cardio',
          sessionComplete: true,
        );
        final incompleteSession = WorkoutSession(
          workoutPlanId: workoutPlanId,
          date: weekStart.add(const Duration(days: 3)),
          dayName: 'Thursday',
          focus: 'Lower Body',
          sessionComplete: false,
        );
        await WorkoutSession.db.insertRow(session, completedSession1);
        await WorkoutSession.db.insertRow(session, completedSession2);
        await WorkoutSession.db.insertRow(session, incompleteSession);

        // Act
        final result = await endpoints.dashboard.getWeeklySummary(
          authenticatedSessionBuilder,
        );

        // Assert
        expect(result.workoutsScheduled, equals(3));
        expect(result.workoutsCompleted, equals(2));
      });

      test('should count exercise logs correctly', () async {
        // Arrange
        final session = authenticatedSessionBuilder.build();
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
        final userProfile = createTestUserProfile();
        await UserProfile.db.insertRow(session, userProfile);
        // Fetch the inserted profile to get the generated ID
        final insertedProfile = await UserProfile.db.findFirstRow(
          session,
          where: (t) => t.userInfoId.equals(userId),
        );
        final userProfileId = insertedProfile!.id!;

        // Use current date since endpoint uses DateTime.now()
        final now = DateTime.now();
        final weekStart = getMondayOfWeek(now);

        // Create 5 exercises first
        final exercises = <Exercise>[];
        for (int i = 0; i < 5; i++) {
          final exercise = Exercise(
            name: 'Exercise ${i + 1}',
            category: [ExerciseCategory.strength],
            muscleGroup: [ExerciseMuscleGroup.chest],
            difficulty: ExerciseDifficulty.beginner,
          );
          await Exercise.db.insertRow(session, exercise);
          final inserted = await Exercise.db.findFirstRow(
            session,
            where: (t) => t.name.equals('Exercise ${i + 1}'),
          );
          exercises.add(inserted!);
        }

        // Create 5 exercise logs within the week
        for (int i = 0; i < 5; i++) {
          final exerciseLog = ExerciseLog(
            userId: userProfileId,
            exerciseId: exercises[i].id!,
            date: weekStart.add(Duration(days: i)),
            setsCompleted: 3,
            repsCompleted: 10,
            weightUsed: 50.0,
          );
          await ExerciseLog.db.insertRow(session, exerciseLog);
        }

        // Act
        final result = await endpoints.dashboard.getWeeklySummary(
          authenticatedSessionBuilder,
        );

        // Assert
        expect(result.totalExercisesLogged, equals(5));
      });

      test('should require authentication (requireLogin)', () async {
        // Act & Assert
        // When requireLogin is true and user is not authenticated,
        // Serverpod throws an exception before the endpoint method is called
        await expectLater(
          endpoints.dashboard.getWeeklySummary(unauthenticatedSessionBuilder),
          throwsException,
        );
      });

      test('should handle edge case: no data in week', () async {
        // Arrange
        final session = authenticatedSessionBuilder.build();
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
        final userProfile = createTestUserProfile();
        await UserProfile.db.insertRow(session, userProfile);

        // Act
        final result = await endpoints.dashboard.getWeeklySummary(
          authenticatedSessionBuilder,
        );

        // Assert
        expect(result, isNotNull);
        expect(result.workoutsScheduled, equals(0));
        expect(result.workoutsCompleted, equals(0));
        expect(result.totalExercisesLogged, equals(0));
        expect(result.nutritionDaysLogged, equals(0));
        expect(result.totalMealsLogged, equals(0));
      });

      test(
        'should handle edge case: week boundaries (sessions outside week)',
        () async {
          // Arrange
          final session = authenticatedSessionBuilder.build();
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
          final userProfile = createTestUserProfile();
          await UserProfile.db.insertRow(session, userProfile);
          // Fetch the inserted profile to get the generated ID
          final insertedProfile = await UserProfile.db.findFirstRow(
            session,
            where: (t) => t.userInfoId.equals(userId),
          );
          final userProfileId = insertedProfile!.id!;

          // Use current date since endpoint uses DateTime.now()
          final now = DateTime.now();
          final weekStart = getMondayOfWeek(now);
          final weekEnd = weekStart.add(const Duration(days: 6));

          final workoutPlan = WorkoutPlan(
            userId: userProfileId,
            name: 'Test Plan',
            startDate: weekStart,
            endDate: weekEnd,
            difficultyLevel: ExerciseDifficulty.beginner,
            sessionsCount: 3,
          );
          await WorkoutPlan.db.insertRow(session, workoutPlan);
          // Fetch the inserted plan to get the generated ID
          final insertedPlan = await WorkoutPlan.db.findFirstRow(
            session,
            where: (t) => t.userId.equals(userProfileId),
          );
          final workoutPlanId = insertedPlan!.id!;

          // Create session within week
          final sessionInWeek = WorkoutSession(
            workoutPlanId: workoutPlanId,
            date: weekStart.add(const Duration(days: 2)),
            dayName: 'Wednesday',
            focus: 'Full Body',
            sessionComplete: true,
          );
          // Create session before week (should not be counted)
          final sessionBeforeWeek = WorkoutSession(
            workoutPlanId: workoutPlanId,
            date: weekStart.subtract(const Duration(days: 1)),
            dayName: 'Sunday',
            focus: 'Rest',
            sessionComplete: true,
          );
          // Create session after week (should not be counted)
          final sessionAfterWeek = WorkoutSession(
            workoutPlanId: workoutPlanId,
            date: weekEnd.add(const Duration(days: 1)),
            dayName: 'Monday',
            focus: 'Next Week',
            sessionComplete: true,
          );
          await WorkoutSession.db.insertRow(session, sessionInWeek);
          await WorkoutSession.db.insertRow(session, sessionBeforeWeek);
          await WorkoutSession.db.insertRow(session, sessionAfterWeek);

          // Act
          final result = await endpoints.dashboard.getWeeklySummary(
            authenticatedSessionBuilder,
          );

          // Assert
          expect(result.workoutsScheduled, equals(1));
          expect(result.workoutsCompleted, equals(1));
        },
      );
    });
  });
}
