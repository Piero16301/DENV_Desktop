part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.isDarkMode,
    required this.locale,
  });

  final bool isDarkMode;
  final String locale;

  @override
  List<Object> get props => [isDarkMode, locale];

  SettingsState copyWith({
    bool? isDarkMode,
    String? locale,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      locale: locale ?? this.locale,
    );
  }
}
