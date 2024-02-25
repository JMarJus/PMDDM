import 'package:flutter/material.dart';
import '../gamepedia.dart';

class TicTacToe extends StatelessWidget {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Main menu')),
            body: Center(child: Text("portada o algo")),
            drawer: Gamepedia()));
  }
}
