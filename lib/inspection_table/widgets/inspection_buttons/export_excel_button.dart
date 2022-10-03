import 'package:denv_desktop/app/app.dart';
import 'package:file_saver/file_saver.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row, Border;

class ExportExcelButton extends StatelessWidget {
  const ExportExcelButton({
    super.key,
    required this.dataGridKey,
  });

  final GlobalKey<SfDataGridState> dataGridKey;

  @override
  Widget build(BuildContext context) {
    final isDarkThemeOn = context.select(
      (AppCubit cubit) => cubit.state.isDarkThemeOn,
    );

    return FilledButton(
      onPressed: _exportDataGridToExcel,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Icon(
              FluentIcons.excel_logo,
              size: 25,
              color: isDarkThemeOn
                  ? const Color.fromARGB(255, 39, 39, 39)
                  : Colors.white,
            ),
            const SizedBox(width: 10),
            Text(
              'Exportar a Excel',
              style: FluentTheme.of(context).typography.bodyStrong!.copyWith(
                    color: isDarkThemeOn
                        ? const Color.fromARGB(255, 39, 39, 39)
                        : Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exportDataGridToExcel() async {
    final workbook = dataGridKey.currentState!.exportToExcelWorkbook(
      cellExport: (DataGridCellExcelExportDetails details) {
        if (details.cellType == DataGridExportCellType.columnHeader) {
          details.excelRange.cellStyle.hAlign = HAlignType.center;
          details.excelRange.rowHeight = 20;
        }
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
    debugPrint('File saved to $path');
  }
}
