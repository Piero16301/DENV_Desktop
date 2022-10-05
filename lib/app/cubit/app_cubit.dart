import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluent_ui/fluent_ui.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  void changeTheme(ThemeData appTheme) {
    emit(state.copyWith(appTheme: appTheme));
  }

  void changeLocale(Locale locale) {
    emit(state.copyWith(locale: locale));
  }
}
