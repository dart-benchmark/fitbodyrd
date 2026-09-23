import 'dart:async';

import 'package:fitbodyrd_server/src/core/injections/injection_container.dart';
import 'package:fitbodyrd_server/src/features/auth/utils/auth_setup.dart';
import 'package:fitbodyrd_server/src/features/email/future_calls/email_template_future_call.dart';
import 'package:fitbodyrd_server/src/features/plans/future_calls/complete_expired_plans_future_call.dart';
import 'package:fitbodyrd_server/src/features/workouts/future_calls/workout_tip_future_call.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

import 'package:serverpod/serverpod.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';

void run(List<String> args) async {
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: auth.authenticationHandler,
  );

  await injectDependencies(pod);

  await setupAuth();

  pod.registerFutureCall(
    EmailTemplateFutureCall(),
    FutureCallNames.emailTemplate.name,
  );

  pod.registerFutureCall(
    WorkoutTipFutureCall(),
    FutureCallNames.workoutTip.name,
  );

  pod.registerFutureCall(
    CompleteExpiredPlansFutureCall(),
    FutureCallNames.completeExpiredPlans.name,
  );

  await pod.start();

  unawaited(
    pod.futureCallWithDelay(
      FutureCallNames.emailTemplate.name,
      null,
      Duration.zero,
    ),
  );

  unawaited(
    pod.futureCallWithDelay(
      FutureCallNames.workoutTip.name,
      null,
      Duration.zero,
    ),
  );

  // Schedule the plan completion task for next midnight DR time
  unawaited(_scheduleNextMidnightRun(pod));
}

Future<void> _scheduleNextMidnightRun(Serverpod pod) async {
  // Initialize timezone data
  tz_data.initializeTimeZones();

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

  final futureCallIdentifier =
      'complete_expired_plans_${nextRunUTC.toString()}';

  await pod.cancelFutureCall(futureCallIdentifier);

  pod.logVerbose(
    'Scheduling plan completion task at'
    ' ${nextMidnight.toString()} DR time'
    ' (${nextRunUTC.toString()} UTC)',
  );

  await pod.futureCallAtTime(
    FutureCallNames.completeExpiredPlans.name,
    null,
    nextRunUTC,
    identifier: futureCallIdentifier,
  );
}

enum FutureCallNames { emailTemplate, workoutTip, completeExpiredPlans }
