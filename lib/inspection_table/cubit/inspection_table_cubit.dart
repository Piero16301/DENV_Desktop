import 'package:bloc/bloc.dart';
import 'package:denv_desktop/l10n/l10n.dart';
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

  Future<void> exportHomeInspectionsExcel({
    required GlobalKey<SfDataGridState> dataGridKey,
    required BuildContext context,
  }) async {
    emit(state.copyWith(exportStatus: InspectionExportStatus.loading));
    try {
      final l10n = context.l10n;
      final replaceColumnNames = {
        'address': l10n.inspectionTableColumnAddress,
        'numberInhabitants': l10n.inspectionTableColumnNumberInhabitants,
        'inspectedHome': l10n.inspectionTableColumnInspectedHome,
        'reluctantDwelling': l10n.inspectionTableColumnReluctantDwelling,
        'closedHome': l10n.inspectionTableColumnClosedHome,
        'uninhabitedHouse': l10n.inspectionTableColumnUninhabitedHouse,
        'housingSpotlights': l10n.inspectionTableColumnHousingSpotlights,
        'treatedHousing': l10n.inspectionTableColumnTreatedHousing,
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
        'inspectedContainers': l10n.inspectionTableColumnInspectedContainers,
        'containersSpotlights': l10n.inspectionTableColumnContainersSpotlights,
        'treatedContainers': l10n.inspectionTableColumnTreatedContainers,
        'destroyedContainers': l10n.inspectionTableColumnDestroyedContainers,
        'larvae': l10n.inspectionTableColumnLarvae,
        'pupae': l10n.inspectionTableColumnPupae,
        'adult': l10n.inspectionTableColumnAdult,
        'larvicide': l10n.inspectionTableColumnLarvicide,
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
      const mimeType = MimeType.microsoftExcel;
      final path = await FileSaver.instance.saveFile(
        name: 'Reporte de inspecciones',
        bytes: data,
        ext: 'xlsx',
        mimeType: mimeType,
      );
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
