import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  final List<Map<String, String>> notes;

  NotesScreen({Key? key, required this.notes}) : super(key: key);

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  void _addNote() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String noteTitle = '';
        String noteDescription = '';
        return AlertDialog(
          title: Text('Добавить заметку'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  noteTitle = value;
                },
                decoration: InputDecoration(hintText: 'Введите название заметки'),
              ),
              TextField(
                onChanged: (value) {
                  noteDescription = value;
                },
                decoration: InputDecoration(hintText: 'Введите описание заметки'),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Добавить'),
              onPressed: () {
                if (noteTitle.isNotEmpty) {
                  setState(() {
                    widget.notes.add({
                      'title': noteTitle,
                      'description': noteDescription,
                    });
                  });
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteNote(int index) {
    setState(() {
      widget.notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.notes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.notes[index]['title']!),
            subtitle: Text(widget.notes[index]['description'] ?? ''),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteNote(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        child: Icon(Icons.add),
      ),
    );
  }
}
