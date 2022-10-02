import 'package:fluent_ui/fluent_ui.dart';
import 'package:inspection_api/inspection_api.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class InspectionTableWidget extends StatelessWidget {
  const InspectionTableWidget({
    super.key,
    required this.homeInspections,
  });

  final List<HomeInspectionDetailed> homeInspections;

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: InspectionTableDatagrid(homeInspections: homeInspections),
      columnWidthMode: ColumnWidthMode.fill,
      columns: [
        GridColumn(
          columnName: 'id',
          label: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            child: const Text('ID'),
          ),
        ),
        GridColumn(
          columnName: 'inspectionDate',
          label: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: const Text('Inspection Date'),
          ),
        ),
        GridColumn(
          columnName: 'inspectionDNI',
          label: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: const Text('Inspection DNI'),
          ),
        ),
        GridColumn(
          columnName: 'inspectionLatitude',
          label: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: const Text('Inspection Latitude'),
          ),
        ),
        GridColumn(
          columnName: 'inspectionLongitude',
          label: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: const Text('Inspection Longitude'),
          ),
        ),
      ],
    );
  }
}

class InspectionTableDatagrid extends DataGridSource {
  InspectionTableDatagrid({
    required List<HomeInspectionDetailed> homeInspections,
  }) {
    _homeInspections = homeInspections
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell(columnName: 'id', value: e.id),
              DataGridCell(columnName: 'inspectionDate', value: e.dateTime),
              DataGridCell(columnName: 'inspectionDNI', value: e.dni),
              DataGridCell(columnName: 'inspectionLatitude', value: e.latitude),
              DataGridCell(
                  columnName: 'inspectionLongitude', value: e.longitude),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _homeInspections = [];

  @override
  List<DataGridRow> get rows => _homeInspections;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          padding: const EdgeInsets.all(16),
          alignment: (dataGridCell.columnName == 'id' ||
                  dataGridCell.columnName == 'dni')
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Text(dataGridCell.value.toString()),
        );
      }).toList(),
    );
  }
}
