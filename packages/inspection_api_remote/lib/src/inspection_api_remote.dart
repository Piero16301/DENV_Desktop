import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:inspection_api/inspection_api.dart';

/// {@template inspection_api_remote}
/// API de comunicación remota con backend de las inspecciones de viviendas
/// {@endtemplate}
class InspectionApiRemote implements IInspectionApiRemote {
  /// {@macro inspection_api_remote}
  const InspectionApiRemote({
    required Dio httpClient,
  }) : _httpClient = httpClient;

  final Dio _httpClient;

  @override
  Future<List<HomeInspectionDetailed>> getHomeInspectionDetailed(
    int skip,
  ) async {
    try {
      final response = await _httpClient.get<Map<String, dynamic>>(
        '/home-inspections-detailed/$skip',
      );
      if (response.statusCode != 200) throw Exception();
      if (response.data == null) throw Exception();
      if (response.data?['data'] == null) return [];
      final inspectionsJson = response.data?['data'] as List<dynamic>;
      final inspections = inspectionsJson
          .map(
            (json) =>
                HomeInspectionDetailed.fromJson(json as Map<String, dynamic>),
          )
          .toList();
      return inspections;
    } on DioError catch (e) {
      debugPrint('debug: DioError: ${e.message}');
      throw Exception(e);
    }
  }

  @override
  Future<List<HomeInspectionSummarized>> getHomeInspectionSummarized(
    int skip,
  ) async {
    try {
      final response = await _httpClient.get<Map<String, dynamic>>(
        '/home-inspections-summarized/$skip',
      );
      if (response.statusCode != 200) throw Exception();
      if (response.data == null) throw Exception();
      if (response.data?['data'] == null) return [];
      final inspectionsJson = response.data?['data'] as List<dynamic>;
      final inspections = inspectionsJson
          .map(
            (json) =>
                HomeInspectionSummarized.fromJson(json as Map<String, dynamic>),
          )
          .toList();
      return inspections;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> editHomeInspection(HomeInspectionDetailed homeInspection) async {
    try {
      final response = await _httpClient.put<Map<String, dynamic>>(
        '/home-inspection/${homeInspection.id}',
        data: homeInspection.toJson(),
      );
      if (response.statusCode != 200) throw Exception();
    } on DioError catch (e) {
      throw Exception(e);
    }
  }
}
