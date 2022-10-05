part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    required this.appTheme,
    required this.locale,
  });

  final ThemeData appTheme;
  final Locale locale;

  @override
  List<Object?> get props => [appTheme, locale];

  AppState copyWith({ThemeData? appTheme, Locale? locale}) {
    return AppState(
      appTheme: appTheme ?? this.appTheme,
      locale: locale ?? this.locale,
    );
  }
}
