import 'package:deteccion_zonas_dengue_desktop/sources/reports_data_grid_source.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DataTablePage extends StatefulWidget {
  const DataTablePage({Key? key}) : super(key: key);

  @override
  State<DataTablePage> createState() => _DataTablePageState();
}

class _DataTablePageState extends State<DataTablePage> {
  late ReportsDataGridSource reportsDataGridSource;

  @override
  void initState() {
    super.initState();
    reportsDataGridSource = ReportsDataGridSource();
  }

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: reportsDataGridSource,
      allowEditing: true,
      navigationMode: GridNavigationMode.cell,
      selectionMode: SelectionMode.single,
      editingGestureType: EditingGestureType.doubleTap,
      columnWidthMode: ColumnWidthMode.fill,
      columns: [
        buildGridColumn('address', 'Dirección'),
        buildGridColumn('comment', 'Comentario'),
        buildGridColumn('date', 'Fecha'),
        buildGridColumn('time', 'Hora'),
        buildGridColumn('latitude', 'Latitud'),
        buildGridColumn('longitude', 'Longitud'),
        buildGridColumn('photoUrl', 'Foto URL'),
      ],
    );
  }

  GridColumn buildGridColumn(String columnName, String displayName) {
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
      );
  }
}
