import 'package:flutter/material.dart';
import 'package:average_calculator/app/options/option.dart';

class OptionPage extends StatefulWidget {
  const OptionPage({super.key});

  @override
  State<OptionPage> createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  String _idioma = AppPreferences.idioma;
  String _tema = AppPreferences.tema;
  final String _version = AppPreferences.version;

  // 🔹 Traducciones básicas
  final Map<String, Map<String, String>> _traducciones = {
    "Español": {
      "titulo": "Opciones",
      "idioma": "Idioma",
      "tema": "Tema",
      "version": "Versión",
      "contacto": "Contacto",
      "selecciona_idioma": "Selecciona idioma",
      "selecciona_tema": "Selecciona tema",
      "proximamente": "Próximamente versión de pago sin anuncios",
      "cerrar": "Cerrar",
    },
    "English": {
      "titulo": "Options",
      "idioma": "Language",
      "tema": "Theme",
      "version": "Version",
      "contacto": "Contact",
      "selecciona_idioma": "Select language",
      "selecciona_tema": "Select theme",
      "proximamente": "Coming soon: paid version without ads",
      "cerrar": "Close",
    },
  };

  // 🔹 Traducción de temas
  final Map<String, Map<String, String>> _traduccionTemas = {
    "Español": {
      "Light": "Claro",
      "Dark": "Oscuro",
    },
    "English": {
      "Light": "Light",
      "Dark": "Dark",
    },
  };

  // 🔹 Traducción de idiomas (opcional, por si quieres mostrar traducido también)
  final Map<String, Map<String, String>> _traduccionIdiomas = {
    "Español": {
      "Español": "Español",
      "English": "Inglés",
    },
    "English": {
      "Español": "Spanish",
      "English": "English",
    },
  };

  // 🔹 Colores según tema
  bool get _esDark => _tema == "Dark";
  Color get _colorFondo => _esDark ? Colors.black : Colors.white;
  Color get _colorTexto => _esDark ? Colors.white : Colors.black;
  Color get _colorAppBar => _esDark ? Colors.black : Colors.white;
  Color get _colorIcono => _esDark ? Colors.white : Colors.black;

  // 🔹 Traducción rápida
  String t(String key) => _traducciones[_idioma]?[key] ?? key;
  String traducirTema(String tema) => _traduccionTemas[_idioma]?[tema] ?? tema;
  String traducirIdioma(String idioma) =>
      _traduccionIdiomas[_idioma]?[idioma] ?? idioma;

  void _mostrarContacto() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _colorFondo,
        title: Text(t("contacto"), style: TextStyle(color: _colorTexto)),
        content: Text(
          _idioma == "Español"
              ? "📧 correo: ejemplo@correo.com\n📱 número: +56 9 1234 5678"
              : "📧 email: ejemplo@correo.com\n📱 phone: +56 9 1234 5678",
          style: TextStyle(color: _colorTexto),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t("cerrar"), style: TextStyle(color: _colorTexto)),
          ),
        ],
      ),
    );
  }

  Future<void> _mostrarOpciones({
    required String titulo,
    required List<String> opciones,
    required String valorActual,
    required void Function(String) onSeleccion,
    required String Function(String) traductor,
  }) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: _colorFondo,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                titulo,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _colorTexto,
                ),
              ),
            ),
            ...opciones.map((opcion) => RadioListTile<String>(
                  value: opcion,
                  groupValue: valorActual,
                  title: Text(
                    traductor(opcion),
                    style: TextStyle(color: _colorTexto),
                  ),
                  activeColor: _esDark ? Colors.white : Colors.black,
                  onChanged: (value) {
                    if (value != null) {
                      onSeleccion(value);
                      Navigator.pop(context);
                    }
                  },
                )),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorFondo,
      appBar: AppBar(
        title: Text(t("titulo"), style: TextStyle(color: _colorTexto)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: _colorIcono),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: _colorAppBar,
        iconTheme: IconThemeData(color: _colorIcono),
      ),
      body: ListView(
        children: [
          // Idioma
          ListTile(
            title: Text(t("idioma"), style: TextStyle(color: _colorTexto)),
            trailing: Text(traducirIdioma(_idioma),
                style: TextStyle(color: _colorTexto)),
            onTap: () => _mostrarOpciones(
              titulo: t("selecciona_idioma"),
              opciones: ["Español", "English"], // internos
              valorActual: _idioma,
              onSeleccion: (value) {
                setState(() => _idioma = value);
                AppPreferences.setIdioma(value);
              },
              traductor: traducirIdioma,
            ),
          ),

          // Tema
          ListTile(
            title: Text(t("tema"), style: TextStyle(color: _colorTexto)),
            trailing:
                Text(traducirTema(_tema), style: TextStyle(color: _colorTexto)),
            onTap: () => _mostrarOpciones(
              titulo: t("selecciona_tema"),
              opciones: ["Light", "Dark"], // internos
              valorActual: _tema,
              onSeleccion: (value) {
                setState(() => _tema = value);
                AppPreferences.setTema(value);
              },
              traductor: traducirTema,
            ),
          ),

          // Versión
          ListTile(
            title: Text(t("version"), style: TextStyle(color: _colorTexto)),
            trailing: Text(_version, style: TextStyle(color: _colorTexto)),
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(t("proximamente")),
                backgroundColor: _esDark ? Colors.grey[900] : Colors.grey[300],
                behavior: SnackBarBehavior.floating,
              ),
            ),
          ),

          // Contacto
          ListTile(
            title: Text(t("contacto"), style: TextStyle(color: _colorTexto)),
            trailing: Icon(Icons.info_outline, color: _colorIcono),
            onTap: _mostrarContacto,
          ),
        ],
      ),
    );
  }
}
