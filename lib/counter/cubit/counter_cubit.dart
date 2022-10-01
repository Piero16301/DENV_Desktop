import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void changePane(int paneIndex) => emit(paneIndex);
}
