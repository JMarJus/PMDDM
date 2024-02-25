import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Actividad 07',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
            useMaterial3: true),
        home: const MyHomePage(title: 'Actividad 07: Drawer'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title)),
        drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: const <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/fish.jpg"),
                      fit: BoxFit.cover),
                  color: Colors.blueGrey),
              child: Text("CONTENIDO",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36))),
          ListTile(leading: Icon(Icons.water), title: Text("Rosada")),
          ListTile(leading: Icon(Icons.water), title: Text("Trucha")),
          ListTile(leading: Icon(Icons.water), title: Text("Dorada")),
          ListTile(leading: Icon(Icons.water), title: Text("Sardina")),
          ListTile(leading: Icon(Icons.water), title: Text("Boquerón")),
          ListTile(leading: Icon(Icons.water), title: Text("Pez espada")),
          ListTile(leading: Icon(Icons.water), title: Text("Bacalao")),
          ListTile(leading: Icon(Icons.water), title: Text("Bacaladilla"))
        ])));
  }
}
