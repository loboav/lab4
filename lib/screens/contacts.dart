import 'package:flutter/material.dart';

class ContactsScreen extends StatefulWidget {
  final List<Map<String, String>> contacts;

  ContactsScreen({Key? key, required this.contacts}) : super(key: key);

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  void _addContact() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String contactName = '';
        String contactNumber = '';
        return AlertDialog(
          title: Text('Добавить контакт'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  contactName = value;
                },
                decoration: InputDecoration(hintText: 'Введите имя контакта'),
              ),
              TextField(
                onChanged: (value) {
                  contactNumber = value;
                },
                decoration: InputDecoration(hintText: 'Введите номер телефона'),
                keyboardType: TextInputType.phone,
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
                if (contactName.isNotEmpty && _isValidPhoneNumber(contactNumber)) {
                  setState(() {
                    widget.contacts.add({
                      'name': contactName,
                      'number': contactNumber,
                    });
                  });
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Номер телефона должен содержать только цифры и/или знак "+"')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteContact(int index) {
    setState(() {
      widget.contacts.removeAt(index);
    });
  }

  bool _isValidPhoneNumber(String number) {
    final RegExp regex = RegExp(r'^[\d+]+$');
    return regex.hasMatch(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.contacts[index]['name']!),
            subtitle: Text(widget.contacts[index]['number']!),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteContact(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addContact,
        child: Icon(Icons.add),
      ),
    );
  }
}
