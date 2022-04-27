import 'package:fluent_ui/fluent_ui.dart';

import 'package:deteccion_zonas_dengue_desktop/theme/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData currentTheme;

  ThemeProvider({
    required bool isDarkMode,
  }): currentTheme = isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;

  setLightMode() {
    currentTheme = AppTheme.lightTheme;
    notifyListeners();
  }

  setDarkMode() {
    currentTheme = AppTheme.darkTheme;
    notifyListeners();
  }
}