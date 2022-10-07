import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inspection_api/inspection_api.dart';
import 'package:inspection_repository/inspection_repository.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

part 'inspection_map_state.dart';

class InspectionMapCubit extends Cubit<InspectionMapState> {
  InspectionMapCubit(this._inspectionRepository)
      : super(const InspectionMapState());

  final InspectionRepository _inspectionRepository;

  Future<void> getHomeInspections({required bool isDarkMode}) async {
    emit(state.copyWith(status: InspectionMapStatus.loading));
    try {
      final homeInspections =
          await _inspectionRepository.getHomeInspectionSummarized();
      final mapType = isDarkMode ? 'CanvasDark' : 'CanvasLight';
      final bingUrlTemplate = await getBingUrlTemplate(
          'https://dev.virtualearth.net/REST/V1/Imagery/Metadata/$mapType?output=json&uriScheme=https&include=ImageryProviders&key=gKFcszH8QtTWZm2GzcK5~yzuCkObRWRXGBYVgmFKSmg~Ap0qOUWHnFqU8zP5N2483-pbxSPK0mVvvqeYUi2t5EDf9Ao_QZEsh7eItuQ-fLdh');
      emit(
        state.copyWith(
          status: InspectionMapStatus.success,
          homeInspections: homeInspections,
          isFirstLoad: false,
          bingUrlTemplate: bingUrlTemplate,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: InspectionMapStatus.failure));
    }
  }
}
