import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:timezone/timezone.dart' as tz;

class CompleteExpiredPlansFutureCall extends FutureCall {
  @override
  Future<void> invoke(Session session, SerializableModel? object) async {
    session.log('Running CompleteExpiredPlansFutureCall');

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Complete expired nutrition plans
    final expiredNutritionPlans = await NutritionPlan.db.find(
      session,
      where: (t) => t.status.equals(Status.active) & (t.endDate < today),
    );

    if (expiredNutritionPlans.isNotEmpty) {
      session.log(
        'Found ${expiredNutritionPlans.length} expired nutrition plans to complete',
      );

      final updatedPlans = <NutritionPlan>[];

      for (final plan in expiredNutritionPlans) {
        plan.status = Status.completed;
        plan.updatedAt = now;
        updatedPlans.add(plan);
      }

      await NutritionPlan.db.update(session, updatedPlans);

      session.log(
        'Completed ${expiredNutritionPlans.length} nutrition plans',
      );
    }

    final expiredWorkoutPlans = await WorkoutPlan.db.find(
      session,
      where: (t) => t.status.equals(Status.active) & (t.endDate < today),
    );

    if (expiredWorkoutPlans.isNotEmpty) {
      session.log(
        'Found ${expiredWorkoutPlans.length} expired workout plans to complete',
      );

      final updatedWorkoutPlans = <WorkoutPlan>[];
      for (final plan in expiredWorkoutPlans) {
        plan.status = Status.completed;
        plan.updatedAt = now;
        updatedWorkoutPlans.add(plan);
      }

      await WorkoutPlan.db.update(session, updatedWorkoutPlans);
      session.log(
        'Completed ${expiredWorkoutPlans.length} workout plans',
      );
    }

    // Reschedule for next midnight DR time
    await _scheduleNextRun(session);
  }

  Future<void> _scheduleNextRun(Session session) async {
    // Dominican Republic timezone (UTC-4)
    final drLocation = tz.getLocation('America/Santo_Domingo');
    final nowDR = tz.TZDateTime.now(drLocation);

    // Calculate next midnight DR time
    var nextMidnight = tz.TZDateTime(
      drLocation,
      nowDR.year,
      nowDR.month,
      nowDR.day + 1,
      0, // midnight
      0,
      0,
    );

    // Convert to UTC for scheduling
    final nextRunUTC = nextMidnight.toUtc();

    session.log(
      'Scheduling next run at ${nextMidnight.toString()} DR time (${nextRunUTC.toString()} UTC)',
    );

    // Schedule next run
    await session.serverpod.futureCallAtTime(
      'completeExpiredPlans',
      null,
      nextRunUTC,
    );
  }
}
