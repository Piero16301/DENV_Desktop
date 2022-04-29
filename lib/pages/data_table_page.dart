import 'package:deteccion_zonas_dengue_desktop/theme/app_theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:deteccion_zonas_dengue_desktop/providers/providers.dart';
import 'package:deteccion_zonas_dengue_desktop/sources/reports_data_grid_source.dart';

class DataTablePage extends StatefulWidget {
  const DataTablePage({Key? key}) : super(key: key);

  @override
  State<DataTablePage> createState() => _DataTablePageState();
}

class _DataTablePageState extends State<DataTablePage> {
  late ReportsDataGridSource reportsDataGridSource;

  // To run buildDataGridRows() only once
  bool _isUpdated = false;

  final double _dataPageHeight = 60;
  int _rowsPerPage = 10;

  @override
  void initState() {
    super.initState();
    reportsDataGridSource = ReportsDataGridSource();
  }

  @override
  Widget build(BuildContext context) {
    final pointsProvider = Provider.of<PointsProvider>(context);

    if (pointsProvider.isLoading) {
      return const Center(
        child: ProgressRing(activeColor: AppTheme.primary),
      );
    }

    if (!pointsProvider.isLoading && !_isUpdated) {
      reportsDataGridSource.points = pointsProvider.points;
      reportsDataGridSource.buildDataGridRows();
      _isUpdated = true;
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraint) {
        return Column(
          children: [
            SizedBox(
              height: constraint.maxHeight - _dataPageHeight,
              width: constraint.maxWidth,
              child: _buildDataGrid(),
            ),
            SizedBox(
              height: _dataPageHeight,
              child: Align(
                alignment: Alignment.center,
                child: _buildDataPager(),
              ),
            ),
          ],
        );
      },
    );
  }

  SfDataPagerTheme _buildDataPager() {
    return SfDataPagerTheme(
      data: SfDataPagerThemeData(
        selectedItemColor: AppTheme.primary,
      ),
      child: SfDataPager(
        delegate: reportsDataGridSource,
        availableRowsPerPage: const [10, 20, 30],
        pageCount: reportsDataGridSource.points.length / _rowsPerPage,
        onRowsPerPageChanged: (int? rowsPerPage) {
          setState(() {
            _rowsPerPage = rowsPerPage!;
          });
        },
        direction: Axis.horizontal,
      ),
    );
  }

  SfDataGrid _buildDataGrid() {
    return SfDataGrid(
    source: reportsDataGridSource,
    allowEditing: true,
    navigationMode: GridNavigationMode.cell,
    selectionMode: SelectionMode.single,
    editingGestureType: EditingGestureType.doubleTap,
    columnWidthMode: ColumnWidthMode.fill,
    allowSorting: true,
    gridLinesVisibility: GridLinesVisibility.both,
    rowsPerPage: _rowsPerPage,
    rowHeight: 60,
    columns: [
      _buildGridColumn('address', 'Dirección'),
      _buildGridColumn('comment', 'Comentario'),
      _buildGridColumn('date', 'Fecha'),
      _buildGridColumn('time', 'Hora'),
      _buildGridColumn('latitude', 'Latitud'),
      _buildGridColumn('longitude', 'Longitud'),
      _buildGridColumn('photoUrl', 'Foto URL'),
    ],
  );
  }

  GridColumn _buildGridColumn(String columnName, String displayName) {
    return GridColumn(
        columnName: columnName,
        width: double.nan,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(
            displayName,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      allowSorting: (columnName == 'time') ? false : true,
      );
  }
}
