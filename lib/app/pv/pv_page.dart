import 'package:flutter/material.dart';

class PvPage extends StatefulWidget {
  const PvPage({super.key});

  @override
  State<PvPage> createState() => _PvPageState();
}

class _PvPageState extends State<PvPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text('Calculadora'),
        ),
        automaticallyImplyLeading: false,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
      ),
      body: Center(
          child: Row(
        children: [
          ElevatedButton(onPressed: () {}, child: const Icon(Icons.arrow_back)),
          ElevatedButton(onPressed: () {}, child: const Text('Calcular')),
          ElevatedButton(onPressed: () {}, child: const Text('Guardar'))
        ],
      )),
    );
  }
}
