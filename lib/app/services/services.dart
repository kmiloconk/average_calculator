import 'dart:convert';
import 'dart:io';
//import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:average_calculator/app/pv/pv_page.dart';

Future<void> saveSubjectsToFile(List<SubjectData> savedSubjects) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/subjects.json');

  List<Map<String, dynamic>> jsonData = savedSubjects
      .map((subject) => {
            'name': subject.name,
            'color': subject.color.value,
            'notes': subject.notes
                .map((note) => {
                      'note': note.note,
                      'percentage': note.percentage,
                    })
                .toList()
          })
      .toList();

  await file.writeAsString(jsonEncode(jsonData));
}
