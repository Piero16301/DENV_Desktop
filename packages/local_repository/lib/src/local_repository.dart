import 'package:local_api/local_api.dart';

/// {@template local_repository}
/// API de almacenamiento local de datos globales
/// {@endtemplate}
class LocalRepository {
  /// {@macro local_repository}
  const LocalRepository({
    required ILocalApiRemote apiRemote,
  }) : _apiRemote = apiRemote;

  final ILocalApiRemote _apiRemote;

  /// Retorna si está activado el modo oscuro
  bool isDarkMode() {
    return _apiRemote.isDarkMode();
  }

  /// Activa o desactiva el modo oscuro
  Future<void> setDarkMode({bool isDarkMode = false}) async {
    await _apiRemote.setDarkMode(isDarkMode: isDarkMode);
  }

  /// Retorna el idioma actual
  String getLanguage() {
    return _apiRemote.getLanguage();
  }

  /// Establece el idioma actual
  Future<void> setLanguage({String language = 'es'}) async {
    await _apiRemote.setLanguage(language: language);
  }
}
