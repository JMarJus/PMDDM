import 'package:flutter/material.dart';
import 'myDrawer.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const Act11AppStateful());

class Act11App extends StatelessWidget {
  const Act11App({super.key});

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
                        BorderSide(color: Color.fromARGB(255, 170, 153, 0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple)),
                labelStyle: TextStyle(color: Colors.blueGrey))),
        home: Act11AppStateful());
  }
}

class Act11AppStateful extends StatefulWidget {
  const Act11AppStateful({super.key});

  @override
  State<Act11AppStateful> createState() => _Act11State();
}

class _Act11State extends State<Act11AppStateful> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _textEditingControllers = [];
  final List<Widget> _widgets = [];
  final List<String> fieldNames = ["Name", "Age"];
  _Act11State() {
    for (int i = 0; i < fieldNames.length; i++) {
      String fieldName = fieldNames[i];
      TextEditingController textEditingController =
          TextEditingController(text: "");
      _textEditingControllers.add(textEditingController);
      _widgets.add(Padding(
        padding: const EdgeInsets.all(16.0),
        child: _createTextFormField(fieldName, textEditingController),
      ));
    }

    // Después de inicializar las listas de valores y controladores, cargar datos guardados.
    _loadData();

    _widgets.add(ElevatedButton(
        onPressed: () {
          _formKey.currentState?.validate();
          _formKey.currentState?.save();

          // Guardar datos al pulsar el botón.
          _saveData(fieldNames, _textEditingControllers);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 171, 147, 212),
            padding: const EdgeInsets.all(16.0),
            textStyle:
                const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        child: const Text('Save')));
  }
  TextFormField _createTextFormField(
      String fieldName, TextEditingController controller) {
    return TextFormField(
        validator: (value) {
          // Si el campo está vacío:
          if (value!.isEmpty) {
            return 'Please input $fieldName.';
            // Si el campo es Name y contiene números:
          } else if (fieldName == "Name" && value.contains(RegExp(r'[0-9]'))) {
            return 'The field $fieldName must not contain any numbers.';
            // Si el campo es Age y no es un número igual a 0 o mayor:
          } else if (fieldName == "Age" &&
              (value.contains(RegExp(r'[A-Za-z]')) || int.parse(value) < 0)) {
            return 'The field $fieldName must be an integer equal to 0 or higher.';
          }
          return null;
        },
        decoration: InputDecoration(
            icon: const Icon(Icons.person), hintText: fieldName),
        controller: controller);
  }

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
                        BorderSide(color: Color.fromARGB(255, 170, 153, 0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple)),
                labelStyle: TextStyle(color: Colors.blueGrey))),
        home: Scaffold(
            appBar: AppBar(title: const Text("Actividad 11")),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    Form(key: _formKey, child: ListView(children: _widgets))),
            drawer: const MyDrawerApp()));
  }

  // Sección de guardado de datos en SharedPreferences

  @override
  void initState() {
    super.initState();
  }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _textEditingControllers.elementAt(0).text = prefs.getString('Name')!;
      _textEditingControllers.elementAt(1).text =
          prefs.getInt('Age')!.toString();
    });
  }

  _saveData(List<String> fieldNames,
      List<TextEditingController> textEditingControllers) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (String fieldName in fieldNames) {
        if (fieldName == "Name") {
          prefs.setString('Name', textEditingControllers.elementAt(0).text);
        }
        if (fieldName == "Age") {
          prefs.setInt(
              'Age', int.parse(textEditingControllers.elementAt(1).text));
        }
      }
    });
  }
}
