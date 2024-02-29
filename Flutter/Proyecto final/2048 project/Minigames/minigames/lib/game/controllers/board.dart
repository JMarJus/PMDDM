import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../exporter.dart';

// List to get correct index after user swipes vertically
final verticalOrder = [12, 8, 4, 0, 13, 9, 5, 1, 14, 10, 6, 2, 15, 11, 7, 3];

final boardController = StateNotifierProvider<BoardController, Board>((ref) {
  return BoardController(ref);
});

class BoardController extends StateNotifier<Board> {
  final StateNotifierProviderRef ref;
  BoardController(this.ref) : super(Board.newGame(0, [])) {
    load();
  }

  void load() async {
    var box = await Hive.openBox<Board>('boardBox');
    state = box.get(0) ?? _newGame();
  }

  // Create New Game state.
  Board _newGame() {
    // Checks if the current score is higher than the best score to replace it on return.
    if (state.score > state.best) {
      return Board.newGame(state.score, [random([])]);
    } else {
      return Board.newGame(state.best, [random([])]);
    }
  }

  // Start New Game
  void newGame() {
    state = _newGame();
  }

  // Check whether the indexes are in the same row or column in the board.
  bool _inRange(index, nextIndex) {
    return index < 4 && nextIndex < 4 ||
        index >= 4 && index < 8 && nextIndex >= 4 && nextIndex < 8 ||
        index >= 8 && index < 12 && nextIndex >= 8 && nextIndex < 12 ||
        index >= 12 && nextIndex >= 12;
  }

  Square _calculate(Square square, List<Square> squares, direction) {
    bool asc =
        direction == SwipeDirection.left || direction == SwipeDirection.up;
    bool vert =
        direction == SwipeDirection.up || direction == SwipeDirection.down;
    int index = vert ? verticalOrder[square.index] : square.index;
    int nextIndex = ((index + 1) / 4).ceil() * 4 - (asc ? 4 : 1);

    // If the list of the new tiles to be rendered is not empty get the last tile
    // and if that tile is in the same row as the curren tile set the next index for the current tile to be after the last tile
    if (squares.isNotEmpty) {
      var last = squares.last;
      // If user swipes vertically use the verticalOrder list to retrieve the up/down index else use the existing index
      var lastIndex = last.nextIndex ?? last.index;
      lastIndex = vert ? verticalOrder[lastIndex] : lastIndex;
      if (_inRange(index, lastIndex)) {
        // If the order is ascending set the tile after the last processed tile
        // If the order is descending set the tile before the last processed tile
        nextIndex = lastIndex + (asc ? 1 : -1);
      }
    }

    // Return immutable copy of the current tile with the new next index
    // which can either be the top left index in the row or the last tile nextIndex/index + 1
    return square.copyWith(
        nextIndex: vert ? verticalOrder.indexOf(nextIndex) : nextIndex);
  }

  // Move the square in the direction
  bool move(SwipeDirection direction) {
    bool asc =
        direction == SwipeDirection.left || direction == SwipeDirection.up;
    bool vert =
        direction == SwipeDirection.up || direction == SwipeDirection.down;
    // Sort the list of tiles by index.
    // If user swipes vertically use the verticalOrder list to retrieve the up/down index
    state.squares.sort(((a, b) =>
        (asc ? 1 : -1) *
        (vert
            ? verticalOrder[a.index].compareTo(verticalOrder[b.index])
            : a.index.compareTo(b.index))));

    List<Square> squares = [];

    for (int i = 0, l = state.squares.length; i < l; i++) {
      var square = state.squares[i];

      // Calculate nextIndex for current square.
      square = _calculate(square, squares, direction);
      squares.add(square);

      if (i + 1 < l) {
        var next = state.squares[i + 1];
        // Assign current square nextIndex or index to the next tile if its allowed to be moved.
        if (square.value == next.value) {
          // If user swipes vertically use the verticalOrder list to retrieve the up/down index else use the existing index
          var index = vert ? verticalOrder[square.index] : square.index,
              nextIndex = vert ? verticalOrder[next.index] : next.index;
          if (_inRange(index, nextIndex)) {
            squares.add(next.copyWith(nextIndex: square.nextIndex));
            // Skip next iteration if next square was already assigned nextIndex.
            i += 1;
            continue;
          }
        }
      }
    }

    // Assign immutable copy of the new board state and trigger rebuild.
    state = state.copyWith(squares: squares, undo: state);
    return true;
  }

  // Generates tiles at random place on the board
  Square random(List<int> indexes) {
    var i = 0;
    var rng = Random();
    do {
      i = rng.nextInt(16);
    } while (indexes.contains(i));

    return Square(const Uuid().v4(), 2, i);
  }

  // Merge squares
  void merge() {
    List<Square> squares = [];
    var moved = false;
    List<int> indexes = [];
    var score = state.score;

    for (int i = 0, l = state.squares.length; i < l; i++) {
      var square = state.squares[i];

      var value = square.value, merged = false;

      if (i + 1 < l) {
        //sum the number of the two tiles with same index and mark the tile as merged and skip the next iteration.
        var next = state.squares[i + 1];
        if (square.nextIndex == next.nextIndex ||
            square.index == next.nextIndex && square.nextIndex == null) {
          value = square.value + next.value;
          merged = true;
          score += square.value;
          i += 1;
        }
      }

      if (merged ||
          square.nextIndex != null && square.index != square.nextIndex) {
        moved = true;
      }

      squares.add(square.copyWith(
          index: square.nextIndex ?? square.index,
          nextIndex: null,
          value: value,
          merged: merged));
      indexes.add(squares.last.index);
    }

    // If squares moved, generate a new square at random available position
    if (moved) {
      squares.add(random(indexes));
    }

    state = state.copyWith(score: score, squares: squares);
  }

  // Finish round
  void _endRound() {
    // The round ends assuming the game is over, and cancels this if any possible movement is detected
    var gameOver = true;
    List<Square> squares = [];

    // If the board is full
    if (state.squares.length == 16) {
      state.squares.sort(((a, b) => a.index.compareTo(b.index)));

      // For every square
      for (int i = 0, l = state.squares.length; i < l; i++) {
        var square = state.squares[i];
        var x = (i - (((i + 1) / 4).ceil() * 4 - 4));
        squares.add(square.copyWith(merged: false));

        // Square to the left can be merged
        if (x > 0 && i - 1 >= 0) {
          var left = state.squares[i - 1];
          if (square.value == left.value) {
            gameOver = false;
          }
        }

        // Square to the right can be merged
        if (x < 3 && i + 1 < l) {
          var right = state.squares[i + 1];
          if (square.value == right.value) {
            gameOver = false;
          }
        }

        // Square above can be merged
        if (i - 4 >= 0) {
          var top = state.squares[i - 4];
          if (square.value == top.value) {
            gameOver = false;
          }
        }

        // Square under can be merged
        if (i + 4 < l) {
          var bottom = state.squares[i + 4];
          if (square.value == bottom.value) {
            gameOver = false;
          }
        }
      }
    } else {
      // If the board is not full
      gameOver = false;
      for (var square in state.squares) {
        squares.add(square.copyWith(merged: false));
      }
    }

    // Copy the current state of the board for Undo
    state = state.copyWith(squares: squares, over: gameOver);
  }

  // Mark the merged as false after the merge animation is complete.
  bool endRound() {
    // End round
    _endRound();
    ref.read(roundManager.notifier).end();

    // If player moved too fast before the current animation/transition finished, start the move for the next direction
    var nextDirection = ref.read(nextDirectionManager);
    if (nextDirection != null) {
      move(nextDirection);
      ref.read(nextDirectionManager.notifier).clear();
      return true;
    }
    return false;
  }

  // Undo one round
  void undo() {
    // If previous state is not null
    if (state.undo != null) {
      state = state.copyWith(
          score: state.undo!.score,
          best: state.undo!.best,
          squares: state.undo!.squares);
    }
  }

  // Allows to move the squares using the arrow keys on the keyboard
  bool onKey(RawKeyEvent event) {
    SwipeDirection? direction;
    if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
      direction = SwipeDirection.right;
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
      direction = SwipeDirection.left;
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
      direction = SwipeDirection.up;
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
      direction = SwipeDirection.down;
    }

    if (direction != null) {
      move(direction);
      return true;
    }
    return false;
  }

  // Save data as JSON with Hive
  void save() async {
    var box = await Hive.openBox<Board>('boardBox');
    try {
      box.putAt(0, state);
    } catch (e) {
      box.add(state);
    }
  }
}
