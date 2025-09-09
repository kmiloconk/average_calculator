import 'package:average_calculator/app/pv/pv_page.dart';
import 'package:average_calculator/app/services/services.dart';
import 'package:average_calculator/app/options/option.dart'; // 👈 Para acceder a AppPreferences
import 'package:flutter/material.dart';

class SubjectListPage extends StatefulWidget {
  final List<SubjectData> subjects;
  final Color backgroun, icon;

  const SubjectListPage({
    super.key,
    required this.subjects,
    required this.backgroun,
    required this.icon,
  });

  @override
  State<SubjectListPage> createState() => _SubjectListPageState();
}

class _SubjectListPageState extends State<SubjectListPage> {
  String _idioma = AppPreferences.idioma;

  void _removeSubject(int index) async {
    final removedSubject = widget.subjects[index];

    setState(() {
      widget.subjects.removeAt(index);
    });

    await saveSubjectsToFile(widget.subjects);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _idioma == "Español"
              ? '${removedSubject.name} eliminada'
              : '${removedSubject.name} deleted',
          style: TextStyle(color: widget.icon),
        ),
        backgroundColor: widget.backgroun,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroun,
      appBar: AppBar(
        title: Text(
          _idioma == "Español" ? "Asignaturas guardadas" : "Saved subjects",
          style: TextStyle(color: widget.icon),
        ),
        backgroundColor: widget.backgroun,
        iconTheme: IconThemeData(color: widget.icon),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: widget.icon),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: widget.subjects.isEmpty
          ? Center(
              child: Text(
                _idioma == "español"
                    ? "No tienes asignaturas guardadas"
                    : "No saved subjects",
                style: TextStyle(color: widget.icon, fontSize: 16),
              ),
            )
          : ListView.builder(
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
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [subject.color, widget.backgroun],
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        subject.name,
                        style: TextStyle(color: widget.icon),
                      ),
                      trailing:
                          Icon(Icons.arrow_forward_ios, color: widget.icon),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PvPage(
                              loadedData: subject,
                              backgourd: widget.backgroun,
                              icon: widget.icon,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }),
    );
  }
}
