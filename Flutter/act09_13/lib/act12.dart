// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'dart:math';

import 'myDrawer.dart';

void main() => runApp(const Act12App());

class Act12App extends StatelessWidget {
  const Act12App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey)),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 155, 143, 33))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple)),
              labelStyle: TextStyle(color: Colors.blueGrey))),
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _textEditingControllers = [];
  final List<Widget> _widgets = [];
  int secretNum =
      Random().nextInt(100); // Cálculo de un entero aleatorio de 1 a 100
  HomeWidget({Key? key}) : super(key: key) {
    List<String> fieldNames = ["Random"];
    for (int i = 0; i < fieldNames.length; i++) {
      String fieldName = fieldNames[i];
      TextEditingController textEditingController =
          TextEditingController(text: "");
      _textEditingControllers.add(textEditingController);
      _widgets.add(Padding(
          padding: const EdgeInsets.all(7.0),
          child: _createTextFormField(fieldName, textEditingController)));
    }
    _widgets.add(ElevatedButton(
        onPressed: () {
          _formKey.currentState?.validate();
        },
        child: const Text('Guess')));
  }
  TextFormField _createTextFormField(
      String fieldName, TextEditingController controller) {
    return TextFormField(
        validator: (value) {
          if (value!.isEmpty || // El valor no puede estar vacío
              value.contains(
                  RegExp(r'[A-Za-z]')) || // El valor no puede contener letras
              int.parse(value) < 1 || // El valor debe ser mayor que 0
              int.parse(value) > 100) {
            // El valor debe ser menor que 101
            return 'You have to write an integer between 1 and 100!';
          } else if (int.parse(value) < secretNum) {
            return 'Too low...'; // Si el valor es menor que el número aleatorio
          } else if (int.parse(value) > secretNum) {
            return 'Too high...'; // Si el valor es mayor que el número aleatorio
          }
          return null;
        },
        decoration: const InputDecoration(
            icon: Icon(Icons.person), labelText: 'Try to guess the number!'),
        controller: controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Actividad 12")),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(key: _formKey, child: ListView(children: _widgets))),
        drawer: const MyDrawerApp());
  }
}
