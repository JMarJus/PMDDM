import 'package:flutter/material.dart';
import 'myDrawer.dart';

import 'dart:math';
import 'dart:async';

void main() {
  runApp(const Act10App());
}

class Act10App extends StatefulWidget {
  const Act10App({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RandomColors createState() => _RandomColors();
}

class _RandomColors extends State<Act10App> {
  Random random = Random();
  int points = 0;

  // Timer dinámico: se almacena el valor como variable, que desciende 100 milisegundos con cada acierto (más rápido) y asciende 100 milisegundos con cada fallo (más lento), siempre entre 0.5 y 2.5 segundos.
  int cooldown = 1500;

  // Tamaño para el texto animado
  double _size = 40;

  // Solución al error de múltiples clicks: cuando se clica se guarda un valor true en este bool que impide volver a clicar. Este valor vuelve a ser false al llamar de nuevo a las funciones de selección aleatoria.
  bool clicked = false;

  late String randomName;
  late Color randomColor;
  var colorNames = [
    'azul',
    'verde',
    'naranja',
    'rosa',
    'rojo',
    'amarillo',
    'turquesa'
  ];

  var colorHex = [
    const Color(0xFF0000FF),
    const Color(0xFF00FF00),
    const Color(0xFFFF914D),
    const Color(0xFFFF66C4),
    const Color(0xFFFF0000),
    const Color(0xFFFBC512),

    // Nuevo color: turquesa
    const Color.fromARGB(255, 29, 255, 187)
  ];

  @override
  void initState() {
    super.initState();
    getRandomColor();
    getRandomName();
    timer();
  }

  void timer() {
    Timer.periodic(Duration(milliseconds: cooldown), (timer) {
      clicked = false;
      getRandomColor();
      getRandomName();
      setState(() {});
    });
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
            appBar: AppBar(title: const Text('Actividad 10')),
            backgroundColor: Colors.white,
            body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Puntos: $points',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30)),
                  Center(
                      child: GestureDetector(
                          onTap: () {
                            onGiftTap(randomName, randomColor);
                          },
                          child: Column(children: [
                            Container(
                                width: 120, color: randomColor, height: 120),

                            // Animación: texto animado (tamaño cambia aleatoriamente con cada cambio de color)
                            AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 500),
                                style: TextStyle(
                                    color: randomColor,
                                    fontSize: _size,
                                    fontWeight: FontWeight.bold),
                                child: Text(randomName))
                          ])))
                ]),
            drawer: const MyDrawerApp()));
  }

  void getRandomColor() {
    // Cambiar 5 a 7 para que acepte los colores Amarillo y Turquesa también
    int randomNumber = random.nextInt(7);

    randomColor = colorHex[randomNumber];
  }

  void getRandomName() {
    int randomNumber = random.nextInt(7);
    randomName = colorNames[randomNumber];
  }

  String hexToStringConverter(Color hexColor) {
    if (hexColor == const Color(0xFF0000FF)) {
      return 'azul';
    } else if (hexColor == const Color(0xFF00FF00)) {
      return 'verde';
    } else if (hexColor == const Color(0xFFFF914D)) {
      return 'naranja';
    } else if (hexColor == const Color(0xFFFF66C4)) {
      return 'rosa';
    } else if (hexColor == const Color(0xFFFF0000)) {
      return 'rojo';
    } else if (hexColor == const Color.fromARGB(255, 29, 255, 187)) {
      return 'turquesa';
    } else {
      return 'amarillo';
    }
  }

  void onGiftTap(String name, Color color) {
    var colorToString = hexToStringConverter(color);
    if (name == colorToString && !clicked) {
      clicked = true;
      points++;
      if (cooldown >= 600) {
        cooldown -= 100;
      }
      // Animación de acierto
      _size = random.nextDouble() * 40 + 20;
    } else if (!clicked) {
      clicked = true;
      points--;
      if (cooldown <= 2400) {
        cooldown += 100;
      }
    }
    setState(() {});
  }
}
