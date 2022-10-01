import 'package:bloc/bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState(isDarkThemeOn: false));

  void changeTheme({required bool darkValue}) {
    emit(state.copyWith(isDarkThemeOn: darkValue));
  }
}
