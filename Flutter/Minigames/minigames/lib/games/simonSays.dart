import 'dart:math';

import 'package:flutter/material.dart';
import '../gamepedia.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SimonSays());
  }
}

class SimonSays extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SimonSaysState();
}

class SimonSaysState extends State<SimonSays> {
  Color water = Colors.blue;
  Color air = Colors.green;
  Color blaze = Colors.orange;
  Color soil = Colors.brown;

  int btnWater = 0;
  int btnAir = 1;
  int btnBlaze = 2;
  int btnSoil = 3;

  int round = 0;
  int turn = 0;

  double hVar = 128;
  double wVar = 128;

  List<int> simonSays = new List.empty(growable: true);
  List<int> pressedButtons = new List.empty(growable: true);
  List<Color> buttons = new List.empty(growable: false);

  Random random = new Random();

  changeColor(Color oldColor, Color newColor) async {
    setState(() {
      if (oldColor == water) {
        water = newColor;
      }
      if (oldColor == air) {
        air = newColor;
      }
      if (oldColor == blaze) {
        blaze = newColor;
      }
      if (oldColor == soil) {
        soil = newColor;
      }
    });
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      if (newColor == water) {
        water = oldColor;
      }
      if (newColor == air) {
        air = oldColor;
      }
      if (newColor == blaze) {
        blaze = oldColor;
      }
      if (newColor == soil) {
        soil = oldColor;
      }
    });
  }

  newRound() async {
    buttons = [water, air, blaze, soil];
    print("- new round -");
    round++;
    simonSays.clear();
    pressedButtons.clear();
    for (int i = 0; i < round; i++) {
      int nextColor = random.nextInt(4);
      await Future.delayed(const Duration(milliseconds: 400));
      changeColor(buttons[nextColor], Colors.black);
      simonSays.add(nextColor);
    }
    turn++;
  }

  win() async {
    print("- win -");
    turn = 0;
    await Future.delayed(const Duration(milliseconds: 300));
    for (int i = 0; i < 4; i++) {
      changeColor(buttons[i], Colors.white);
      await Future.delayed(const Duration(milliseconds: 300));
    }
    newRound();
  }

  lose(int correctColor) async {
    print("- lose -");
    turn = 0;
    round = 0;
    await Future.delayed(const Duration(milliseconds: 300));
    for (int i = 0; i < 4; i++) {
      changeColor(buttons[i], Colors.black);
      await Future.delayed(const Duration(milliseconds: 300));
    }
    newRound();
  }

  pressed(int color) async {
    print("- press -");
    pressedButtons.add(color);
    if (simonSays[turn - 1] != pressedButtons[turn - 1]) {
      lose(simonSays[turn - 1]);
    } else if (turn >= simonSays.length) {
      win();
    } else {
      turn++;
    }
  }

  roundZero() {
    round = 0;
    turn = 0;
    newRound();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Simon Says')),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Text("Current round: ${round}"),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                              width: wVar,
                              height: hVar,
                              decoration: BoxDecoration(color: water),
                              duration: const Duration(seconds: 2),
                              curve: Curves.fastOutSlowIn,
                              margin: EdgeInsets.all(4),
                              child: FloatingActionButton(
                                  heroTag: "blue",
                                  onPressed: () {
                                    pressed(0);
                                  },
                                  shape: BeveledRectangleBorder(),
                                  backgroundColor: water)),
                          AnimatedContainer(
                              width: wVar,
                              height: hVar,
                              decoration: BoxDecoration(color: blaze),
                              duration: const Duration(seconds: 2),
                              curve: Curves.fastOutSlowIn,
                              margin: EdgeInsets.all(4),
                              child: FloatingActionButton(
                                  heroTag: "orange",
                                  onPressed: () {
                                    pressed(2);
                                  },
                                  shape: BeveledRectangleBorder(),
                                  backgroundColor: blaze))
                        ]),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                              width: wVar,
                              height: hVar,
                              decoration: BoxDecoration(color: air),
                              duration: const Duration(seconds: 2),
                              curve: Curves.fastOutSlowIn,
                              margin: EdgeInsets.all(4),
                              child: FloatingActionButton(
                                  heroTag: "green",
                                  onPressed: () {
                                    pressed(1);
                                  },
                                  shape: BeveledRectangleBorder(),
                                  backgroundColor: air)),
                          AnimatedContainer(
                              width: wVar,
                              height: hVar,
                              decoration: BoxDecoration(color: soil),
                              duration: const Duration(seconds: 2),
                              curve: Curves.fastOutSlowIn,
                              margin: EdgeInsets.all(4),
                              child: FloatingActionButton(
                                  heroTag: "brown",
                                  onPressed: () {
                                    pressed(3);
                                  },
                                  shape: BeveledRectangleBorder(),
                                  backgroundColor: soil))
                        ])
                  ]),
              FloatingActionButton(
                  heroTag: "zero",
                  onPressed: () {
                    roundZero();
                  },
                  child: const Icon(Icons.not_started_outlined))
            ])),
        drawer: Gamepedia());
  }
}
