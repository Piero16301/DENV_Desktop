part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    required this.isDarkMode,
    required this.locale,
  });

  final bool isDarkMode;
  final String locale;

  @override
  List<Object?> get props => [isDarkMode, locale];

  AppState copyWith({
    bool? isDarkMode,
    String? locale,
  }) {
    return AppState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      locale: locale ?? this.locale,
    );
  }
}
