part of 'app_cubit.dart';

class AppState {
  AppState({required this.isDarkThemeOn}) {
    if (isDarkThemeOn) {
      appTheme = ThemeData.dark();
    } else {
      appTheme = ThemeData.light();
    }
  }

  final bool isDarkThemeOn;
  ThemeData? appTheme;

  AppState copyWith({bool? isDarkThemeOn}) {
    return AppState(
      isDarkThemeOn: isDarkThemeOn ?? this.isDarkThemeOn,
    );
  }
}
