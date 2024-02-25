import 'dart:math';

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
      home: const AnimatedContainerApp(),
    );
  }
}

// Empleando la clase AnimatedContainerApp (parent: StatefulWidget) podemos generar contenedores que tengan una animación al ser modificados
class AnimatedContainerApp extends StatefulWidget {
  const AnimatedContainerApp({super.key});

  @override
  State<AnimatedContainerApp> createState() => AnimatedContainerAppState();
}

// La clase ejecutada será creada a partir de la clase AnimatedContainerApp para permitir la creación de estos contenedores especiales
class AnimatedContainerAppState extends State<AnimatedContainerApp> {
  // Valores iniciales del contenedor
  double varWidth = 256;
  double varHeight = 256;
  Color varColor = Colors.yellow;
  BorderRadiusGeometry varRadius = BorderRadius.circular(16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text("Contenedor animado")),

        // Establecemos las variables el contenedor anotadas al principio de esta clase
        body: Center(
            child: AnimatedContainer(
                width: varWidth,
                height: varHeight,
                decoration: BoxDecoration(
                  color: varColor,
                  borderRadius: varRadius,
                ),
                // Esta será la duración de la animación durante el cambio de forma
                duration: const Duration(seconds: 2),
                curve: Curves.fastOutSlowIn)),

        // Cada vez que se presione este botón, el contenedor cambiará de tamaño de forma aleatoria acompañado de una animación
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              final random = Random();
              varWidth = random.nextInt(300).toDouble();
              varHeight = random.nextInt(300).toDouble();
              varColor = Color.fromRGBO(
                random.nextInt(256),
                random.nextInt(256),
                random.nextInt(256),
                1,
              );
              varRadius = BorderRadius.circular(random.nextInt(100).toDouble());
            });
          },

          // Este widget da al botón un icono de flecha sin línea
          child: const Icon(Icons.play_arrow),
        ));
  }
}
