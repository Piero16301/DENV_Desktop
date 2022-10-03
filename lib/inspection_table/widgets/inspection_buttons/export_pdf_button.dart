import 'package:denv_desktop/app/app.dart';
import 'package:file_saver/file_saver.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ExportPdfButton extends StatelessWidget {
  const ExportPdfButton({
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
      onPressed: _exportDataGridToPdf,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Icon(
              FluentIcons.pdf,
              size: 25,
              color: isDarkThemeOn
                  ? const Color.fromARGB(255, 39, 39, 39)
                  : Colors.white,
            ),
            const SizedBox(width: 10),
            Text(
              'Exportar a PDF',
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

  Future<void> _exportDataGridToPdf() async {
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
    final data = await rootBundle.load(
      'assets/icon/denv_letters_pdf.png',
    );
    final document = dataGridKey.currentState!.exportToPdfDocument(
      cellExport: (DataGridCellPdfExportDetails details) {
        if (details.cellType == DataGridExportCellType.columnHeader) {
          details.pdfCell.value = replaceColumnNames[details.pdfCell.value];
        }
      },
      headerFooterExport: (DataGridPdfHeaderFooterExportDetails details) {
        final width = details.pdfPage.getClientSize().width;
        final header = PdfPageTemplateElement(Rect.fromLTWH(0, 0, width, 65));
        header.graphics.drawImage(
          PdfBitmap(
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          ),
          Rect.fromLTWH(width - 148, 0, 148, 60),
        );
        header.graphics.drawString(
          'Reporte de inspecciones',
          PdfStandardFont(PdfFontFamily.helvetica, 13,
              style: PdfFontStyle.bold),
          bounds: const Rect.fromLTWH(0, 25, 200, 60),
        );
        details.pdfDocumentTemplate.top = header;
        details.pdfPage.rotation = PdfPageRotateAngle.rotateAngle180;
      },
    );
    // document.pageSettings.rotate = PdfPageRotateAngle.rotateAngle90;
    final bytes = document.saveSync();
    final bytesExport = Uint8List.fromList(bytes);
    const mimeType = MimeType.PDF;
    final path = await FileSaver.instance.saveFile(
      'Reporte de inspecciones',
      bytesExport,
      'pdf',
      mimeType: mimeType,
    );
    document.dispose();
    debugPrint('File saved to $path');
    // debugPrint('File saved to $path');
  }
}
