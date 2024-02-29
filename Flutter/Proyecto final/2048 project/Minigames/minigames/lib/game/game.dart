import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';

import 'exporter.dart';
import '../main.dart';

class Game extends ConsumerStatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameState();
}

class _GameState extends ConsumerState<Game>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  // The contoller used to move the the squares
  late final AnimationController _moveController = AnimationController(
      duration: const Duration(milliseconds: 128), vsync: this)
    ..addStatusListener((status) {
      // After movement finishes, merge the squares and start the pop animation
      if (status == AnimationStatus.completed) {
        ref.read(boardController.notifier).merge();
        _scaleController.forward(from: 0);
      }
    });

  // The curve animation for the move animation controller.
  late final CurvedAnimation _moveAnimation =
      CurvedAnimation(parent: _moveController, curve: Curves.easeInOut);

  // The controller used to show a popup effect when the tiles get merged
  late final AnimationController _scaleController = AnimationController(
      duration: const Duration(milliseconds: 256), vsync: this)
    ..addStatusListener((status) {
      //When the scale animation finishes end the round and if there is a queued movement start the move controller again for the next direction.
      if (status == AnimationStatus.completed) {
        if (ref.read(boardController.notifier).endRound()) {
          _moveController.forward(from: 0);
        }
      }
    });

  // The curve animation for the scale animation controller.
  late final CurvedAnimation _scaleAnimation =
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut);

  @override
  void initState() {
    // Add an Observer for the Lifecycles of the App
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    // Remove the Observer for the Lifecycles of the App
    WidgetsBinding.instance.removeObserver(this);

    // Dispose the animations.
    _moveAnimation.dispose();
    _scaleAnimation.dispose();
    _moveController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Save current state when the app becomes inactive
    if (state == AppLifecycleState.inactive) {
      ref.read(boardController.notifier).save();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
        autofocus: true,
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) {
          // Move the squares with the keyboard arrows on Desktop mode
          if (ref.read(boardController.notifier).onKey(event)) {
            _moveController.forward(from: 0);
          }
        },
        child: SwipeDetector(
            onSwipe: (direction, offset) {
              if (ref.read(boardController.notifier).move(direction)) {
                _moveController.forward(from: 0);
              }
            },
            child: Scaffold(
                backgroundColor: backgroundColor,
                body: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Padding(
                              padding: const EdgeInsets.all(16),
                              // The top row of the game screen
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Score
                                    const ScoreBoard(),
                                    const SizedBox(width: 16),

                                    // Undo, Restart, Exit
                                    Button(
                                        icon: Icons.undo,
                                        onPressed: () {
                                          // Undo one round
                                          ref
                                              .read(boardController.notifier)
                                              .undo();
                                        }),
                                    Button(
                                        icon: Icons.refresh,
                                        onPressed: () {
                                          // Restart the game
                                          ref
                                              .read(boardController.notifier)
                                              .newGame();
                                        }),
                                    Button(
                                        icon: Icons.exit_to_app,
                                        onPressed: () {
                                          // Save first
                                          ref
                                              .read(boardController.notifier)
                                              .save();
                                          // Exit to main menu
                                          runApp(const ProviderScope(
                                              child: MaterialApp(
                                                  title: '2048',
                                                  home: MainApp())));
                                        })
                                  ]))),
                      Stack(children: [
                        const EmptyBoard(),
                        SquareBoard(
                            moveAnimation: _moveAnimation,
                            scaleAnimation: _scaleAnimation)
                      ])
                    ]))));
  }
}
