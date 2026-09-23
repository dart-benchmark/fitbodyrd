import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:record_result/record_result.dart';

abstract class DashboardRepository {
  FutureResult<WeeklySummaryDto> getWeeklySummary();
}
