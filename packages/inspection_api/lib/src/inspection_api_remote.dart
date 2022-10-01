import 'package:inspection_api/inspection_api.dart';

/// {@template inspection_api}
/// API de comunicación con backend de las inspecciones de viviendas
/// {@endtemplate}
abstract class IInspectionApiRemote {
  /// Obtiene la lista de inspecciones de viviendas detalladas
  Future<List<HomeInspectionDetailed>> getHomeInspectionDetailed();

  /// Obtiene la lista de inspecciones de viviendas resumidas
  Future<List<HomeInspectionSummarized>> getHomeInspectionSummarized();

  /// Edita una inspección de vivienda
  Future<void> editHomeInspection(HomeInspectionDetailed homeInspection);
}