import 'package:flutter/material.dart';
import 'games/simonSays.dart';
import 'games/ticTacToe.dart';
import 'games/Game2048.dart';

class Gamepedia extends StatelessWidget {
  const Gamepedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      DrawerHeader(
          /*
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/fish.jpg"),
                  fit: BoxFit.cover),
              color: Colors.blueGrey),
              */
          child: Text("Gamepedia",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36))),
      ListTile(
          leading: FloatingActionButton(
              heroTag: "simonSays",
              child: Icon(Icons.api),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SimonSays();
                }));
              }),
          title: Text("Simon Says")),
      ListTile(
          leading: FloatingActionButton(
              heroTag: "2048",
              child: Icon(Icons.abc),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Game2048();
                }));
              }),
          title: Text("2048")),
      ListTile(
          leading: FloatingActionButton(
              heroTag: "ticTacToe",
              child: Icon(Icons.crop_sharp),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TicTacToe();
                }));
              }),
          title: Text("Tic Tac Toe"))
    ]));
  }
}
