// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeCondition _$HomeConditionFromJson(Map<String, dynamic> json) {
  return HomeCondition(
    id: json['id'] as int? ?? 0,
    inspectedHome: json['inspectedHome'] as int? ?? 0,
    reluctantDwelling: json['reluctantDwelling'] as int? ?? 0,
    closedHouse: json['closedHouse'] as int? ?? 0,
    uninhabitedHouse: json['uninhabitedHouse'] as int? ?? 0,
    housingSpotlights: json['housingSpotlights'] as int? ?? 0,
    treatedHousing: json['treatedHousing'] as int? ?? 0,
  );
}

Map<String, dynamic> _$HomeConditionToJson(HomeCondition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'inspectedHome': instance.inspectedHome,
      'reluctantDwelling': instance.reluctantDwelling,
      'closedHouse': instance.closedHouse,
      'uninhabitedHouse': instance.uninhabitedHouse,
      'housingSpotlights': instance.housingSpotlights,
      'treatedHousing': instance.treatedHousing,
    };
