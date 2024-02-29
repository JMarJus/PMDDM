import 'package:flutter/material.dart';

import '../exporter.dart';

class AnimatedSquare extends AnimatedWidget {
  AnimatedSquare(
      {super.key,
      required this.moveAnimation,
      required this.scaleAnimation,
      required this.tile,
      required this.child,
      required this.size})
      : super(listenable: Listenable.merge([moveAnimation, scaleAnimation]));

  final Square tile;
  final Widget child;
  final CurvedAnimation moveAnimation;
  final CurvedAnimation scaleAnimation;
  final double size;
  late final double _top = tile.getTop(size);
  late final double _left = tile.getLeft(size);
  late final double _nextTop = tile.getNextTop(size) ?? _top;
  late final double _nextLeft = tile.getNextLeft(size) ?? _left;

  late final Animation<double> top =
          Tween<double>(begin: _top, end: _nextTop).animate(moveAnimation),
      // Move / Squish effect
      left = Tween<double>(begin: _left, end: _nextLeft).animate(moveAnimation),
      // Merge / Pop effect
      scale = TweenSequence<double>(<TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
            tween: Tween<double>(begin: 1.0, end: 1.5)
                .chain(CurveTween(curve: Curves.easeOut)),
            weight: 50.0),
        TweenSequenceItem<double>(
            tween: Tween<double>(begin: 1.5, end: 1.0)
                .chain(CurveTween(curve: Curves.easeIn)),
            weight: 50.0)
      ]).animate(scaleAnimation);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: top.value,
        left: left.value,
        // Only use pop effect if the tile was merged
        child:
            tile.merged ? ScaleTransition(scale: scale, child: child) : child);
  }
}
