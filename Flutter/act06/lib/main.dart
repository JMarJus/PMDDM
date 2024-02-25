import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 43, 38, 44)),
            useMaterial3: true,
            scaffoldBackgroundColor: const Color.fromARGB(255, 45, 40, 49)),
        home: const MyHomePage(title: 'Desafíos'));
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
        body: Column(children: [
          // Desafío 2: Cabecera
          Container(
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 243, 194, 33),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32)),
                  boxShadow: [BoxShadow(blurRadius: 8)]),
              width: double.infinity,
              height: 32,
              child: const Text("Desafío 2: Cabecera",
                  style: TextStyle(fontSize: 16))),

          // Desafío 1: Helipuerto
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 16,
                          color: const Color.fromARGB(255, 184, 33, 243))),
                  width: 256,
                  height: 256,
                  margin: const EdgeInsets.all(32),
                  child: const Text("H",
                      style: TextStyle(
                          fontSize: 128,
                          color: Color.fromARGB(255, 184, 33, 243))))),

          // Desafío 4: Contenedor moderno
          // Nota · El fondo oscuro está personalizado en MaterialApp
          // Nota · Para comprobar que se ajusta arriba al centro, eliminar temporalmente Desafío 1 o cambiarlos de posición
          Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 139, 0, 194),
                    Color.fromARGB(255, 207, 176, 0)
                  ]),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: const [
                    BoxShadow(blurRadius: 8, offset: Offset(-8, 8))
                  ]),
              width: 256,
              height: 128,
              margin: const EdgeInsets.all(30),
              padding: const EdgeInsets.all(30),
              child: const Text("Desafío 4: Contenedor moderno",
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic))),

          // Desafío 3: Cápsula
          Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 173, 118, 0),
                  borderRadius: BorderRadius.circular(32)),
              width: 256,
              height: 64,
              margin: const EdgeInsets.all(32),
              child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(64),
                          bottomLeft: Radius.circular(64)),
                      color: Color.fromARGB(255, 255, 221, 129)),
                  width: 192,
                  height: 64,
                  child: const Text("Desafío 3: Cápsula",
                      style: TextStyle(fontSize: 16))))
        ]));
  }
}
