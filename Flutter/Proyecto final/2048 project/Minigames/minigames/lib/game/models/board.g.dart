// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Board _$BoardFromJson(Map json) => Board(
      json['score'] as int,
      json['best'] as int,
      (json['squares'] as List<dynamic>)
          .map((e) => Square.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      over: json['over'] as bool? ?? false,
      undo: json['undo'] == null
          ? null
          : Board.fromJson(Map<String, dynamic>.from(json['undo'] as Map)),
    );

Map<String, dynamic> _$BoardToJson(Board instance) => <String, dynamic>{
      'score': instance.score,
      'best': instance.best,
      'squares': instance.squares.map((e) => e.toJson()).toList(),
      'over': instance.over,
      'undo': instance.undo?.toJson(),
    };
