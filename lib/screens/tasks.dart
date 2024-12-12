import 'package:flutter/material.dart';

class Tasks extends StatefulWidget {
  final List<Map<String, String>> tasks;

  Tasks({Key? key, required this.tasks}) : super(key: key);

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  void _addTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String taskName = '';
        String taskDetails = '';
        return AlertDialog(
          title: Text('Добавить задачу'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  taskName = value;
                },
                decoration:
                    InputDecoration(hintText: 'Введите название задачи'),
              ),
              TextField(
                onChanged: (value) {
                  taskDetails = value;
                },
                decoration:
                    InputDecoration(hintText: 'Введите описание задачи'),
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
                if (taskName.isNotEmpty) {
                  setState(() {
                    widget.tasks.add({
                      'name': taskName,
                      'details': taskDetails,
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

  void _deleteTask(int index) {
    setState(() {
      widget.tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.tasks[index]['name']!),
            subtitle: Text(widget.tasks[index]['details'] ?? ''),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteTask(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(Icons.add),
      ),
    );
  }
}
