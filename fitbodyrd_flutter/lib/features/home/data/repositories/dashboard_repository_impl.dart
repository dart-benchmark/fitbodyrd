import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/home/domain/repositories/dashboard_repository.dart';
import 'package:record_result/record_result.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  DashboardRepositoryImpl({
    required this.client,
    required this.sessionManager,
  });

  final Client client;
  final SessionManager sessionManager;

  @override
  FutureResult<WeeklySummaryDto> getWeeklySummary() async {
    try {
      final result = await client.dashboard.getWeeklySummary();
      return right(result);
    } on AppException catch (e) {
      return left(ServerFailure(statusCode: e.errorCode, message: e.message));
    } on Exception catch (e) {
      return left(ServerFailure(statusCode: 500, message: e.toString()));
    }
  }
}
