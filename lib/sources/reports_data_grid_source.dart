import 'package:collection/collection.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:deteccion_zonas_dengue_desktop/shared_preferences/preferences.dart';
import 'package:deteccion_zonas_dengue_desktop/models/point_model.dart';
import 'package:deteccion_zonas_dengue_desktop/theme/app_theme.dart';
import 'package:deteccion_zonas_dengue_desktop/providers/theme_provider.dart';

class ReportsDataGridSource extends DataGridSource {
  late TextStyle textStyle;
  late List<DataGridRow> dataGridRows;
  List<PointModel> points = [];

  bool isDatePickerVisible = false;
  bool isTimePickerVisible = false;
  dynamic newCellValue;

  TextEditingController editingController = TextEditingController();

  ReportsDataGridSource() {
    textStyle = Preferences.isDarkMode
      ? const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Color.fromRGBO(255, 255, 255, 1))
      : const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Color.fromRGBO(0, 0, 0, 1));

    // points = [
    //   PointModel(address: 'Address example', comment: 'Comment example', date: DateTime.parse('2021-01-10T09:56:02.000+00:00'), time: TimeOfDay.fromDateTime(DateTime.parse('2021-01-10T09:56:02.000+00:00')), latitude: 1.21412, longitude: 4.28492, photoUrl: 'URL example'),
    //   PointModel(address: 'Address example', comment: 'Comment example', date: DateTime.parse('2021-01-10T09:56:02.000+00:00'), time: TimeOfDay.fromDateTime(DateTime.parse('2021-01-10T09:56:02.000+00:00')), latitude: 1.21412, longitude: 4.28492, photoUrl: 'URL example'),
    //   PointModel(address: 'Address example', comment: 'Comment example', date: DateTime.parse('2021-01-10T09:56:02.000+00:00'), time: TimeOfDay.fromDateTime(DateTime.parse('2021-01-10T09:56:02.000+00:00')), latitude: 1.21412, longitude: 4.28492, photoUrl: 'URL example'),
    //   PointModel(address: 'Address example', comment: 'Comment example', date: DateTime.parse('2021-01-10T09:56:02.000+00:00'), time: TimeOfDay.fromDateTime(DateTime.parse('2021-01-10T09:56:02.000+00:00')), latitude: 1.21412, longitude: 4.28492, photoUrl: 'URL example'),
    //   PointModel(address: 'Address example', comment: 'Comment example', date: DateTime.parse('2021-01-10T09:56:02.000+00:00'), time: TimeOfDay.fromDateTime(DateTime.parse('2021-01-10T09:56:02.000+00:00')), latitude: 1.21412, longitude: 4.28492, photoUrl: 'URL example'),
    // ];

    buildDataGridRows();
  }

  void buildDataGridRows() {
    dataGridRows = points.map<DataGridRow>((PointModel pointModel) => pointModel.getDataGridRow()).toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((DataGridCell dataGridCell) {
        String value = dataGridCell.value.toString();

        if (dataGridCell.columnName == 'date') {
          value = DateFormat('dd-MM-yyyy').format(dataGridCell.value);
        }
        else if (dataGridCell.columnName == 'time') {
          value = '${dataGridCell.value.hour.toString().padLeft(2, '0')}:${dataGridCell.value.minute.toString().padLeft(2, '0')}';
        }

        AlignmentGeometry alignmentType = (
          dataGridCell.columnName == 'date' ||
          dataGridCell.columnName == 'time' ||
          dataGridCell.columnName == 'latitude' ||
          dataGridCell.columnName == 'longitude'
        ) ? Alignment.center
          : Alignment.centerLeft;

        return Container(
          padding: const EdgeInsets.all(8.0),
          alignment: alignmentType,
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    final String displayText = dataGridRow.getCells().firstWhereOrNull((DataGridCell dataGridCell) =>
      dataGridCell.columnName == column.columnName)
        ?.value
        ?.toString() ??
        '';

    newCellValue = null;

    if (column.columnName == 'date') {
      return _buildDatePicker(displayText, submitCell);
    } else if (column.columnName == 'time') {
      return _buildTimePicker(displayText, submitCell);
    } else {
      return _buildTextFieldWidget(displayText, column, submitCell);
    }
  }

  @override
  void onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column) {
    final dynamic oldValue = dataGridRow.getCells().firstWhereOrNull((DataGridCell dataGridCell) =>
      dataGridCell.columnName == column.columnName)
      ?.value
      ?? '';

    final int dataRowIndex = dataGridRows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }

    if (column.columnName == 'address') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] = DataGridCell<String>(columnName: 'address', value: newCellValue);
      points[dataRowIndex].address = newCellValue.toString();
    } else if (column.columnName == 'comment') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] = DataGridCell<String>(columnName: 'comment', value: newCellValue);
      points[dataRowIndex].comment = newCellValue.toString();
    } else if (column.columnName == 'date') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] = DataGridCell<DateTime>(columnName: 'date', value: newCellValue);
      points[dataRowIndex].date = newCellValue as DateTime;
    } else if (column.columnName == 'time') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] = DataGridCell<TimeOfDay>(columnName: 'time', value: newCellValue);
      points[dataRowIndex].time = newCellValue as TimeOfDay;
    } else if (column.columnName == 'latitude') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] = DataGridCell<double>(columnName: 'latitude', value: newCellValue);
      points[dataRowIndex].latitude = newCellValue as double;
    } else if (column.columnName == 'longitude') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] = DataGridCell<double>(columnName: 'longitude', value: newCellValue);
      points[dataRowIndex].longitude = newCellValue as double;
    } else {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] = DataGridCell<String>(columnName: 'photoUrl', value: newCellValue);
      points[dataRowIndex].photoUrl = newCellValue.toString();
    }
  }

  RegExp _getRegExp(bool isNumericKeyboard, String columnName) {
    return isNumericKeyboard
      ? RegExp('[0-9.]')
      : RegExp('[a-zA-Z ]');
  }

  Widget _buildTextFieldWidget(String displayText, GridColumn column, CellSubmit submitCell) {
    final bool isNumericKeyboard = column.columnName == 'latitude'
        || column.columnName == 'longitude';

    final RegExp regExp = _getRegExp(isNumericKeyboard, column.columnName);

    final TextAlign textAlignType = (
      isNumericKeyboard
    ) ? TextAlign.center
      : TextAlign.left;

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: TextBox(
        autofocus: true,
        controller: editingController..text = displayText,
        textAlign: textAlignType,
        autocorrect: false,
        style: textStyle,
        inputFormatters: [
          FilteringTextInputFormatter.allow(regExp),
        ],
        keyboardType: isNumericKeyboard ? TextInputType.number : TextInputType.text,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            if (isNumericKeyboard) {
              newCellValue = double.parse(value);
            } else {
              newCellValue = value;
            }
          } else {
            newCellValue = null;
          }
        },
        onSubmitted: (String value) {
          submitCell();
        },
      ),
    );
  }

  Widget _buildDatePicker(String displayText, CellSubmit submitCell) {
    final DateTime selectedDate = DateTime.parse(displayText);
    final DateTime firstDate = DateTime.parse('2020-01-01');
    final DateTime lastDate = DateTime.parse('2025-12-31');

    displayText = DateFormat('dd-MM-yyyy').format(DateTime.parse(displayText));
    return Builder(
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Focus(
            autofocus: true,
            focusNode: FocusNode()
              ..addListener(() async {
                if (!isDatePickerVisible) {
                  isDatePickerVisible = true;
                  await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: firstDate,
                    lastDate: lastDate,
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: Provider.of<ThemeProvider>(context).currentTheme == AppTheme.lightTheme
                            ? const ColorScheme.light(primary: AppTheme.primary)
                            : const ColorScheme.dark(primary: AppTheme.primary)
                        ),
                        child: child!,
                      );
                    },
                    initialDatePickerMode: DatePickerMode.day,
                  ).then((DateTime? value) {
                    newCellValue = value;
                    submitCell();
                    isDatePickerVisible = false;
                  });
                }
              }),
            child: Text(
              displayText,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          ),
        );
      },
    );
  }

  Widget _buildTimePicker(String displayText, CellSubmit submitCell) {
    final int hour = int.parse(displayText.replaceRange(0, 10, '').replaceRange(2, 6, ''));
    final int minute = int.parse(displayText.replaceRange(0, 13, '').replaceRange(2, null, ''));
    final TimeOfDay selectedTime = TimeOfDay(hour: hour, minute: minute);

    displayText = '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';
    return Builder(
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Focus(
            autofocus: true,
            focusNode: FocusNode()
              ..addListener(() async {
                if (!isTimePickerVisible) {
                  isTimePickerVisible = true;
                  await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                            colorScheme: Provider.of<ThemeProvider>(context).currentTheme == AppTheme.lightTheme
                                ? const ColorScheme.light(primary: AppTheme.primary)
                                : const ColorScheme.dark(primary: AppTheme.primary)
                        ),
                        child: child!,
                      );
                    },
                    initialEntryMode: TimePickerEntryMode.input,
                  ).then((TimeOfDay? value) {
                    newCellValue = value;
                    submitCell();
                    isTimePickerVisible = false;
                  });
                }
              }),
            child: Text(
              displayText,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          ),
        );
      },
    );
  }
}
