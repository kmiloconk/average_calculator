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

  @override
  void initState() {
    super.initState();
    _addRow(); // Añadir la primera fila al iniciar
  }

  void _addRow({int? insertAt}) {
    setState(() {
      final newRow = {
        'note': TextEditingController(),
        'percentage': TextEditingController(),
        'editable': true,
        'showAddButton': true,
      };

      if (insertAt != null) {
        fields.insert(insertAt, newRow);
        fields[insertAt - 1]['editable'] = false;
        fields[insertAt - 1]['showAddButton'] = false;
      } else {
        fields.add(newRow);
      }
    });
  }

  void _removeRowAt(int index) {
    setState(() {
      fields.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 120, vertical: 3),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      hintText: 'Ramo',
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
            const SizedBox(height: 8),
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
                  final noteController = row['note'] as TextEditingController;
                  final percentageController =
                      row['percentage'] as TextEditingController;
                  final editable = row['editable'] as bool;
                  final showAddButton = row['showAddButton'] as bool;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        const Expanded(child: Text('')),
                        if (editable)
                          IconButton(
                            icon: const Icon(Icons.arrow_upward),
                            onPressed: () => _removeRowAt(index),
                          ),
                        textfile(noteController, enabled: editable),
                        const SizedBox(width: 30),
                        textfile(percentageController, enabled: editable),
                        if (showAddButton)
                          IconButton(
                            icon: const Icon(Icons.arrow_downward),
                            onPressed: () => _addRow(insertAt: index + 1),
                          ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 120, vertical: 3),
                child: TextField(
                  controller: averageController,
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
    );
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
