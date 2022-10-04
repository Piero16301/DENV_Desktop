import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_saver/file_saver.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:inspection_api/inspection_api.dart';
import 'package:inspection_repository/inspection_repository.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

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

  void setDataGridKey(GlobalKey<SfDataGridState> dataGridKey) {
    if (!state.isKeyUpdated) {
      emit(state.copyWith(dataGridKey: dataGridKey));
    }
  }

  void changeKeyUpdated({required bool isKeyUpdated}) {
    emit(state.copyWith(isKeyUpdated: isKeyUpdated));
  }

  Future<void> exportHomeInspectionsExcel(
    GlobalKey<SfDataGridState> dataGridKey,
  ) async {
    emit(state.copyWith(exportStatus: InspectionExportStatus.loading));
    try {
      final replaceColumnNames = {
        'address': 'Dirección',
        'numberInhabitants': 'N° de habitantes',
        'inspectedHome': 'Vivienda inspecionada',
        'reluctantDwelling': 'Vivienda renuente',
        'closedHome': 'Vivienda cerrada',
        'uninhabitedHouse': 'Vivienda deshabitada',
        'housingSpotlights': 'Vivienda focos',
        'treatedHousing': 'Vivienda tratada con abte',
        'elevatedTankI': 'I',
        'elevatedTankP': 'P',
        'elevatedTankT': 'T',
        'lowTankI': 'I',
        'lowTankP': 'P',
        'lowTankT': 'T',
        'cylinderBarrelI': 'I',
        'cylinderBarrelP': 'P',
        'cylinderBarrelT': 'T',
        'bucketTubI': 'I',
        'bucketTubP': 'P',
        'bucketTubT': 'T',
        'tireI': 'I',
        'tireP': 'P',
        'tireT': 'T',
        'flowerI': 'I',
        'flowerP': 'P',
        'flowerT': 'T',
        'uselessI': 'I',
        'uselessP': 'P',
        'uselessT': 'T',
        'othersI': 'I',
        'othersP': 'P',
        'othersT': 'T',
        'inspectedContainers': 'Recipientes inspeccionados',
        'containersSpotlights': 'Recipientes focos',
        'treatedContainers': 'Recipientes tratados',
        'destroyedContainers': 'Recipientes destruidos',
        'larvae': 'Larvas',
        'pupae': 'Pupas',
        'adult': 'Adulto',
        'larvicide': 'Larvicida',
      };
      final workbook = dataGridKey.currentState!.exportToExcelWorkbook(
        cellExport: (DataGridCellExcelExportDetails details) {
          if (details.cellType == DataGridExportCellType.columnHeader) {
            details.excelRange.cellStyle.hAlign = HAlignType.center;
            details.excelRange.text =
                replaceColumnNames[details.excelRange.text];
          }
          details.excelRange.rowHeight = 14.5;
        },
      );
      final sheets = workbook.saveAsStream();
      workbook.dispose();
      final data = Uint8List.fromList(sheets);
      const mimeType = MimeType.MICROSOFTEXCEL;
      final path = await FileSaver.instance.saveFile(
        'Reporte de inspecciones',
        data,
        'xlsx',
        mimeType: mimeType,
      );
      await Future<void>.delayed(const Duration(seconds: 1));
      debugPrint('File saved to $path');
      emit(state.copyWith(exportStatus: InspectionExportStatus.success));
    } catch (e) {
      emit(state.copyWith(exportStatus: InspectionExportStatus.failure));
    }
  }

  void resetExportStatus() {
    emit(state.copyWith(exportStatus: InspectionExportStatus.initial));
  }
}
