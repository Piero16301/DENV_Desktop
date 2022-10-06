import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_repository/local_repository.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required bool isDarkMode,
    required String locale,
    required this.localRepository,
  }) : super(
          AppState(
            isDarkMode: isDarkMode,
            locale: locale,
          ),
        );

  final LocalRepository localRepository;

  Future<void> changeTheme({required bool isDarkMode}) async {
    await localRepository.setDarkMode(
      isDarkMode: isDarkMode,
    );
    emit(state.copyWith(isDarkMode: isDarkMode));
  }

  Future<void> changeLocale(String locale) async {
    await localRepository.setLanguage(
      language: locale,
    );
    emit(state.copyWith(locale: locale));
  }
}
