// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:average_calculator/app/options/options_page.dart';
import 'package:flutter/material.dart';
import 'package:average_calculator/app/pv/pv_page.dart';
import 'package:average_calculator/app/list/list_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:average_calculator/app/options/option.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<SubjectData> savedSubjects = [];

  String _idioma = AppPreferences.idioma;
  String _tema = AppPreferences.tema;

  // 🔹 Traducciones
  final Map<String, Map<String, String>> _traducciones = {
    "Español": {
      "nuevo": "Nuevo",
      "guardados": "Guardados",
    },
    "English": {
      "nuevo": "New",
      "guardados": "Saved",
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

  @override
  void initState() {
    super.initState();
    _loadSubjectsFromFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorFondo,
      appBar: AppBar(
        backgroundColor: _colorAppBar,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: _colorIcono),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OptionPage()),
              );
              // 🔹 Refrescar tema/idioma al volver
              setState(() {
                _idioma = AppPreferences.idioma;
                _tema = AppPreferences.tema;
              });
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: _esDark,
            child: Center(
              child: Image.asset(
                'lib/app/assets/Logo moderno de PrometriX con gráfico.png',
                width: 260,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Visibility(
            visible: !_esDark,
            child: Center(
              child: Image.asset(
                'lib/app/assets/LogoBlanco.png',
                width: 260,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _esDark ? Colors.grey[800] : Colors.grey[300],
              foregroundColor: _colorTexto,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PvPage(
                    backgourd: _colorFondo,
                    icon: _colorTexto,
                  ),
                ),
              );
            },
            child: Text(t("nuevo")),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _esDark ? Colors.grey[800] : Colors.grey[300],
              foregroundColor: _colorTexto,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            onPressed: () async {
              await _loadSubjectsFromFile();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SubjectListPage(
                    subjects: savedSubjects,
                    backgroun: _colorFondo,
                    icon: _colorTexto,
                  ),
                ),
              );
            },
            child: Text(t("guardados")),
          ),
        ],
      ),
    );
  }

  Future<void> _loadSubjectsFromFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/subjects.json');

    if (await file.exists()) {
      final jsonData = jsonDecode(await file.readAsString());

      setState(() {
        savedSubjects = (jsonData as List<dynamic>).map((subject) {
          return SubjectData(
            name: subject['name'],
            color: Color(subject['color']),
            notes: (subject['notes'] as List<dynamic>).map((note) {
              return NoteData.fromJson(note);
            }).toList(),
          );
        }).toList();
      });
    }
  }
}
