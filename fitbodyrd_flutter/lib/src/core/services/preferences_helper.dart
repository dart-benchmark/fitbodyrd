import 'package:shared_preferences/shared_preferences.dart';

class PreferencesConstants {
  const PreferencesConstants._();

  static const String locale = 'locale';

  static const values = {
    locale,
  };
}

class PreferencesHelper {
  PreferencesHelper({required SharedPreferencesWithCache sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  final SharedPreferencesWithCache _sharedPreferences;

  String? getLocale() {
    return _sharedPreferences.getString(PreferencesConstants.locale);
  }

  Future<void> setLocale(String locale) async {
    await _sharedPreferences.setString(PreferencesConstants.locale, locale);
  }
}
