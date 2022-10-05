import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(
          const SettingsState(
            isLightThemeOn: true,
            isDarkThemeOn: false,
            isSpanishLocale: true,
            isEnglishLocale: false,
          ),
        );

  void changeTheme({required bool lightValue, required bool darkValue}) {
    emit(state.copyWith(isLightThemeOn: lightValue, isDarkThemeOn: darkValue));
  }

  void changeLocale({required bool spanishValue, required bool englishValue}) {
    emit(
      state.copyWith(
        isSpanishLocale: spanishValue,
        isEnglishLocale: englishValue,
      ),
    );
  }
}
