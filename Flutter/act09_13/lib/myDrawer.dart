import 'package:flutter/material.dart';
import 'main.dart';
import 'act10.dart';
import 'act11.dart';
import 'act12.dart';

class MyDrawerApp extends StatelessWidget {
  const MyDrawerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      const DrawerHeader(
          child: Text("Drawer de actividades",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36))),
      ListTile(
          leading: FloatingActionButton(
              heroTag: "09",
              child: const Icon(Icons.api),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const MainApp();
                }));
              }),
          title: const Text("Actividad 09")),
      ListTile(
          leading: FloatingActionButton(
              heroTag: "10",
              child: const Icon(Icons.api),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const Act10App();
                }));
              }),
          title: const Text("Actividad 10")),
      ListTile(
          leading: FloatingActionButton(
              heroTag: "11",
              child: const Icon(Icons.api),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Act11AppStateful();
                }));
              }),
          title: const Text("Actividad 11")),
      ListTile(
          leading: FloatingActionButton(
              heroTag: "12",
              child: const Icon(Icons.api),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const Act12App();
                }));
              }),
          title: const Text("Actividad 12"))
    ]));
  }
}
