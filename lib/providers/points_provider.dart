// import 'dart:convert';

// import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

import 'package:deteccion_zonas_dengue_desktop/models/models.dart';

class PointsProvider extends ChangeNotifier {
  final String _baseUrl = '40.124.84.39';
  List<PointModel> points = [];

  bool isLoading = false;
  bool isUpdating = false;

  PointsProvider() {
    loadPoints();
  }

  Future<List<PointModel>> loadPoints() async {
    isLoading = true;
    notifyListeners();

    // final url = Uri.http(_baseUrl, 'points');
    // final resp = await http.get(url);
    // final Map<String, dynamic>? decodedData = json.decode(resp.body);

    // if (decodedData == null) {
    //   isLoading = false;
    //   notifyListeners();
    //   return [];
    // }

    // if (decodedData['message'] != 'success') {
    //   isLoading = false;
    //   notifyListeners();
    //   return [];
    // }

    // final pointResponse = PointResponse.fromJson(decodedData);
    // points = pointResponse.data.data;

    await Future<void>.delayed(const Duration(seconds: 1));

    points = [
      PointModel(
        id: '1',
        address: 'Calle 1',
        comment: 'Comentario 1',
        date: DateTime.now(),
        time: TimeOfDay.now(),
        latitude: 1.2452,
        longitude: 3.4824,
        photoUrl: 'https://picsum.photos/200/300',
      ),
      PointModel(
        id: '2',
        address: 'Calle 2',
        comment: 'Comentario 2',
        date: DateTime.now(),
        time: TimeOfDay.now(),
        latitude: 1.2452,
        longitude: 3.4824,
        photoUrl: 'https://picsum.photos/200/300',
      ),
      PointModel(
        id: '3',
        address: 'Calle 3',
        comment: 'Comentario 3',
        date: DateTime.now(),
        time: TimeOfDay.now(),
        latitude: 1.2452,
        longitude: 3.4824,
        photoUrl: 'https://picsum.photos/200/300',
      ),
      PointModel(
        id: '4',
        address: 'Calle 4',
        comment: 'Comentario 4',
        date: DateTime.now(),
        time: TimeOfDay.now(),
        latitude: 1.2452,
        longitude: 3.4824,
        photoUrl: 'https://picsum.photos/200/300',
      ),
      PointModel(
        id: '5',
        address: 'Calle 5',
        comment: 'Comentario 5',
        date: DateTime.now(),
        time: TimeOfDay.now(),
        latitude: 1.2452,
        longitude: 3.4824,
        photoUrl: 'https://picsum.photos/200/300',
      ),
    ];

    isLoading = false;
    notifyListeners();

    // return pointResponse.data.data;
    return points;
  }

  Future<bool> updatePoint(PointModel point) async {
    isUpdating = true;
    notifyListeners();

    // final url = Uri.http(_baseUrl, 'point/${point.id}');
    // final resp = await http.put(url, body: json.encode(point.toJson()));
    // final Map<String, dynamic>? decodedData = json.decode(resp.body);

    // isUpdating = false;
    // notifyListeners();

    // if (decodedData == null) return false;
    // if (decodedData['message'] != 'success') return false;

    await Future<void>.delayed(const Duration(seconds: 1));

    return true;
  }
}
