// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:average_calculator/app/pv/pv_page.dart';
import 'package:average_calculator/app/list/list_page.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<SubjectData> savedSubjects = [];
  Color black = Colors.black;
  Color white = Colors.white;
  bool dark = true;

  @override
  void initState() {
    super.initState();
    _loadSubjectsFromFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Configuraciones próximamente')),
              );
            },
          ),
        ],
        leading: IconButton(
            onPressed: () {
              setState(() {
                if (dark) {
                  dark = false;
                  white = Colors.black;
                  black = Colors.white;
                } else {
                  dark = true;
                  white = Colors.white;
                  black = Colors.black;
                }
              });
            },
            icon: Icon(
              dark ? Icons.mode_night : Icons.sunny,
              color: white,
            )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: dark,
            child: Center(
              child: Image.asset(
                'lib/app/assets/Logo moderno de PrometriX con gráfico.png',
                width: 260,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Visibility(
            visible: !dark,
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
              backgroundColor: Colors.grey[800],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PvPage(
                          backgourd: black,
                          icon: white,
                        )),
              );
            },
            child: const Text('Nuevo'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[800],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            onPressed: () async {
              await _loadSubjectsFromFile();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SubjectListPage(
                    subjects: savedSubjects,
                    backgroun: black,
                    icon: white,
                  ),
                ),
              );
            },
            child: const Text('Mis listas'),
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
