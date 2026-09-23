import 'dart:async';

class RefreshHelper {
  final StreamController<void> _refreshUserController =
      StreamController<void>.broadcast();

  Future<void> dispose() async {
    await _refreshUserController.close();
  }

  Stream<void> get refreshUserStream => _refreshUserController.stream;

  void refreshUser() {
    _refreshUserController.add(null);
  }
}
