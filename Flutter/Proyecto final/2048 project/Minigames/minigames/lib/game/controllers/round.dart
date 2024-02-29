import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';

final roundManager = StateNotifierProvider<RoundManager, bool>((ref) {
  return RoundManager();
});

final nextDirectionManager =
    StateNotifierProvider<NextDirectionManager, SwipeDirection?>((ref) {
  return NextDirectionManager();
});

class RoundManager extends StateNotifier<bool> {
  RoundManager() : super(true);

  void end() {
    state = true;
  }

  void begin() {
    state = false;
  }
}

class NextDirectionManager extends StateNotifier<SwipeDirection?> {
  NextDirectionManager() : super(null);

  void queue(direction) {
    state = direction;
  }

  void clear() {
    state = null;
  }
}
