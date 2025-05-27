import 'package:average_calculator/app/pv/pv_page.dart';
import 'package:average_calculator/app/services/services.dart';
import 'package:flutter/material.dart';

class SubjectListPage extends StatefulWidget {
  final List<SubjectData> subjects;
  const SubjectListPage({super.key, required this.subjects});

  @override
  State<SubjectListPage> createState() => _SubjectListPageState();
}

class _SubjectListPageState extends State<SubjectListPage> {
  void _removeSubject(int index) async {
    setState(() {
      widget.subjects.removeAt(index);
    });

    await saveSubjectsToFile(widget.subjects);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Asignaturas guardadas")),
      body: ListView.builder(
        itemCount: widget.subjects.length,
        itemBuilder: (context, index) {
          final subject = widget.subjects[index];
          return Dismissible(
            key: Key(subject.name + index.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              _removeSubject(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${subject.name} eliminada')),
              );
            },
            child: ListTile(
              title: Text(subject.name),
              leading: CircleAvatar(backgroundColor: subject.color),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PvPage(loadedData: subject),
                  ),
                  (route) => false,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
