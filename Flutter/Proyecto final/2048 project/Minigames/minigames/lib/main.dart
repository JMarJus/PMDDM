import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'game/exporter.dart';
import 'game/game.dart';

void main() async {
  // Allow only portrait mode on Android & iOS
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Make sure Hive is initialized first and only after register the adapter. This will allow for persistence of best score.
  await Hive.initFlutter();
  Hive.registerAdapter(BoardAdapter());

  // When the app starts, run the MainApp screen
  runApp(
      const ProviderScope(child: MaterialApp(title: '2048', home: MainApp())));
}

// Title screen of the game
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: backgroundColor,
            body: Center(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('2048',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 64,
                                  fontWeight: FontWeight.bold,
                                  color: textColor)),
                          const SizedBox(height: 16),
                          const Text('A swiping, exponential puzzle game',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: textColor)),
                          const SizedBox(height: 40),
                          Button(
                              text: 'Start game',
                              onPressed: () {
                                // This will run the game
                                runApp(const ProviderScope(
                                    child: MaterialApp(
                                        title: '2048', home: Game())));
                              }),
                          const SizedBox(height: 16),
                          Button(
                              text: 'Exit game',
                              onPressed: () {
                                // This is the recommended way of exiting an app in ANDROID
                                SystemNavigator.pop();
                              }),
                          const SizedBox(height: 43),
                          // Credits
                          const Text('By Juan Martínez Justicia',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: textColor))
                        ])))));
  }
}
