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

  @override
  void initState() {
    super.initState();
    _loadSubjectsFromFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Configuraciones próximamente')),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'lib/app/assets/Logo moderno de PrometriX con gráfico.png',
              width: 260, // Imagen más grande
              fit: BoxFit.contain,
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
                MaterialPageRoute(builder: (context) => const PvPage()),
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
                  builder: (_) => SubjectListPage(subjects: savedSubjects),
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
