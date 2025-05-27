import 'package:flutter/material.dart';

class PvPage extends StatefulWidget {
  const PvPage({super.key});

  @override
  State<PvPage> createState() => _PvPageState();
}

class _PvPageState extends State<PvPage> {
  final List<Map<String, dynamic>> fields = [];
  final TextEditingController averageController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final List<Color> availableColors = [
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.blue,
    Colors.black,
    Colors.orange,
    Colors.purpleAccent,
    Colors.brown,
    Colors.yellow,
  ];

  Color appBarColor = Colors.blue;
  Color backgroundColor = Colors.blue.withOpacity(0.3);

  void _changeColors(Color newColor) {
    setState(() {
      appBarColor = newColor;
      backgroundColor = newColor.withOpacity(0.3);
    });
  }

  @override
  void initState() {
    super.initState();
    _addRow();
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
          backgroundColor: appBarColor,
          iconTheme: const IconThemeData(color: Colors.white),
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
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
              iconColor: Colors.white,
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
              colors: [backgroundColor, appBarColor],
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
                      decoration: const InputDecoration(
                          hintText: 'Asignatura',
                          fillColor: Colors.white,
                          filled: false,
                          enabled: true),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Expanded(child: Text('', textAlign: TextAlign.center)),
                    Expanded(child: Text('Nota', textAlign: TextAlign.center)),
                    SizedBox(width: 60),
                    Expanded(child: Text('%', textAlign: TextAlign.center)),
                    Expanded(child: Text('', textAlign: TextAlign.center)),
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
                            icon: const Icon(Icons.add),
                          ),
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
                                icon: const Icon(Icons.arrow_upward),
                                onPressed: () => _removeRowAt(index),
                              )
                            else
                              (const SizedBox(width: 47)),
                            textfile(noteController, enabled: editable),
                            const SizedBox(width: 30),
                            textfile(percentageController, enabled: true),
                            if (showAddButton)
                              IconButton(
                                icon: const Icon(Icons.arrow_downward),
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
                        onPressed: () {},
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
                      button(null, 'Guardar', Colors.green, () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
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
}

Widget textfile(TextEditingController controller, {bool enabled = true}) {
  return SizedBox(
    width: 100,
    height: 50,
    child: TextField(
      controller: controller,
      textAlign: TextAlign.center,
      enabled: enabled,
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
