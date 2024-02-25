import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';

import '../gamepedia.dart';
import 'Game2048/exporter.dart';

class Game2048 extends ConsumerStatefulWidget {
  const Game2048({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameState();

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Main menu')),
            drawer: const Gamepedia()));
  }
}

class _GameState extends ConsumerState<Game2048> with WidgetsBindingObserver {
  @override
  void initState() {
    //Add an Observer for the Lifecycles of the App
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
        autofocus: true,
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) {
          //Move the tile with the arrows on the keyboard on Desktop
        },
        child: SwipeDetector(
            onSwipe: (direction, offset) {
              //Move the tiles on Swipe on Android and iOS
            },
            child: Scaffold(
                backgroundColor: backgroundColor,
                body: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '2048',
                                  style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 52.0),
                                ),
                                Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const ScoreBoard(),
                                      const SizedBox(height: 32.0),
                                      Row(children: [
                                        ButtonWidget(
                                            icon: Icons.undo,
                                            onPressed: () {
                                              //Undo the round.
                                            }),
                                        const SizedBox(width: 16.0),
                                        ButtonWidget(
                                            icon: Icons.refresh,
                                            onPressed: () {
                                              //Restart the game
                                            })
                                      ])
                                    ])
                              ])),
                      const SizedBox(height: 32.0),
                      const Stack(children: [
                        EmptyBoardWidget(),
                        //TODO: Add the Tile Board Widget
                      ])
                    ]))));
  }
}
