import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

part 'default_workout_tips.dart';

class WorkoutTipFutureCall extends FutureCall {
  @override
  Future<void> invoke(Session session, SerializableModel? object) async {
    final count = await WorkoutTip.db.count(session);

    if (count >= defaultWorkoutTips.length) {
      return;
    }

    await WorkoutTip.db.deleteWhere(
      session,
      where: (p0) => Constant.bool(true),
    );

    await WorkoutTip.db.insert(
      session,
      defaultWorkoutTips,
    );
  }
}
