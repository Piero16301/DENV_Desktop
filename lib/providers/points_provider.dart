import 'dart:convert';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:http/http.dart' as http;

import 'package:deteccion_zonas_dengue_desktop/models/models.dart';

class PointsProvider extends ChangeNotifier {
  final String _baseUrl = '40.124.84.39';
  List<PointModel> points = [];
  
  bool isLoading = false;
  
  PointsProvider() {
    loadPoints();
  }
  
  Future<List<PointModel>> loadPoints() async {
    isLoading = true;
    notifyListeners();
    
    final url = Uri.http(_baseUrl, 'points');
    final resp = await http.get(url);
    
    final Map<String, dynamic>? decodedData = json.decode(resp.body);

    if (decodedData == null) return [];

    if (decodedData['message'] != 'success') return [];

    final pointResponse = PointResponse.fromJson(decodedData);

    points = pointResponse.data.data;

    isLoading = false;
    notifyListeners();

    return pointResponse.data.data;
  }
}