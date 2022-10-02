import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inspection_api/inspection_api.dart';
import 'package:inspection_repository/inspection_repository.dart';

part 'inspection_table_state.dart';

class InspectionTableCubit extends Cubit<InspectionTableState> {
  InspectionTableCubit(this._inspectionRepository)
      : super(const InspectionTableState());

  final InspectionRepository _inspectionRepository;

  Future<void> getHomeInspections() async {
    emit(state.copyWith(status: InspectionTableStatus.loading));
    try {
      final homeInspections =
          await _inspectionRepository.getHomeInspectionDetailed();
      emit(
        state.copyWith(
          status: InspectionTableStatus.success,
          homeInspections: homeInspections,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: InspectionTableStatus.failure));
    }
  }
}
