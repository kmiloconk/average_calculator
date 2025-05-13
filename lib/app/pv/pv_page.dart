import 'package:flutter/material.dart';

class PvPage extends StatefulWidget {
  const PvPage({super.key});

  @override
  State<PvPage> createState() => _PvPageState();
}

class _PvPageState extends State<PvPage> {
  final List<Map<String, TextEditingController>> fields = [];
  final TextEditingController averageController = TextEditingController();
  bool v = false;

  @override
  void initState() {
    super.initState();
    _addRow();
  }

  void _addRow() {
    setState(() {
      fields.add({
        'note': TextEditingController(),
        'percentage': TextEditingController(),
      });
    });
  }

  void _removeRow() {
    if (fields.isNotEmpty) {
      setState(() {
        fields.removeLast();
      });
    }
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
            const Text('Calculadora', style: TextStyle(fontSize: 20)),
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
                itemCount: fields.length + 1, // uno más para el botón add
                itemBuilder: (context, index) {
                  if (index == fields.length) {
                    return Center(
                      child: IconButton(
                        onPressed: _addRow,
                        icon: const Icon(Icons.add),
                      ),
                    );
                  }

                  final noteController = fields[index]['note']!;
                  final percentageController = fields[index]['percentage']!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        const Expanded(child: Text('')),
                        const SizedBox(width: 50),
                        textfile(noteController),
                        const SizedBox(width: 30),
                        textfile(percentageController),
                        Visibility(
                            visible: v, child: const SizedBox(width: 48)),
                        Visibility(
                          visible: !v,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_downward),
                          ),
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
                  button(Icons.arrow_back, 'Volver', Colors.red, _removeRow),
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

Widget textfile(TextEditingController controller) {
  return SizedBox(
    width: 100,
    height: 50,
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: '',
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  );
}
