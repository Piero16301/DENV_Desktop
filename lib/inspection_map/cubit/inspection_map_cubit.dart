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
          await _inspectionRepository.getHomeInspectionSummarized(0);
      final centerLatitude = homeInspections
              .map((e) => e.latitude)
              .reduce((value, element) => value + element) /
          homeInspections.length;
      final centerLongitude = homeInspections
              .map((e) => e.longitude)
              .reduce((value, element) => value + element) /
          homeInspections.length;
      final mapType = isDarkMode ? 'CanvasDark' : 'CanvasLight';
      final bingUrlTemplate = await getBingUrlTemplate(
        'https://dev.virtualearth.net/REST/V1/Imagery/Metadata/$mapType?output=json&uriScheme=https&include=ImageryProviders&key=gKFcszH8QtTWZm2GzcK5~yzuCkObRWRXGBYVgmFKSmg~Ap0qOUWHnFqU8zP5N2483-pbxSPK0mVvvqeYUi2t5EDf9Ao_QZEsh7eItuQ-fLdh',
      );
      emit(
        state.copyWith(
          status: InspectionMapStatus.success,
          homeInspections: homeInspections,
          centerLatitude: centerLatitude,
          centerLongitude: centerLongitude,
          bingUrlTemplate: bingUrlTemplate,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: InspectionMapStatus.failure));
    }
  }

  Future<List<HomeInspectionSummarized>> updateHomeInspections() async {
    try {
      final bufferHomeInspections =
          await _inspectionRepository.getHomeInspectionSummarized(
        state.homeInspections.length,
      );
      emit(
        state.copyWith(
          bufferHomeInspections: bufferHomeInspections,
        ),
      );
      return bufferHomeInspections;
    } catch (e) {
      return [];
    }
  }

  void mergeHomeInspections() {
    emit(
      state.copyWith(
        bufferHomeInspections: [],
      ),
    );
  }
}
