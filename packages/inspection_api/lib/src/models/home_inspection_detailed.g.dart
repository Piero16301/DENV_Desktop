// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_inspection_detailed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeInspectionDetailed _$HomeInspectionDetailedFromJson(
    Map<String, dynamic> json) {
  return HomeInspectionDetailed(
    id: json['id'] as String,
    address: Address.fromJson(json['address'] as Map<String, dynamic>),
    comment: json['comment'] as String,
    dateTime: DateTime.parse(json['datetime'] as String),
    dni: json['dni'] as String,
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    photoUrl: json['photourl'] as String,
    numberInhabitants: json['numberinhabitants'] as int,
  );
}
