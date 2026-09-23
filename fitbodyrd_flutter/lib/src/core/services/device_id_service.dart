import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class DeviceIdService {
  DeviceIdService({required FlutterSecureStorage storage}) : _storage = storage;

  final FlutterSecureStorage _storage;

  static const String _deviceIdKey = 'device_id';

  /// Retrieves or generates a persistent unique device ID
  Future<String> getDeviceId() async {
    final deviceId = await _storage.read(key: _deviceIdKey);

    if (deviceId != null) {
      return deviceId;
    }

    final newDeviceId = const Uuid().v1();

    await _storage.write(key: _deviceIdKey, value: newDeviceId);

    return newDeviceId;
  }
}
