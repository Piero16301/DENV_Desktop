import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

PointResponse pointResponseFromJson(String str) => PointResponse.fromJson(json.decode(str));
String pointResponseToJson(PointResponse data) => json.encode(data.toJson());

class PointResponse {
  PointResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  PointData data;

  factory PointResponse.fromJson(Map<String, dynamic> json) => PointResponse(
    status : json['status'],
    message: json['message'],
    data   : PointData.fromJson(json['data']),
  );

  Map<String, dynamic> toJson() => {
    'status' : status,
    'message': message,
    'data'   : data.toJson(),
  };
}

PointData pointDataFromJson(String str) => PointData.fromJson(json.decode(str));
String pointDataToJson(PointData data) => json.encode(data.toJson());

class PointData {
  PointData({
    required this.data,
  });

  List<PointModel> data;

  factory PointData.fromJson(Map<String, dynamic> json) => PointData(
    data: List<PointModel>.from(json['data'].map((x) => PointModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

PointModel pointModelFromJson(String str) => PointModel.fromJson(json.decode(str));
String pointModelToJson(PointModel data) => json.encode(data.toJson());

class PointModel {
  String id;
  String address;
  String comment;
  DateTime date;
  TimeOfDay time;
  double latitude;
  double longitude;
  String photoUrl;

  PointModel({
    this.id = '',
    required this.address,
    required this.comment,
    required this.date,
    required this.time,
    required this.latitude,
    required this.longitude,
    required this.photoUrl,
  });

  factory PointModel.fromJson(Map<String, dynamic> json) => PointModel(
    id : json['id'],
    address: json['address'],
    comment: json['comment'],
    date: DateTime.parse(json['datetime']),
    time: TimeOfDay.fromDateTime(DateTime.parse(json['datetime'])),
    latitude: json['latitude'].toDouble(),
    longitude: json['longitude'].toDouble(),
    photoUrl: json['photourl'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'address': address,
    'comment': comment,
    'datetime': _mergeDateTime().toIso8601String(),
    'latitude': latitude,
    'longitude': longitude,
    'photourl': photoUrl,
  };

  DateTime _mergeDateTime() {
    DateTime result = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    return result;
  }

  DataGridRow getDataGridRow() {
    return DataGridRow(
      cells: <DataGridCell>[
        DataGridCell<String>(columnName: 'address', value: address),
        DataGridCell<String>(columnName: 'comment', value: comment),
        DataGridCell<DateTime>(columnName: 'date', value: date),
        DataGridCell<TimeOfDay>(columnName: 'time', value: time),
        DataGridCell<double>(columnName: 'latitude', value: latitude),
        DataGridCell<double>(columnName: 'longitude', value: longitude),
        DataGridCell<String>(columnName: 'photoUrl', value: photoUrl),
      ],
    );
  }
}
