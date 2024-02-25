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
      home: const MyHomePage(title: 'Font personalizado y repliegue de texto'),
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
        body: const Center(
            child:
                // Usamos la propiedad Flexible (aplicable a Column, Row y Flex) para permitir que el texto se repliegue cuando se desborda
                Text(
                    'You have pushed the button this many times. also lore ipsum etc no mé sé el lore ipsum y me da un poco de pereza ponerme a buscarlo así q relleno con lo q me vaya saliendo. Acabo de comprobar y por lo que parece con este último trozo de texto se verá ya partido en dos líneas desde el principio sin necesidad de cambiar el tamaño de la pestaña (aunque se pueda seguir haciendo para replegar aún más el texto). bue ya he perdido la cuenta',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.black,
                        fontSize: 32),
                    maxLines: 9,
                    overflow: TextOverflow.ellipsis)));
  }
}
