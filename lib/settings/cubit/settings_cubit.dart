import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(
          const SettingsState(
            isDarkMode: false,
            locale: 'es',
          ),
        );

  void changeTheme({required bool isDarkMode}) {
    emit(state.copyWith(isDarkMode: isDarkMode));
  }

  void changeLocale({required String locale}) {
    emit(
      state.copyWith(locale: locale),
    );
  }
}
