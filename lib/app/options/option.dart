import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static late SharedPreferences _prefs;

  // Valores por defecto
  static const String _defaultIdioma = "English";
  static const String _defaultTema = "Dark";
  static const String _defaultVersion = "gratuita";

  // Claves para SharedPreferences
  static const String _keyIdioma = "idioma";
  static const String _keyTema = "tema";
  static const String _keyVersion = "version";

  /// Inicializa SharedPreferences y asigna valores por defecto si no existen
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();

    if (!_prefs.containsKey(_keyIdioma)) {
      await _prefs.setString(_keyIdioma, _defaultIdioma);
    }
    if (!_prefs.containsKey(_keyTema)) {
      await _prefs.setString(_keyTema, _defaultTema);
    }
    if (!_prefs.containsKey(_keyVersion)) {
      await _prefs.setString(_keyVersion, _defaultVersion);
    }
  }

  /// Getters
  static String get idioma => _prefs.getString(_keyIdioma) ?? _defaultIdioma;
  static String get tema => _prefs.getString(_keyTema) ?? _defaultTema;
  static String get version => _prefs.getString(_keyVersion) ?? _defaultVersion;

  /// Setters
  static Future<void> setIdioma(String value) async =>
      await _prefs.setString(_keyIdioma, value);

  static Future<void> setTema(String value) async =>
      await _prefs.setString(_keyTema, value);

  static Future<void> setVersion(String value) async =>
      await _prefs.setString(_keyVersion, value);
}
