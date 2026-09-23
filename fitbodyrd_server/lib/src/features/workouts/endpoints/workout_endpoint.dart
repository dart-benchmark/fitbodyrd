import 'package:fitbodyrd_server/src/common/utils/endpoint_utils.dart';
import 'package:fitbodyrd_server/src/core/agent_client/agent_client.dart';
import 'package:fitbodyrd_server/src/core/injections/injection_container.dart';
import 'package:fitbodyrd_server/src/features/user/endpoints/admin_user_endpoint.dart';
import 'package:fitbodyrd_server/src/features/workouts/exceptions/workout_exceptions.dart';
import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class WorkoutEndpoint extends Endpoint {
  String getCreateWorkoutPlanChannelName(int userId) {
    return 'create_workout_plan_$userId';
  }

  Future<WorkoutPlan> getActiveWorkoutPlan(Session session, int userId) async {
    final workoutPlan = await WorkoutPlan.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.status.equals(Status.active),
      include: WorkoutPlan.include(
        sessions: WorkoutSession.includeList(
          orderBy: (t) => t.date,
          include: WorkoutSession.include(
            exercises: WorkoutExercise.includeList(
              orderBy: (t) => t.order,
              include: WorkoutExercise.include(
                exercise: Exercise.include(),
              ),
            ),
          ),
        ),
      ),
    );

    if (workoutPlan == null) {
      throw WorkoutExceptions.noActiveWorkoutPlan();
    }

    return workoutPlan;
  }

  Future<List<ExerciseLog>> getExerciseLogs(
    Session session,
    DateTime startDate,
    DateTime endDate,
    List<int> exerciseIds,
  ) async {
    // Ensure we're querying for the authenticated user
    final userId = await EndpointUtils.getUserIdFromSession(session);

    // Query logs within the date range for the specified exercises
    final logs = await ExerciseLog.db.find(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.date.between(startDate, endDate) &
          t.exerciseId.inSet(exerciseIds.toSet()),
      orderBy: (t) => t.date,
    );

    return logs;
  }

  Future<void> deleteExerciseLog(
    Session session,
    int logId,
  ) async {
    final userId = await EndpointUtils.getUserIdFromSession(session);

    final log = await ExerciseLog.db.findById(session, logId);

    if (log == null || log.userId != userId) {
      throw WorkoutExceptions.exerciseLogNotFound();
    }

    // Store workoutExerciseId and date before deletion
    final workoutExerciseId = log.workoutExerciseId;
    final logDate = log.date;

    await ExerciseLog.db.deleteRow(session, log);

    // Update session completion status after deletion
    if (workoutExerciseId != null) {
      await _updateSessionCompletionStatus(session, workoutExerciseId, logDate);
    }
  }

  Future<WorkoutPlan> createBaseWorkoutPlan(
    Session session,
    int userId,
    String name,
    DateTime startDate,
    DateTime endDate,
    ExerciseDifficulty difficultyLevel,
    int sessionsCount,
  ) async {
    final activeWorkoutPlanCount = await WorkoutPlan.db.count(
      session,
      where: (t) => t.userId.equals(userId) & t.status.equals(Status.active),
    );

    if (activeWorkoutPlanCount > 0) {
      throw WorkoutExceptions.activeWorkoutPlanExists();
    }

    try {
      final actualWorkoutPlan = WorkoutPlan(
        userId: userId,
        name: name,
        startDate: startDate,
        endDate: endDate,
        difficultyLevel: difficultyLevel,
        status: Status.active,
        sessionsCount: sessionsCount,
      );

      final insertedWorkoutPlan = await WorkoutPlan.db.insertRow(
        session,
        actualWorkoutPlan,
      );

      return insertedWorkoutPlan;
    } catch (e) {
      session.log('Error creating workout plan: $e', level: LogLevel.error);
      throw WorkoutExceptions.errorCreatingWorkoutPlan();
    }
  }

  Future<void> createWorkoutSession(
    Session session,
    int workoutPlanId,
    CreateWorkoutSessionDto workoutSession,
  ) async {
    final workoutPlan = await WorkoutPlan.db.findFirstRow(
      session,
      where: (t) => t.id.equals(workoutPlanId),
    );

    if (workoutPlan == null) {
      throw WorkoutExceptions.noActiveWorkoutPlan();
    }

    final success = await session.db.transaction((transaction) async {
      var createdWorkoutSession = WorkoutSession(
        workoutPlanId: workoutPlanId,
        date: workoutSession.date,
        dayName: workoutSession.dayName,
        focus: workoutSession.focus,
        notes: workoutSession.notes,
      );

      createdWorkoutSession = await WorkoutSession.db.insertRow(
        session,
        createdWorkoutSession,
        transaction: transaction,
      );

      for (var exerciseDto in workoutSession.exercises) {
        final workoutExercise = WorkoutExercise(
          workoutSessionId: createdWorkoutSession.id!,
          exerciseId: exerciseDto.exerciseId,
          order: exerciseDto.order,
          sets: exerciseDto.sets,
          reps: exerciseDto.reps,
          restSeconds: exerciseDto.restSeconds,
          notes: exerciseDto.notes,
        );

        await WorkoutExercise.db.insertRow(
          session,
          workoutExercise,
          transaction: transaction,
        );
      }

      return true;
    });

    if (success == true) {
      final currentSessionsCount = await WorkoutSession.db.count(
        session,
        where: (t) => t.workoutPlanId.equals(workoutPlanId),
      );

      final progressPercentage =
          (currentSessionsCount / workoutPlan.sessionsCount) * 100;
      await session.messages.postMessage(
        getCreateWorkoutPlanChannelName(workoutPlan.userId),
        GenerateWorkoutPlanProgressDto(
          success: success,
          progressPercentage: progressPercentage,
          currentDay: currentSessionsCount,
          totalDays: workoutPlan.sessionsCount,
          status: currentSessionsCount == workoutPlan.sessionsCount
              ? StreamStatus.completed
              : StreamStatus.waiting,
          message: 'Workout session created successfully',
          updatedAt: DateTime.now(),
        ),
      );
    }
  }

  Future<void> createWorkoutPlan(
    Session session,
    CreateWorkoutPlanDto workoutPlan,
  ) async {
    final activeWorkoutPlanCount = await WorkoutPlan.db.count(
      session,
      where: (t) =>
          t.userId.equals(workoutPlan.userId) & t.status.equals(Status.active),
    );

    if (activeWorkoutPlanCount > 0) {
      throw WorkoutExceptions.activeWorkoutPlanExists();
    }

    try {
      await session.db.transaction(
        (transaction) async {
          final actualWorkoutPlan = WorkoutPlan(
            userId: workoutPlan.userId,
            name: workoutPlan.name,
            startDate: workoutPlan.startDate,
            endDate: workoutPlan.endDate,
            difficultyLevel: workoutPlan.difficultyLevel,
            status: Status.active,
          );

          final insertedWorkoutPlan = await WorkoutPlan.db.insertRow(
            session,
            actualWorkoutPlan,
            transaction: transaction,
          );

          if (workoutPlan.sessions == null) {
            throw WorkoutExceptions.errorCreatingWorkoutPlan();
          }

          for (var sessionDto in workoutPlan.sessions!) {
            final workoutSession = WorkoutSession(
              workoutPlanId: insertedWorkoutPlan.id!,
              date: sessionDto.date,
              dayName: sessionDto.dayName,
              focus: sessionDto.focus,
              notes: sessionDto.notes,
            );

            final insertedWorkoutSession = await WorkoutSession.db.insertRow(
              session,
              workoutSession,
              transaction: transaction,
            );

            for (var exerciseDto in sessionDto.exercises) {
              final workoutExercise = WorkoutExercise(
                workoutSessionId: insertedWorkoutSession.id!,
                exerciseId: exerciseDto.exerciseId,
                order: exerciseDto.order,
                sets: exerciseDto.sets,
                reps: exerciseDto.reps,
                restSeconds: exerciseDto.restSeconds,
                notes: exerciseDto.notes,
              );

              await WorkoutExercise.db.insertRow(
                session,
                workoutExercise,
                transaction: transaction,
              );
            }
          }
        },
      );

      // await session.messages.postMessage(
      //   getCreateWorkoutPlanChannelName(workoutPlan.userId),
      //   StreamStatus.completed,
      // );
    } on AppException catch (_) {
      rethrow;
    } catch (e) {
      session.log('Error creating workout plan: $e', level: LogLevel.error);
      // await session.messages.postMessage(
      //   getCreateWorkoutPlanChannelName(workoutPlan.userId),
      //   StreamStatus.error,
      // );
    }
  }

  Future<void> notifyErrorCreatingWorkoutPlan(
    Session session,
    int userId,
  ) async {
    await session.messages.postMessage(
      getCreateWorkoutPlanChannelName(userId),
      GenerateWorkoutPlanProgressDto(
        success: false,
        progressPercentage: 0,
        currentDay: 0,
        totalDays: 0,
        status: StreamStatus.error,
        message: 'Error al generar el plan de entrenamiento',
        updatedAt: DateTime.now(),
      ),
    );
  }

  Stream<GenerateWorkoutPlanProgressDto> requestWorkoutPlanGeneration(
    Session session,
    int userId,
    int numberOfWeeks,
  ) async* {
    final activeWorkoutPlan = await WorkoutPlan.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.status.equals(Status.active),
    );

    if (activeWorkoutPlan != null) {
      await WorkoutPlan.db.updateRow(
        session,
        activeWorkoutPlan.copyWith(
          status: Status.cancelled,
          updatedAt: DateTime.now(),
        ),
      );
      // throw WorkoutExceptions.activeWorkoutPlanExists();
    }

    final user = await AdminUserEndpoint().findUserProfile(session, userId);

    yield GenerateWorkoutPlanProgressDto(
      success: false,
      progressPercentage: 0,
      currentDay: 0,
      totalDays: numberOfWeeks * 7,
      status: StreamStatus.waiting,
      message: 'Generando plan de entrenamiento...',
      updatedAt: DateTime.now(),
    );

    final startDate = DateTime.now();
    final endDate = startDate.add(Duration(days: numberOfWeeks * 7));
    final sessionsCount = numberOfWeeks * user.daysPerWeekExercise;

    final baseWorkoutPlan = await createBaseWorkoutPlan(
      session,
      userId,
      'Workout Plan',
      startDate,
      endDate,
      user.experienceLevel,
      sessionsCount,
    );

    try {
      await sl<AgentClient>().sendCreateWorkoutPlanRequest(
        numberOfWeeks: numberOfWeeks,
        userProfile: user,
        baseWorkoutPlanId: baseWorkoutPlan.id!,
        startDate: startDate,
        sessionsCount: sessionsCount,
      );
    } catch (e) {
      session.log(
        'Error requesting workout plan generation: $e',
        level: LogLevel.error,
      );

      yield GenerateWorkoutPlanProgressDto(
        success: false,
        progressPercentage: 0,
        currentDay: 0,
        totalDays: numberOfWeeks * 7,
        status: StreamStatus.error,
        message: 'Error al generar el plan de entrenamiento: $e',
        updatedAt: DateTime.now(),
      );
      return;
    }

    final channelName = getCreateWorkoutPlanChannelName(userId);
    final stream = session.messages
        .createStream<GenerateWorkoutPlanProgressDto>(channelName);

    await for (final status in stream) {
      yield status;
      if (status.status == StreamStatus.completed ||
          status.status == StreamStatus.error) {
        return;
      }
    }
  }

  Stream<String> listenToWorkoutTips(Session session) async* {
    // Get all tips ordered
    final tips = await WorkoutTip.db.find(
      session,
      orderBy: (t) => t.order,
    );

    if (tips.isEmpty) {
      yield 'Preparando tu plan de entrenamiento...';
      return;
    }

    int currentIndex = 0;

    // Stream tips indefinitely (client will close when workout plan completes)
    while (true) {
      yield tips[currentIndex].content;
      currentIndex = (currentIndex + 1) % tips.length;

      // Wait 10 seconds before sending next tip
      await Future.delayed(const Duration(seconds: 10));
    }
  }

  Future<ExerciseLog> logWorkoutExercise(
    Session session,
    ExerciseLog log,
  ) async {
    final userId = await EndpointUtils.getUserIdFromSession(session);

    // Check if log already exists for this exercise on this date
    // We compare dates by day, month, and year
    final startOfDay = DateTime(log.date.year, log.date.month, log.date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final existingLog = await ExerciseLog.db.findFirstRow(
      session,
      where: (t) =>
          t.workoutExerciseId.equals(log.workoutExerciseId) &
          t.date.between(startOfDay, endOfDay),
    );

    ExerciseLog savedLog;
    if (existingLog != null) {
      // Update existing log
      final updatedLog = existingLog.copyWith(
        setsCompleted: log.setsCompleted,
        repsCompleted: log.repsCompleted,
        weightUsed: log.weightUsed,
        difficultyRating: log.difficultyRating,
        notes: log.notes,
        userId: userId,
        date: log.date,
      );
      savedLog = await ExerciseLog.db.updateRow(session, updatedLog);
    } else {
      // Create new log
      savedLog = await ExerciseLog.db.insertRow(
        session,
        log.copyWith(
          userId: userId,
        ),
      );
    }

    // Update session completion status
    if (log.workoutExerciseId != null) {
      await _updateSessionCompletionStatus(
          session, log.workoutExerciseId!, log.date);
    }

    return savedLog;
  }

  Future<List<WorkoutSession>> getWorkoutHistory(
    Session session,
    DateTime? startDate,
    DateTime? endDate,
  ) async {
    final userId = await EndpointUtils.getUserIdFromSession(session);

    // Get user profile to access user profile ID
    final userProfile = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.userInfoId.equals(userId),
    );

    if (userProfile == null) {
      return [];
    }

    final userProfileId = userProfile.id!;

    // Get all workout plans for the user (active, completed, cancelled)
    final workoutPlans = await WorkoutPlan.db.find(
      session,
      where: (t) => t.userId.equals(userProfileId),
    );

    if (workoutPlans.isEmpty) {
      return [];
    }

    final planIds = workoutPlans.map((plan) => plan.id!).toList();

    // Build date range query
    var query = WorkoutSession.db.find(
      session,
      where: (t) => t.workoutPlanId.inSet(planIds.toSet()),
      include: WorkoutSession.include(
        exercises: WorkoutExercise.includeList(
          orderBy: (t) => t.order,
          include: WorkoutExercise.include(
            exercise: Exercise.include(),
          ),
        ),
        workoutPlan: WorkoutPlan.include(),
      ),
      orderBy: (t) => t.date,
      orderDescending: true,
    );

    final sessions = await query;

    // Filter by date range if provided
    if (startDate != null || endDate != null) {
      final filteredSessions = <WorkoutSession>[];
      for (final session in sessions) {
        final sessionDate = DateTime(
          session.date.year,
          session.date.month,
          session.date.day,
        );

        if (startDate != null) {
          final start = DateTime(
            startDate.year,
            startDate.month,
            startDate.day,
          );
          if (sessionDate.isBefore(start)) {
            continue;
          }
        }

        if (endDate != null) {
          final end = DateTime(
            endDate.year,
            endDate.month,
            endDate.day,
            23,
            59,
            59,
          );
          if (sessionDate.isAfter(end)) {
            continue;
          }
        }

        filteredSessions.add(session);
      }
      return filteredSessions;
    }

    return sessions;
  }

  Future<WorkoutProgressMetricsDto> getWorkoutProgressMetrics(
    Session session,
    DateTime? startDate,
    DateTime? endDate,
  ) async {
    final userId = await EndpointUtils.getUserIdFromSession(session);

    // Get user profile to access user profile ID
    final userProfile = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.userInfoId.equals(userId),
    );

    if (userProfile == null) {
      return _getEmptyProgressMetrics();
    }

    final userProfileId = userProfile.id!;

    // Build date range for queries
    final now = DateTime.now();
    final queryStartDate = startDate ?? DateTime(2000);
    final queryEndDate = endDate ?? now;

    // Get all exercise logs for the user
    final allLogs = await ExerciseLog.db.find(
      session,
      where: (t) =>
          t.userId.equals(userProfileId) &
          t.date.between(queryStartDate, queryEndDate),
      orderBy: (t) => t.date,
    );

    // Count distinct workout dates (days with at least one exercise logged)
    final workoutDates = allLogs
        .map((log) => DateTime(
              log.date.year,
              log.date.month,
              log.date.day,
            ))
        .toSet();
    final totalWorkoutsCompleted = workoutDates.length;
    final totalExercisesLogged = allLogs.length;

    // Calculate streaks
    final sortedDates = workoutDates.toList()..sort();
    final streaks = _calculateStreaks(sortedDates);
    final currentStreak = streaks.currentStreak;
    final longestStreak = streaks.longestStreak;

    // Calculate workouts this week
    final weekStart = _getMondayOfWeek(now);
    final weekEnd =
        weekStart.add(const Duration(days: 6, hours: 23, minutes: 59));
    final workoutsThisWeek = workoutDates.where((date) {
      return date.isAfter(weekStart.subtract(const Duration(days: 1))) &&
          date.isBefore(weekEnd.add(const Duration(days: 1)));
    }).length;

    // Calculate workouts this month
    final monthStart = DateTime(now.year, now.month, 1);
    final monthEnd = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
    final workoutsThisMonth = workoutDates.where((date) {
      return date.isAfter(monthStart.subtract(const Duration(days: 1))) &&
          date.isBefore(monthEnd.add(const Duration(days: 1)));
    }).length;

    // Calculate average workouts per week
    final daysDiff = queryEndDate.difference(queryStartDate).inDays;
    final weeks = daysDiff > 0 ? (daysDiff / 7.0) : 1.0;
    final averageWorkoutsPerWeek = totalWorkoutsCompleted / weeks;

    return WorkoutProgressMetricsDto(
      totalWorkoutsCompleted: totalWorkoutsCompleted,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      averageWorkoutsPerWeek: averageWorkoutsPerWeek,
      totalExercisesLogged: totalExercisesLogged,
      workoutsThisWeek: workoutsThisWeek,
      workoutsThisMonth: workoutsThisMonth,
    );
  }

  Future<List<WorkoutSessionsByDateDto>> getWorkoutSessionsByDateRange(
    Session session,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final sessions = await getWorkoutHistory(session, startDate, endDate);

    // Group sessions by date
    final sessionsByDate = <DateTime, List<WorkoutSession>>{};
    for (final session in sessions) {
      final dateKey = DateTime(
        session.date.year,
        session.date.month,
        session.date.day,
      );
      sessionsByDate.putIfAbsent(dateKey, () => []).add(session);
    }

    // Get all exercise logs for these sessions to count completed exercises
    final userId = await EndpointUtils.getUserIdFromSession(session);
    final userProfile = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.userInfoId.equals(userId),
    );

    if (userProfile == null) {
      return [];
    }

    final userProfileId = userProfile.id!;
    final exerciseLogs = await ExerciseLog.db.find(
      session,
      where: (t) =>
          t.userId.equals(userProfileId) & t.date.between(startDate, endDate),
    );

    // Count exercises per date
    final exercisesByDate = <DateTime, int>{};
    for (final log in exerciseLogs) {
      final dateKey = DateTime(
        log.date.year,
        log.date.month,
        log.date.day,
      );
      exercisesByDate[dateKey] = (exercisesByDate[dateKey] ?? 0) + 1;
    }

    // Build result DTOs
    final result = <WorkoutSessionsByDateDto>[];
    final sortedDates = sessionsByDate.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    for (final date in sortedDates) {
      result.add(
        WorkoutSessionsByDateDto(
          date: date,
          sessions: sessionsByDate[date]!,
          totalExercisesCompleted: exercisesByDate[date] ?? 0,
        ),
      );
    }

    return result;
  }

  WorkoutProgressMetricsDto _getEmptyProgressMetrics() {
    return WorkoutProgressMetricsDto(
      totalWorkoutsCompleted: 0,
      currentStreak: 0,
      longestStreak: 0,
      averageWorkoutsPerWeek: 0.0,
      totalExercisesLogged: 0,
      workoutsThisWeek: 0,
      workoutsThisMonth: 0,
    );
  }

  Future<void> _updateSessionCompletionStatus(
    Session session,
    int workoutExerciseId,
    DateTime logDate,
  ) async {
    // Get the workout exercise to find the session
    final workoutExercise = await WorkoutExercise.db.findById(
      session,
      workoutExerciseId,
    );

    if (workoutExercise == null) {
      return;
    }

    // Get the workout session with all exercises
    final workoutSession = await WorkoutSession.db.findById(
      session,
      workoutExercise.workoutSessionId,
      include: WorkoutSession.include(
        exercises: WorkoutExercise.includeList(),
      ),
    );

    if (workoutSession == null || workoutSession.exercises == null) {
      return;
    }

    // Check if all exercises in the session have logs for this date
    final sessionDate = DateTime(
      workoutSession.date.year,
      workoutSession.date.month,
      workoutSession.date.day,
    );
    final logDateOnly = DateTime(
      logDate.year,
      logDate.month,
      logDate.day,
    );

    // Only update if the log date matches the session date
    if (sessionDate != logDateOnly) {
      return;
    }

    final startOfDay = DateTime(
      logDate.year,
      logDate.month,
      logDate.day,
    );
    final endOfDay = startOfDay.add(const Duration(days: 1));

    // Get all workout exercise IDs in the session
    final workoutExerciseIds = workoutSession.exercises!
        .where((e) => e.id != null)
        .map((e) => e.id!)
        .toList();

    if (workoutExerciseIds.isEmpty) {
      // No exercises, mark as incomplete
      await WorkoutSession.db.updateRow(
        session,
        workoutSession.copyWith(sessionComplete: false),
      );
      return;
    }

    // Check if all exercises have logs
    bool allExercisesHaveLogs = true;
    for (final workoutExerciseId in workoutExerciseIds) {
      final logExists = await ExerciseLog.db.findFirstRow(
        session,
        where: (t) =>
            t.workoutExerciseId.equals(workoutExerciseId) &
            t.date.between(startOfDay, endOfDay),
      );

      if (logExists == null) {
        allExercisesHaveLogs = false;
        break;
      }
    }

    // Update session completion status
    await WorkoutSession.db.updateRow(
      session,
      workoutSession.copyWith(sessionComplete: allExercisesHaveLogs),
    );
  }

  DateTime _getMondayOfWeek(DateTime date) {
    final dayOfWeek = date.weekday;
    final daysToSubtract = dayOfWeek - 1;
    return DateTime(date.year, date.month, date.day)
        .subtract(Duration(days: daysToSubtract));
  }

  _StreakResult _calculateStreaks(List<DateTime> sortedDates) {
    if (sortedDates.isEmpty) {
      return _StreakResult(currentStreak: 0, longestStreak: 0);
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Calculate longest streak
    int longestStreak = 1;
    int tempStreak = 1;
    for (int i = 0; i < sortedDates.length - 1; i++) {
      final currentDate = sortedDates[i];
      final nextDate = sortedDates[i + 1];
      final daysDiff = currentDate.difference(nextDate).inDays;

      if (daysDiff == 1) {
        // Consecutive day
        tempStreak++;
        longestStreak = tempStreak > longestStreak ? tempStreak : longestStreak;
      } else {
        // Break in streak
        tempStreak = 1;
      }
    }

    // Calculate current streak (from today backwards)
    int currentStreak = 0;
    DateTime expectedDate = today;
    for (final date in sortedDates.reversed) {
      final dateOnly = DateTime(date.year, date.month, date.day);
      if (dateOnly == expectedDate ||
          dateOnly == expectedDate.subtract(const Duration(days: 1))) {
        // Allow today or yesterday to start the streak
        if (currentStreak == 0) {
          currentStreak = 1;
          expectedDate = dateOnly.subtract(const Duration(days: 1));
        } else if (dateOnly == expectedDate) {
          currentStreak++;
          expectedDate = dateOnly.subtract(const Duration(days: 1));
        } else {
          // Gap found, streak broken
          break;
        }
      } else if (dateOnly.isBefore(expectedDate)) {
        // Gap found, streak broken
        break;
      }
    }

    return _StreakResult(
      currentStreak: currentStreak,
      longestStreak: longestStreak,
    );
  }
}

class _StreakResult {
  _StreakResult({
    required this.currentStreak,
    required this.longestStreak,
  });

  final int currentStreak;
  final int longestStreak;
}
