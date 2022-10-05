import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:local_repository/local_repository.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required ThemeData appTheme,
    required Locale locale,
    required this.localRepository,
  }) : super(
          AppState(
            appTheme: appTheme,
            locale: locale,
          ),
        );

  final LocalRepository localRepository;

  Future<void> changeTheme(ThemeData appTheme) async {
    await localRepository.setDarkMode(
      isDarkMode: appTheme.brightness == Brightness.dark,
    );
    emit(state.copyWith(appTheme: appTheme));
  }

  Future<void> changeLocale(Locale locale) async {
    await localRepository.setLanguage(
      language: locale.languageCode,
    );
    emit(state.copyWith(locale: locale));
  }
}
