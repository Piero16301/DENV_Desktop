// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aegypti_focus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AegyptiFocus _$AegyptiFocusFromJson(Map<String, dynamic> json) {
  return AegyptiFocus(
    larvae: json['larvae'] as int,
    pupae: json['pupae'] as int,
    adult: json['adult'] as int,
  );
}

Map<String, dynamic> _$AegyptiFocusToJson(AegyptiFocus instance) =>
    <String, dynamic>{
      'larvae': instance.larvae,
      'pupae': instance.pupae,
      'adult': instance.adult,
    };
