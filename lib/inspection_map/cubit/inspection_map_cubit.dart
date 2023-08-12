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
        'https://dev.virtualearth.net/REST/V1/Imagery/Metadata/$mapType?output=json&uriScheme=https&include=ImageryProviders&key=gKFcszH8QtTWZm2GzcK5~yzuCkObRWRXGBYVgmFKSmg~Ap0qOUWHnFqU8zP5N2483-pbxSPK0mVvvqeYUi2t5EDf9Ao_QZEsh7eItuQ-fLdh',
      );
      if (homeInspections.isEmpty) {
        emit(
          state.copyWith(
            status: InspectionMapStatus.success,
            homeInspections: homeInspections,
            lastUpdated: DateTime.now(),
            centerLatitude: 0,
            centerLongitude: 0,
            bingUrlTemplate: bingUrlTemplate,
          ),
        );
      } else {
        final centerLatitude = homeInspections
                .map((e) => e.latitude)
                .reduce((value, element) => value + element) /
            homeInspections.length;
        final centerLongitude = homeInspections
                .map((e) => e.longitude)
                .reduce((value, element) => value + element) /
            homeInspections.length;
        emit(
          state.copyWith(
            status: InspectionMapStatus.success,
            homeInspections: homeInspections,
            lastUpdated: DateTime.now(),
            centerLatitude: centerLatitude,
            centerLongitude: centerLongitude,
            bingUrlTemplate: bingUrlTemplate,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: InspectionMapStatus.failure));
    }
  }

  Future<void> changeDaysBeforeToDisplay(String days) async {
    emit(
      state.copyWith(
        daysBeforeToDisplay: int.tryParse(days) ?? 0,
      ),
    );
  }

  Future<List<HomeInspectionSummarized>> updateHomeInspections() async {
    try {
      final bufferHomeInspections =
          await _inspectionRepository.getHomeInspectionSummarized();
      emit(
        state.copyWith(
          bufferHomeInspections: bufferHomeInspections,
          lastUpdated: DateTime.now(),
        ),
      );
      return bufferHomeInspections;
    } catch (e) {
      return [];
    }
  }

  void cleanBufferHomeInspections() {
    emit(
      state.copyWith(
        bufferHomeInspections: [],
      ),
    );
  }

  MapLatLng getCenterLatLng() {
    final centerLatitude = state.homeInspections
            .map((e) => e.latitude)
            .reduce((value, element) => value + element) /
        state.homeInspections.length;
    final centerLongitude = state.homeInspections
            .map((e) => e.longitude)
            .reduce((value, element) => value + element) /
        state.homeInspections.length;
    return MapLatLng(centerLatitude, centerLongitude);
  }

  Future<void> getSelectedInspectionDetails({
    required String inspectionId,
  }) async {
    emit(
      state.copyWith(
        selectedInspectionStatus: SelectedInspectionStatus.loading,
      ),
    );
    try {
      final inspectionDetails =
          await _inspectionRepository.getHomeInspectionDetails(inspectionId);
      emit(
        state.copyWith(
          selectedInspectionStatus: SelectedInspectionStatus.success,
          selectedInspection: inspectionDetails,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          selectedInspectionStatus: SelectedInspectionStatus.failure,
        ),
      );
    }
  }

  void closeSelectedInspection() {
    emit(
      state.copyWith(
        selectedInspectionStatus: SelectedInspectionStatus.initial,
      ),
    );
  }
}
