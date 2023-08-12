// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flower.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Flower _$FlowerFromJson(Map<String, dynamic> json) {
  return Flower(
    id: json['id'] as int? ?? 0,
    i: json['i'] as int? ?? 0,
    p: json['p'] as int? ?? 0,
    t: json['t'] as int? ?? 0,
  );
}

Map<String, dynamic> _$FlowerToJson(Flower instance) => <String, dynamic>{
      'id': instance.id,
      'i': instance.i,
      'p': instance.p,
      't': instance.t,
    };
