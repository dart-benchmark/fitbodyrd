import 'dart:io';

import 'package:envied/envied.dart';

part 'app_env.g.dart';

@Envied(
  path: '.env',
  obfuscate: true,
)
abstract class AppEnv {
  @EnviedField(varName: 'ENVIRONMENT')
  static final String environment = _AppEnv.environment;

  @EnviedField(varName: 'SERVERPOD_URL')
  static final String serverpodUrl = _AppEnv.serverpodUrl;

  @EnviedField(varName: 'GOOGLE_REDIRECT_URL')
  static final String googleRedirectUrl = _AppEnv.googleRedirectUrl;

  @EnviedField(varName: 'GOOGLE_SERVER_CLIENT_ID')
  static final String googleServerClientId = _AppEnv.googleServerClientId;

  @EnviedField(varName: 'GOOGLE_CLIENT_ID_ANDROID')
  static final String googleClientIdAndroid = _AppEnv.googleClientIdAndroid;

  @EnviedField(varName: 'GOOGLE_CLIENT_ID_IOS')
  static final String googleClientIdIOS = _AppEnv.googleClientIdIOS;

  static String get googleClientId {
    if (Platform.isAndroid) {
      return googleClientIdAndroid;
    } else {
      return googleClientIdIOS;
    }
  }
}
