import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../exporter.dart';

class Score extends StatelessWidget {
  const Score(
      {Key? key, required this.label, required this.score, this.padding})
      : super(key: key);

  final String label;
  final String score;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: scoreColor, borderRadius: BorderRadius.circular(8)),
        child: Column(children: [
          Text(label.toUpperCase(),
              style: const TextStyle(fontSize: 16, color: color2)),
          Text(
            score,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          )
        ]));
  }
}

class ScoreBoard extends ConsumerWidget {
  const ScoreBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(boardController.select((board) => board.score));
    final best = ref.watch(boardController.select((board) => board.best));

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Score(label: 'Score', score: '$score'),
      const SizedBox(
        width: 8,
      ),
      Score(
          label: 'Best',
          score: '$best',
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8))
    ]);
  }
}
