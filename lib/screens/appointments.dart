import 'package:flutter/material.dart';

class AppointmentsScreen extends StatefulWidget {
  final List<Map<String, String>> appointments;

  AppointmentsScreen({Key? key, required this.appointments}) : super(key: key);

  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  void _addAppointment() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String appointmentTitle = '';
        String appointmentDetails = '';

        return AlertDialog(
          title: Text('Добавить встречу'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  appointmentTitle = value;
                },
                decoration: InputDecoration(hintText: 'Введите название встречи'),
              ),
              TextField(
                onChanged: (value) {
                  appointmentDetails = value;
                },
                decoration: InputDecoration(hintText: 'Введите детали встречи'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'Выберите дату'
                        : 'Дата: ${_selectedDate!.toLocal()}'.split(' ')[0],
                  ),
                  TextButton(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (date != null) {
                        setState(() {
                          _selectedDate = date;
                        });
                      }
                    },
                    child: Text('Выбрать'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedTime == null
                        ? 'Выберите время'
                        : 'Время: ${_selectedTime!.hour}:${_selectedTime!.minute} ',
                  ),
                  TextButton(
                    onPressed: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        setState(() {
                          _selectedTime = time;
                        });
                      }
                    },
                    child: Text('Выбрать'),
                  ),
                ],
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
                if (appointmentTitle.isNotEmpty && _selectedDate != null && _selectedTime != null) {
                  String dateTime = '${_selectedDate!.toLocal().toString().split(' ')[0]} ${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}';
                  setState(() {
                    widget.appointments.add({
                      'title': appointmentTitle,
                      'details': appointmentDetails,
                      'datetime': dateTime,
                    });
                  });
                }
                _selectedDate = null;
                _selectedTime = null;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteAppointment(int index) {
    setState(() {
      widget.appointments.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.appointments.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.appointments[index]['title']!),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.appointments[index]['details'] ?? ''),
                Text(widget.appointments[index]['datetime'] ?? ''),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteAppointment(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAppointment,
        child: Icon(Icons.add),
      ),
    );
  }
}
