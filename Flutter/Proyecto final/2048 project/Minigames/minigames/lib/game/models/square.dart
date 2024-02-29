import 'package:json_annotation/json_annotation.dart';

part 'square.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class Square {
  // Unique ID
  final String id;

  // Value (2, 4, 8, 16...)
  final int value;

  // Current index of the square (position in the board)
  final int index;

  // Next index after a round/move
  final int? nextIndex;

  // If the tile has been merged
  final bool merged;

  Square(this.id, this.value, this.index,
      {this.nextIndex, this.merged = false});

  // Calculates the current top position based on the current index
  double getTop(double size) {
    var i = ((index + 1) / 4).ceil();
    return ((i - 1) * size) + (12 * i);
  }

  // Calculates the current left position based on the current index
  double getLeft(double size) {
    var i = (index - (((index + 1) / 4).ceil() * 4 - 4));
    return (i * size) + (12 * (i + 1));
  }

  // Calculates the next top position based on the next index
  double? getNextTop(double size) {
    if (nextIndex == null) return null;
    var i = ((nextIndex! + 1) / 4).ceil();
    return ((i - 1) * size) + (12 * i);
  }

  // Calculates the next left position based on the next index
  double? getNextLeft(double size) {
    if (nextIndex == null) return null;
    var i = (nextIndex! - (((nextIndex! + 1) / 4).ceil() * 4 - 4));
    return (i * size) + (12.0 * (i + 1));
  }

  // Creates a copy of the square for Undo
  Square copyWith(
          {String? id, int? value, int? index, int? nextIndex, bool? merged}) =>
      Square(id ?? this.id, value ?? this.value, index ?? this.index,
          nextIndex: nextIndex ?? this.nextIndex,
          merged: merged ?? this.merged);

  // Creates square from JSON data
  factory Square.fromJson(Map<String, dynamic> json) => _$SquareFromJson(json);

  // Creates JSON data from square
  Map<String, dynamic> toJson() => _$SquareToJson(this);
}
