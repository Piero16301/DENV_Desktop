import 'package:inspection_api/inspection_api.dart';

/// {@template inspection_repository}
/// Repositorio de comunicación con backend de las inspecciones de viviendas
/// {@endtemplate}
class InspectionRepository {
  /// {@macro inspection_repository}
  const InspectionRepository({
    required IInspectionApiRemote apiRemote,
  }) : _apiRemote = apiRemote;

  final IInspectionApiRemote _apiRemote;

  /// Obtiene la lista de inspecciones de viviendas detalladas
  Future<List<HomeInspectionDetailed>> getHomeInspectionDetailed(
    int skip,
  ) async {
    return _apiRemote.getHomeInspectionDetailed(skip);
  }

  /// Obtiene la lista de inspecciones de viviendas resumidas
  Future<List<HomeInspectionSummarized>> getHomeInspectionSummarized(
    int skip,
  ) async {
    return _apiRemote.getHomeInspectionSummarized(skip);
  }

  /// Edita una inspección de vivienda
  Future<void> editHomeInspection(HomeInspectionDetailed homeInspection) async {
    return _apiRemote.editHomeInspection(homeInspection);
  }
}
