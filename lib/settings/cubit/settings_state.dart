part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.isLightThemeOn,
    required this.isDarkThemeOn,
  });

  final bool isLightThemeOn;
  final bool isDarkThemeOn;

  @override
  List<Object?> get props => [isLightThemeOn, isDarkThemeOn];

  SettingsState copyWith({
    bool? isLightThemeOn,
    bool? isDarkThemeOn,
  }) {
    return SettingsState(
      isLightThemeOn: isLightThemeOn ?? this.isLightThemeOn,
      isDarkThemeOn: isDarkThemeOn ?? this.isDarkThemeOn,
    );
  }
}
