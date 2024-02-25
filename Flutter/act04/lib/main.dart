import 'package:flutter/material.dart';
import 'Contenedor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ejemplo de iconos',
        home: Scaffold(
            appBar: AppBar(
              title: const Center(
                child: Text('Ejemplo de Container'),
              ),
            ),
            body: Row(children: <Widget>[
              Contenedor(Colors.cyan, 120.0, 120.0, 'azul', 12.0, 120.0, 120.0),
              Contenedor(Colors.pink, 100.0, 100.0, 'rosa', 10.0, 100.0, 100.0),
              Contenedor(
                  Colors.green, 110.0, 110.0, 'verde', 11.0, 110.0, 110.0),
            ])));
  }
}
