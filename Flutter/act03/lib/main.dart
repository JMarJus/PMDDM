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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(
          title: 'Contenedor personalizado (imagen y texto debajo)'),
    );
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
          title: Text(widget.title),
        ),
        body: Center(
            child: Container(
                alignment: Alignment.center,
                color: Colors.amberAccent,
                // Tamaño suficiente para que el texto no se salga del contenedor
                width: 250,
                height: 300,
                // Padding para que la imagen no se pegue al margen superior
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  Image.asset('assets/depressed.jpg'),
                  const Text(
                    'Perdón es la única imagen medio decente que tengo a mano',
                  )
                ]))));
  }
}
