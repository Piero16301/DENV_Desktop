part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.isLightThemeOn,
    required this.isDarkThemeOn,
    required this.isSpanishLocale,
    required this.isEnglishLocale,
  });

  final bool isLightThemeOn;
  final bool isDarkThemeOn;

  final bool isSpanishLocale;
  final bool isEnglishLocale;

  @override
  List<Object?> get props => [
        isLightThemeOn,
        isDarkThemeOn,
        isSpanishLocale,
        isEnglishLocale,
      ];

  SettingsState copyWith({
    bool? isLightThemeOn,
    bool? isDarkThemeOn,
    bool? isSpanishLocale,
    bool? isEnglishLocale,
  }) {
    return SettingsState(
      isLightThemeOn: isLightThemeOn ?? this.isLightThemeOn,
      isDarkThemeOn: isDarkThemeOn ?? this.isDarkThemeOn,
      isSpanishLocale: isSpanishLocale ?? this.isSpanishLocale,
      isEnglishLocale: isEnglishLocale ?? this.isEnglishLocale,
    );
  }
}
