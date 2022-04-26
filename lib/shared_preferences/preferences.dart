import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _preferences;

  static bool _isDarkMode = false;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Theme local storage
  static bool get isDarkMode {
    return _preferences.getBool('isDarkMode') ?? _isDarkMode;
  }

  static set isDarkMode(bool value) {
    _isDarkMode = value;
    _preferences.setBool('isDarkMode', value);
  }
}