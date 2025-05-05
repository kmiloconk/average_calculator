import 'package:flutter/material.dart';

class PvPage extends StatefulWidget {
  const PvPage({super.key});

  @override
  State<PvPage> createState() => _PvPageState();
}

class _PvPageState extends State<PvPage> {
  final TextEditingController noteController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();
  bool v = true;

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
            Row(
              children: [
                const Expanded(child: Text('')),
                const SizedBox(width: 50),
                textfile(noteController),
                const SizedBox(width: 30),
                textfile(percentageController),
                Visibility(visible: v, child: const SizedBox(width: 48)),
                Visibility(
                    visible: !v,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_downward))),
                const Expanded(child: Text('')),
              ],
            ),
            const SizedBox(height: 10),
            IconButton(
              onPressed: () {
                setState(() {
                  v = !v;
                });
              },
              icon: const Icon(Icons.add),
            ),
            const SizedBox(height: 24),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 100,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 120,
                    height: 60,
                    child: ElevatedButton(
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
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 100,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Guardar',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
