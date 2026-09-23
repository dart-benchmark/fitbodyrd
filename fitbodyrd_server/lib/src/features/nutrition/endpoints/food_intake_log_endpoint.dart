import 'package:fitbodyrd_server/src/common/utils/endpoint_utils.dart';
import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class FoodIntakeLogEndpoint extends Endpoint {
  Future<FoodIntakeLog> create(Session session, CreateFoodIntakeLog dto) async {
    final userId = await EndpointUtils.getUserIdFromSession(session);

    final userProfile = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.userInfoId.equals(userId),
    );

    if (userProfile == null) {
      throw Exception('User profile not found');
    }

    final log = FoodIntakeLog(
      userId: userProfile.id!,
      mealPlanId: dto.mealPlanId,
      foodId: dto.foodId,
      date: dto.date,
      mealType: dto.mealType,
      servingSizeId: dto.servingSizeId,
      servingQuantity: dto.servingQuantity,
      quantityGrams: dto.quantityGrams,
      notes: dto.notes,
      consumedAt: DateTime.now(),
      createdAt: DateTime.now(),
    );

    final insertedLog = await FoodIntakeLog.db.insertRow(session, log);

    // Fetch the log with the food relation included
    return await FoodIntakeLog.db.findById(
          session,
          insertedLog.id!,
          include: FoodIntakeLog.include(food: Food.include()),
        ) ??
        insertedLog;
  }

  Future<void> delete(Session session, int id) async {
    final userId = await EndpointUtils.getUserIdFromSession(session);

    final userProfile = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.userInfoId.equals(userId),
    );
    if (userProfile == null) throw Exception('User profile not found');

    final log = await FoodIntakeLog.db.findById(session, id);
    if (log == null) return;

    if (log.userId != userProfile.id) {
      throw Exception('Unauthorized');
    }

    await FoodIntakeLog.db.deleteRow(session, log);
  }

  Future<List<FoodIntakeLog>> getByDate(Session session, DateTime date) async {
    final userId = await EndpointUtils.getUserIdFromSession(session);

    final userProfile = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.userInfoId.equals(userId),
    );
    if (userProfile == null) return [];

    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));

    return await FoodIntakeLog.db.find(
      session,
      where: (t) =>
          t.userId.equals(userProfile.id!) & (t.date >= start) & (t.date < end),
      include: FoodIntakeLog.include(food: Food.include()),
    );
  }
}
