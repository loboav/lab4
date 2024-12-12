import 'package:flutter/material.dart';
import 'screens/appointments.dart';
import 'screens/contacts.dart';
import 'screens/notes.dart';
import 'screens/tasks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Менеджер личной информации',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      home: HomeScreen(toggleTheme: _toggleTheme, themeMode: _themeMode),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final ThemeMode themeMode;

  HomeScreen({required this.toggleTheme, required this.themeMode});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<List<Map<String, String>>> _tasks = [
    [],
    [],
    [],
    [],
  ];

  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();

    _screens.addAll([
      AppointmentsScreen(appointments: _tasks[0]),
      ContactsScreen(contacts: _tasks[1]),
      NotesScreen(notes: _tasks[2]),
      Tasks(tasks: _tasks[3]),
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addTask() {
    setState(() {
      _tasks[_selectedIndex].add({
        'title': 'Новая запись',
        'description': 'Описание записи',
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.person, size: 30),
            Text('Менеджер информации',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            IconButton(
              icon: Icon(widget.themeMode == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode),
              onPressed: widget.toggleTheme,
            ),
          ],
        ),
        backgroundColor: widget.themeMode == ThemeMode.light
            ? Colors.blue
            : Colors.grey[850],
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            backgroundColor: widget.themeMode == ThemeMode.light
                ? Colors.grey[200]
                : Colors.black,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.calendar_today),
                label: Text('Встречи'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.contacts),
                label: Text('Контакты'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.note),
                label: Text('Заметки'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.check_box),
                label: Text('Задачи'),
              ),
            ],
            selectedIconTheme:
                IconThemeData(color: Colors.lightBlueAccent, size: 30),
            unselectedIconTheme: IconThemeData(color: Colors.grey, size: 25),
            selectedLabelTextStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelTextStyle: TextStyle(fontStyle: FontStyle.italic),
          ),
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
