import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(
          const SettingsState(
            isLightThemeOn: true,
            isDarkThemeOn: false,
          ),
        );

  void changeTheme({required bool lightValue, required bool darkValue}) {
    emit(state.copyWith(isLightThemeOn: lightValue, isDarkThemeOn: darkValue));
  }
}
