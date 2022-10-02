// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeCondition _$HomeConditionFromJson(Map<String, dynamic> json) {
  return HomeCondition(
    inspectedHome: json['inspectedhome'] as int,
    reluctantDwelling: json['reluctantdwelling'] as int,
    closedHome: json['closedhome'] as int,
    uninhabitedHouse: json['uninhabitedhouse'] as int,
    housingSpotlights: json['housingspotlights'] as int,
    treatedHousing: json['treatedhousing'] as int,
  );
}

Map<String, dynamic> _$HomeConditionToJson(HomeCondition instance) =>
    <String, dynamic>{
      'inspectedhome': instance.inspectedHome,
      'reluctantdwelling': instance.reluctantDwelling,
      'closedhome': instance.closedHome,
      'uninhabitedhouse': instance.uninhabitedHouse,
      'housingspotlights': instance.housingSpotlights,
      'treatedhousing': instance.treatedHousing,
    };
