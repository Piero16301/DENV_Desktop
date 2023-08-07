// ignore_for_file: lines_longer_than_80_chars

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
  Future<List<HomeInspectionDetailed>> getHomeInspectionsDetailed(
    int skip,
  ) async {
    try {
      final response = await _httpClient.get<Map<String, dynamic>>(
        '/home-inspections-detailed/$skip',
        queryParameters: {
          'startDate': DateTime.now()
              .subtract(const Duration(days: 15))
              .toBackendString(),
          'endDate': DateTime.now().toBackendString(),
        },
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
    } on DioException catch (e) {
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
        queryParameters: {
          'startDate': DateTime.now()
              .subtract(const Duration(days: 15))
              .toBackendString(),
          'endDate': DateTime.now().toBackendString(),
        },
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
    } on DioException catch (e) {
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
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<HomeInspectionDetailed> getHomeInspectionDetails(
    String id,
  ) async {
    try {
      final response = await _httpClient.get<Map<String, dynamic>>(
        '/home-inspection/$id',
      );
      if (response.statusCode != 200) throw Exception();
      if (response.data == null) throw Exception();
      if (response.data?['data'] == null) throw Exception();
      final inspectionJson = response.data?['data'] as Map<String, dynamic>;
      final inspection = HomeInspectionDetailed.fromJson(inspectionJson);
      return inspection;
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}

extension on DateTime {
  String toBackendString() {
    return '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}T${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}.000000';
  }
}
