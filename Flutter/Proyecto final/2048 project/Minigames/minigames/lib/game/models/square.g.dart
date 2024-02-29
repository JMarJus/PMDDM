// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'square.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Square _$SquareFromJson(Map json) => Square(
      json['id'] as String,
      json['value'] as int,
      json['index'] as int,
      nextIndex: json['nextIndex'] as int?,
      merged: json['merged'] as bool? ?? false,
    );

Map<String, dynamic> _$SquareToJson(Square instance) => <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'index': instance.index,
      'nextIndex': instance.nextIndex,
      'merged': instance.merged,
    };
