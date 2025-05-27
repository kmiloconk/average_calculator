import 'package:average_calculator/app/pv/pv_page.dart';
import 'package:flutter/material.dart';

class SubjectListPage extends StatelessWidget {
  final List<SubjectData> subjects;
  const SubjectListPage({super.key, required this.subjects});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Asignaturas guardadas")),
      body: ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          final subject = subjects[index];
          return ListTile(
            title: Text(subject.name),
            leading: CircleAvatar(backgroundColor: subject.color),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PvPage(loadedData: subject),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
