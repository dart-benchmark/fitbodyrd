import 'package:fitbodyrd_server/src/common/utils/endpoint_utils.dart';
import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class DashboardEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<WeeklySummaryDto> getWeeklySummary(Session session) async {
    final userId = await EndpointUtils.getUserIdFromSession(session);

    // Get user profile to access user ID for queries
    final userProfile = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.userInfoId.equals(userId),
    );

    if (userProfile == null) {
      // Return empty summary if no profile exists
      return _getEmptySummary();
    }

    final userProfileId = userProfile.id!;

    // Calculate current week (Monday to Sunday)
    final now = DateTime.now();
    final weekStartDate = _getMondayOfWeek(now);
    final weekEndDate = weekStartDate.add(const Duration(days: 6));

    // Set time to end of day for inclusive range
    final weekStart = DateTime(
      weekStartDate.year,
      weekStartDate.month,
      weekStartDate.day,
    );
    final weekEnd = DateTime(
      weekEndDate.year,
      weekEndDate.month,
      weekEndDate.day,
      23,
      59,
      59,
    );

    // Get scheduled workouts for this week
    final workoutPlans = await WorkoutPlan.db.find(
      session,
      where: (t) => t.userId.equals(userProfileId),
    );

    int workoutsScheduled = 0;
    int workoutsCompleted = 0;
    int totalExercisesLogged = 0;

    if (workoutPlans.isNotEmpty) {
      final planIds = workoutPlans.map((plan) => plan.id!).toList();
      final scheduledSessions = await WorkoutSession.db.find(
        session,
        where: (t) =>
            t.workoutPlanId.inSet(planIds.toSet()) &
            t.date.between(weekStart, weekEnd),
      );
      workoutsScheduled = scheduledSessions.length;

      // Count completed sessions using sessionComplete field
      workoutsCompleted = scheduledSessions
          .where((s) => s.sessionComplete == true)
          .length;
    }

    // Get total exercises logged for the week
    final exerciseLogs = await ExerciseLog.db.find(
      session,
      where: (t) =>
          t.userId.equals(userProfileId) & t.date.between(weekStart, weekEnd),
    );
    totalExercisesLogged = exerciseLogs.length;

    // Aggregate nutrition data
    final foodIntakeLogs = await FoodIntakeLog.db.find(
      session,
      where: (t) =>
          t.userId.equals(userProfileId) & t.date.between(weekStart, weekEnd),
    );

    // Count distinct dates with food intake logs
    final nutritionDates = foodIntakeLogs
        .map((log) => DateTime(
              log.date.year,
              log.date.month,
              log.date.day,
            ))
        .toSet();
    final nutritionDaysLogged = nutritionDates.length;
    final totalMealsLogged = foodIntakeLogs.length;

    return WeeklySummaryDto(
      workoutsCompleted: workoutsCompleted,
      workoutsScheduled: workoutsScheduled,
      nutritionDaysLogged: nutritionDaysLogged,
      totalExercisesLogged: totalExercisesLogged,
      totalMealsLogged: totalMealsLogged,
      weekStartDate: weekStart,
      weekEndDate: weekEnd,
    );
  }

  DateTime _getMondayOfWeek(DateTime date) {
    // Get the day of week (1 = Monday, 7 = Sunday)
    final dayOfWeek = date.weekday;
    // Calculate days to subtract to get to Monday
    final daysToSubtract = dayOfWeek - 1;
    return DateTime(date.year, date.month, date.day)
        .subtract(Duration(days: daysToSubtract));
  }

  WeeklySummaryDto _getEmptySummary() {
    final now = DateTime.now();
    final weekStartDate = _getMondayOfWeek(now);
    final weekEndDate = weekStartDate.add(const Duration(days: 6));

    return WeeklySummaryDto(
      workoutsCompleted: 0,
      workoutsScheduled: 0,
      nutritionDaysLogged: 0,
      totalExercisesLogged: 0,
      totalMealsLogged: 0,
      weekStartDate: weekStartDate,
      weekEndDate: weekEndDate,
    );
  }
}
