import 'package:local_api/local_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template local_api_remote}
/// API de almacenamiento local de datos globales
/// {@endtemplate}
class LocalApiRemote implements ILocalApiRemote {
  /// {@macro local_api_remote}
  LocalApiRemote({
    required SharedPreferences preferences,
  }) : _preferences = preferences {
    _init();
  }

  final SharedPreferences _preferences;

  void _init() {
    if (_preferences.getBool('isDarkMode') == null) {
      _preferences.setBool('isDarkMode', false);
    }
    if (_preferences.getString('language') == null) {
      _preferences.setString('language', 'es');
    }
  }

  @override
  bool isDarkMode() {
    return _preferences.getBool('isDarkMode')!;
  }

  @override
  Future<void> setDarkMode({bool isDarkMode = false}) async {
    await _preferences.setBool('isDarkMode', isDarkMode);
  }

  @override
  String getLanguage() {
    return _preferences.getString('language')!;
  }

  @override
  Future<void> setLanguage({String language = 'es'}) async {
    await _preferences.setString('language', language);
  }
}
