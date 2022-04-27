import 'package:fluent_ui/fluent_ui.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../shared_preferences/preferences.dart';

class ReportsDataGridSource extends DataGridSource {
  late TextStyle textStyle;

  ReportsDataGridSource() {
    textStyle = Preferences.isDarkMode
      ? const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Colors.black)
      : const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Color.fromRGBO(255, 255, 255, 1));
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((DataGridCell dataGridCell) {
        String value = dataGridCell.value.toString();

        if (dataGridCell.columnName == 'Fecha y Hora') {
          value = DateFormat('Hms dd-MM-yyyy').format(dataGridCell.value);
        }

        return Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    );
  }
}
