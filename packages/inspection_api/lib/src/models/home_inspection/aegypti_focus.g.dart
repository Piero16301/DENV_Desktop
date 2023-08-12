// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aegypti_focus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AegyptiFocus _$AegyptiFocusFromJson(Map<String, dynamic> json) {
  return AegyptiFocus(
    id: json['id'] as int? ?? 0,
    larvae: json['larvae'] as int? ?? 0,
    pupae: json['pupae'] as int? ?? 0,
    adult: json['adult'] as int? ?? 0,
  );
}

Map<String, dynamic> _$AegyptiFocusToJson(AegyptiFocus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'larvae': instance.larvae,
      'pupae': instance.pupae,
      'adult': instance.adult,
    };
