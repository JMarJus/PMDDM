import 'package:flutter/material.dart';
import 'myDrawer.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 170, 153, 0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple)),
                labelStyle: TextStyle(color: Colors.blueGrey))),
        home: Scaffold(
            appBar: AppBar(title: const Text('Actividad 09')),
            body: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                children: <Widget>[
                  ElevatedButton(
                      child: const Text('Elevated'), onPressed: () {}),
                  TextButton(child: const Text('Text'), onPressed: () {}),
                  OutlinedButton(
                      child: const Text('Outlined'), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.person), onPressed: () {}),
                  const CloseButton(),
                  PopupMenuButton<String>(itemBuilder: (context) {
                    return <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                          value: 'Popup', child: Text('a')),
                      const PopupMenuItem<String>(
                          value: 'Menu', child: Text('b')),
                      const PopupMenuItem<String>(
                          value: 'Item', child: Text('c'))
                    ];
                  })
                ]),
            drawer: const MyDrawerApp()));
  }
}
