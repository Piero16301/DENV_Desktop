import 'package:inspection_api/inspection_api.dart';

/// {@template inspection_api}
/// API de comunicación con backend de las inspecciones de viviendas
/// {@endtemplate}
abstract class IInspectionApiRemote {
  /// Obtiene la lista de inspecciones de viviendas detalladas
  Future<List<HomeInspectionDetailed>> getHomeInspectionsDetailed(
    int skip,
  );

  /// Obtiene la lista de inspecciones de viviendas resumidas
  Future<List<HomeInspectionSummarized>> getHomeInspectionSummarized(
    int skip,
  );

  /// Edita una inspección de vivienda
  Future<void> editHomeInspection(HomeInspectionDetailed homeInspection);

  /// Obtiene los detalles de una inspección de vivienda
  Future<HomeInspectionDetailed> getHomeInspectionDetails(
    String id,
  );
}
