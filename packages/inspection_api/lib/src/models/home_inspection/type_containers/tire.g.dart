// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tire.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tire _$TireFromJson(Map<String, dynamic> json) {
  return Tire(
    id: json['id'] as int? ?? 0,
    i: json['i'] as int? ?? 0,
    p: json['p'] as int? ?? 0,
    t: json['t'] as int? ?? 0,
  );
}

Map<String, dynamic> _$TireToJson(Tire instance) => <String, dynamic>{
      'id': instance.id,
      'i': instance.i,
      'p': instance.p,
      't': instance.t,
    };
