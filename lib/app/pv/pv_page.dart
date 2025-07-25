import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:average_calculator/app/services/services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PvPage extends StatefulWidget {
  final SubjectData? loadedData;
  final Color backgourd, icon;
  const PvPage(
      {super.key,
      this.loadedData,
      required this.backgourd,
      required this.icon});

  @override
  State<PvPage> createState() => _PvPageState();
}

class _PvPageState extends State<PvPage> {
  final List<Map<String, dynamic>> fields = [];
  List<SubjectData> savedSubjects = [];
  final TextEditingController averageController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final List<Color> availableColors = [
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.blue,
    Colors.grey,
    Colors.orange,
    Colors.purpleAccent,
    Colors.brown,
    Colors.yellow,
  ];

  Color selectColor = Colors.blue;

  void _changeColors(Color newColor) {
    setState(() {
      selectColor = newColor;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSubjectsFromFile();
    if (widget.loadedData != null) {
      final data = widget.loadedData!;
      nameController.text = data.name;
      _changeColors(data.color);

      for (var noteData in data.notes) {
        fields.add({
          'note': TextEditingController(text: noteData.note.toString()),
          'percentage':
              TextEditingController(text: noteData.percentage.toString()),
          'editable': true,
          'showAddButton': true,
          'showArrow': false,
        });
      }
    } else {
      _addRow();
    }
  }

  void _addRow({int? insertAt}) {
    setState(() {
      final newRow = {
        'note': TextEditingController(),
        'percentage': TextEditingController(),
        'editable': true,
        'showAddButton': true,
        'showArrow': false
      };

      if (insertAt != null) {
        fields.insert(insertAt, newRow);
        fields[insertAt - 1]['editable'] = false;
        fields[insertAt]['showAddButton'] = false;
        fields[insertAt]['showArrow'] = true;
      } else {
        fields.add(newRow);
      }
    });
  }

  void _removeRowAt(int index) {
    setState(() {
      if (index != 0) {
        if (!fields[index - 1]['editable']) {
          fields[index - 1]['editable'] = true;
        }
        fields.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: widget.backgourd,
          iconTheme: IconThemeData(color: widget.icon),
          automaticallyImplyLeading: true,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  nameController.clear();
                  averageController.clear();
                  fields.clear();
                  _changeColors(Colors.blue);
                  _addRow();
                });
              },
              icon: const Icon(Icons.add),
            ),
          ],
          leading: Theme(
            data: Theme.of(context).copyWith(
              popupMenuTheme: const PopupMenuThemeData(
                color: Colors.transparent,
                elevation: 0,
              ),
            ),
            child: PopupMenuButton<Color>(
              icon: const Icon(Icons.palette),
              iconColor: widget.icon,
              offset: const Offset(0, 50),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<Color>(
                    enabled: false,
                    padding: EdgeInsets.zero,
                    child: SizedBox(
                      width: 140,
                      height: 140,
                      child: Center(
                        child: GridView.count(
                          crossAxisCount: 3,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(5.0),
                          children: availableColors.map((color) {
                            return InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                _changeColors(color);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.black26),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ];
              },
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [widget.backgourd, selectColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 120, vertical: 3),
                    child: TextField(
                      controller: nameController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Asignatura',
                        hintStyle: TextStyle(color: widget.icon),
                        fillColor: Colors.white,
                        filled: false,
                        enabled: true,
                      ),
                      style: TextStyle(color: widget.icon),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(
                        child: Text('', textAlign: TextAlign.center)),
                    Expanded(
                        child: Text(
                      'Nota',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: widget.icon),
                    )),
                    const SizedBox(width: 60),
                    Expanded(
                        child: Text('%',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: widget.icon))),
                    const Expanded(
                        child: Text('', textAlign: TextAlign.center)),
                  ],
                ),
                Flexible(
                  child: ListView.builder(
                    itemCount: fields.length + 1,
                    itemBuilder: (context, index) {
                      if (index == fields.length) {
                        return Center(
                          child: IconButton(
                              onPressed: () => _addRow(),
                              icon: Icon(
                                Icons.add,
                                color: widget.icon,
                              )),
                        );
                      }

                      final row = fields[index];
                      final noteController =
                          row['note'] as TextEditingController;
                      final percentageController =
                          row['percentage'] as TextEditingController;
                      final editable = row['editable'] as bool;
                      final showAddButton = row['showAddButton'] as bool;
                      final showArrow = row['showArrow'] as bool;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            const Expanded(child: Text('')),
                            if (showArrow)
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_upward,
                                  color: widget.icon,
                                ),
                                onPressed: () => _removeRowAt(index),
                              )
                            else
                              (const SizedBox(width: 47)),
                            textfile(noteController, enabled: editable),
                            const SizedBox(width: 30),
                            textfile(percentageController, enabled: true),
                            if (showAddButton)
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_downward,
                                  color: widget.icon,
                                ),
                                onPressed: () => _addRow(insertAt: index + 1),
                              )
                            else
                              (const SizedBox(width: 47)),
                            const Expanded(child: Text('')),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 120, vertical: 3),
                    child: TextField(
                      controller: averageController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: '',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabled: false),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      button(Icons.arrow_back, 'Volver', Colors.red, () {
                        if (fields.isNotEmpty) _removeRowAt(fields.length - 1);
                      }),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: _calculateAverage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Calcular',
                            style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(width: 16),
                      button(null, 'Guardar', Colors.green, () {
                        final List<NoteData> notesList = [];

                        for (final field in fields) {
                          final noteText =
                              (field['note'] as TextEditingController)
                                  .text
                                  .trim();
                          final percentText =
                              (field['percentage'] as TextEditingController)
                                  .text
                                  .trim();

                          final note = double.tryParse(noteText);
                          final percentage = double.tryParse(percentText);
                          final editable = field['editable'] as bool;
                          final showArrow = field['showArrow'] as bool;

                          if (note != null && percentage != null) {
                            notesList.add(
                              NoteData(
                                note: note,
                                percentage: percentage,
                                editable: editable,
                                showArrow: showArrow,
                              ),
                            );
                          }
                        }
                        final subject = SubjectData(
                          name: nameController.text.trim(),
                          color: selectColor,
                          notes: notesList,
                        );

                        setState(() {
                          addOrReplaceSubject(subject.name, subject.color);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Su asignatura se ha guardado'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _calculateAverage() {
    double totalWeightedSum = 0;
    double totalPercentage = 0;

    for (int i = 0; i < fields.length; i++) {
      final current = fields[i];

      final isEditable = current['editable'] as bool;
      final noteCtrl = current['note'] as TextEditingController;
      final percentageCtrl = current['percentage'] as TextEditingController;
      final showArrow = current['showArrow'] as bool;

      double note = 0;
      double percentage = 0;

      if (showArrow) continue;

      if (!isEditable) {
        List<Map<String, dynamic>> subNotes = [];
        int j = i + 1;
        while (j < fields.length && (fields[j]['showArrow'] as bool)) {
          subNotes.add(fields[j]);
          j++;
        }

        double sum = 0;
        double total = 0;

        for (var sub in subNotes) {
          final noteText = sub['note'].text.trim();
          final percentText = sub['percentage'].text.trim();

          final subNote = double.tryParse(noteText);
          final subPercent = double.tryParse(percentText);

          if (subNote != null && subPercent != null) {
            sum += subNote * subPercent;
            total += subPercent;
          }
        }

        if (total > 0) {
          note = sum / total;
          noteCtrl.text = note.toStringAsFixed(1);
          percentage = double.tryParse(percentageCtrl.text.trim()) ?? 0;
        }
      } else {
        note = double.tryParse(noteCtrl.text.trim()) ?? 0;
        percentage = double.tryParse(percentageCtrl.text.trim()) ?? 0;
      }

      if (percentage > 0) {
        totalWeightedSum += note * percentage;
        totalPercentage += percentage;
      }
    }

    String result;
    if (totalPercentage > 0) {
      double average = totalWeightedSum / totalPercentage;
      result = average.toStringAsFixed(1);
    } else {
      result = 'N/A';
    }

    setState(() {
      averageController.text = result;
    });
  }

  Widget button(
      IconData? icon, String text, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: 100,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: icon != null
            ? Icon(icon, color: Colors.white)
            : Text(text, style: const TextStyle(color: Colors.white)),
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

        // Si se cargó un subject específico, recreamos los campos
        if (widget.loadedData != null) {
          fields.clear();
          for (var noteData in widget.loadedData!.notes) {
            fields.add({
              'note': TextEditingController(text: noteData.note.toString()),
              'percentage':
                  TextEditingController(text: noteData.percentage.toString()),
              'editable': noteData.editable,
              'showAddButton': noteData.showAddButton,
              'showArrow': noteData.showArrow,
            });
          }
        }
      });
    }
  }

  void addOrReplaceSubject(String name, Color color) {
    final notesList = <NoteData>[];

    for (final field in fields) {
      final noteText = (field['note'] as TextEditingController).text.trim();
      final percentText =
          (field['percentage'] as TextEditingController).text.trim();

      final note = double.tryParse(noteText);
      final percentage = double.tryParse(percentText);

      if (note != null && percentage != null) {
        notesList.add(NoteData(
          note: note,
          percentage: percentage,
          editable: field['editable'] as bool,
          showAddButton: field['showAddButton'] as bool,
          showArrow: field['showArrow'] as bool,
        ));
      }
    }

    final subject = SubjectData(name: name, color: color, notes: notesList);

    setState(() {
      final index = savedSubjects.indexWhere((s) => s.name == name);
      if (index != -1) {
        savedSubjects[index] = subject;
      } else {
        savedSubjects.add(subject);
      }
    });

    saveSubjectsToFile(savedSubjects);
  }

  Widget textfile(TextEditingController controller, {bool enabled = true}) {
    return SizedBox(
      width: 100,
      height: 50,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        enabled: enabled,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: '',
          fillColor: enabled ? Colors.white : Colors.grey.shade300,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}

class SubjectData {
  final String name;
  final Color color;
  final List<NoteData> notes;

  SubjectData({
    required this.name,
    required this.color,
    required this.notes,
  });
}

class NoteData {
  final double note;
  final double percentage;
  final bool editable;
  final bool showAddButton;
  final bool showArrow;

  NoteData({
    required this.note,
    required this.percentage,
    this.editable = true,
    this.showAddButton = true,
    this.showArrow = false,
  });

  Map<String, dynamic> toJson() => {
        'note': note,
        'percentage': percentage,
        'editable': editable,
        'showAddButton': showAddButton,
        'showArrow': showArrow,
      };

  factory NoteData.fromJson(Map<String, dynamic> json) => NoteData(
        note: (json['note'] as num).toDouble(),
        percentage: (json['percentage'] as num).toDouble(),
        editable: json['editable'] ?? true,
        showAddButton: json['showAddButton'] ?? true,
        showArrow: json['showArrow'] ?? false,
      );
}
