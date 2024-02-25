import 'package:flutter/material.dart';
import 'gamepedia.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Main menu')),
            body: Center(child: Text("Portada (WIP)")),
            drawer: Gamepedia()));
  }
}
