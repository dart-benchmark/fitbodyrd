import 'package:fitbodyrd_server/src/errors/exceptions/generic_exceptions.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

abstract class EndpointUtils {
  static Future<int> getUserIdFromSession(Session session) async {
    final user = session.authenticated;

    if (user == null) {
      throw GenericExceptions.userNotAuthenticated();
    }

    return user.userId;
  }

  static bool isSameDay(DateTime date, DateTime endDate) {
    return date.year == endDate.year &&
        date.month == endDate.month &&
        date.day == endDate.day;
  }
}
