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
            seedColor: const Color.fromARGB(255, 81, 162, 216)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Ejemplo de filas y columnas anidadas'),
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
            title: Text(widget.title)),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[Image.asset('assets/depressed.jpg')])
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[Image.asset('assets/depressed.jpg')]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[Image.asset('assets/depressed.jpg')])
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[Image.asset('assets/depressed.jpg')]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[Image.asset('assets/depressed.jpg')]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[Image.asset('assets/depressed.jpg')])
              ])
            ])));
  }
}
