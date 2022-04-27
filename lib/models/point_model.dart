import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PointModel {
  String address;
  String comment;
  DateTime date;
  DateTime time;
  double latitude;
  double longitude;
  String photoUrl;

  PointModel({
    required this.address,
    required this.comment,
    required this.date,
    required this.time,
    required this.latitude,
    required this.longitude,
    required this.photoUrl,
  });

  DataGridRow getDataGridRow() {
    return DataGridRow(
      cells: <DataGridCell>[
        DataGridCell<String>(columnName: 'address', value: address),
        DataGridCell<String>(columnName: 'comment', value: comment),
        DataGridCell<DateTime>(columnName: 'date', value: date),
        DataGridCell<DateTime>(columnName: 'time', value: time),
        DataGridCell<double>(columnName: 'latitude', value: latitude),
        DataGridCell<double>(columnName: 'longitude', value: longitude),
        DataGridCell<String>(columnName: 'photoUrl', value: photoUrl),
      ],
    );
  }
}
