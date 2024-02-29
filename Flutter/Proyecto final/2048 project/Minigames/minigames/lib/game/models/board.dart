import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../exporter.dart';

part 'board.g.dart';

// The board, only the model
class EmptyBoard extends StatelessWidget {
  const EmptyBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Decides the maximum size the Board can be based on the shortest size of the screen
    final size = max(
        290,
        min((MediaQuery.of(context).size.shortestSide * 0.9).floorToDouble(),
            460));

    // Decide the size of the tile based on the size of the board minus the space between each square
    final sizePerSquare = (size / 4).floorToDouble();
    final squareSize = sizePerSquare - 12 - (12 / 4);
    final boardSize = sizePerSquare * 4;
    return Container(
        width: boardSize,
        height: boardSize,
        decoration: BoxDecoration(
            color: boardColor, borderRadius: BorderRadius.circular(4)),
        child: Stack(
            children: List.generate(16, (i) {
          //Render the empty board in 4x4 GridView
          var x = ((i + 1) / 4).ceil();
          var y = x - 1;
          var top = y * (squareSize) + (x * 12);
          var z = (i - (4 * y));
          var left = z * (squareSize) + ((z + 1) * 12);

          return Positioned(
              top: top,
              left: left,
              child: Container(
                width: squareSize,
                height: squareSize,
                decoration: BoxDecoration(
                    color: emptyColor, borderRadius: BorderRadius.circular(4)),
              ));
        })));
  }
}

// The board, according to controllers and data
@JsonSerializable(explicitToJson: true, anyMap: true)
class Board {
  // Current score on the playing board
  final int score;

  // Best score so far
  final int best;

  // List of current squares on the board
  final List<Square> squares;

  // Whether the game is over or not
  final bool over;

  // Keeps the previous round's board so it can be returned to with Undo
  final Board? undo;

  Board(this.score, this.best, this.squares, {this.over = false, this.undo});

  // Empty model for a new game
  Board.newGame(this.best, this.squares)
      : score = 0,
        over = false,
        undo = null;

  // Create an immutable copy of the board for Undo
  Board copyWith(
          {int? score,
          int? best,
          List<Square>? squares,
          bool? over,
          Board? undo}) =>
      Board(score ?? this.score, best ?? this.best, squares ?? this.squares,
          over: over ?? this.over, undo: undo ?? this.undo);

// Create a Board from JSON data
  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);

// Generate JSON data from the current Board
  Map<String, dynamic> toJson() => _$BoardToJson(this);
}

// The board, according to squares and screen size
class SquareBoard extends ConsumerWidget {
  const SquareBoard(
      {super.key, required this.moveAnimation, required this.scaleAnimation});

  final CurvedAnimation moveAnimation;
  final CurvedAnimation scaleAnimation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final board = ref.watch(boardController);

    // Calculations for the size of the game's board and squares, depending on screen size
    final size = max(
        290,
        min((MediaQuery.of(context).size.shortestSide * 0.9).floorToDouble(),
            460));
    final sizePerSquare = (size / 4).floorToDouble();
    final squareSize = sizePerSquare - 12 - (12 / 4);
    final boardSize = sizePerSquare * 4;

    return SizedBox(
        width: boardSize,
        height: boardSize,
        child: Stack(children: [
          ...List.generate(board.squares.length, (i) {
            var square = board.squares[i];

            return AnimatedSquare(
                key: ValueKey(square.id),
                tile: square,
                moveAnimation: moveAnimation,
                scaleAnimation: scaleAnimation,
                size: squareSize,
                child: Container(
                    width: squareSize,
                    height: squareSize,
                    decoration: BoxDecoration(
                        color: tileColors[square.value],
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                        child: Text('${square.value}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: square.value < 8
                                    ? textColor
                                    : textColorWhite)))));
          }),
          if (board.over)
            Positioned.fill(
                child: Container(
                    color: overlayColor,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Game over!',
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 64)),
                          Button(
                              text: 'Try again',
                              onPressed: () {
                                ref.read(boardController.notifier).newGame();
                              })
                        ])))
        ]));
  }
}
