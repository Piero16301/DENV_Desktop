/// {@template local_api}
/// API de almacenamiento local de datos globales
/// {@endtemplate}
abstract class ILocalApiRemote {
  /// Retorna si está activado el modo oscuro
  bool isDarkMode();

  /// Activa o desactiva el modo oscuro
  Future<void> setDarkMode({bool isDarkMode});

  /// Retorna el idioma actual
  String getLanguage();

  /// Establece el idioma actual
  Future<void> setLanguage({String language});
}
