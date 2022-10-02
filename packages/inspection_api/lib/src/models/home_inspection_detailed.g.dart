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
    dateTime: DateTime.parse(json['dateTime'] as String),
    dni: json['dni'] as String,
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    photoUrl: json['photoUrl'] as String,
    numberInhabitants: json['numberInhabitants'] as int,
    homeCondition: HomeCondition.fromJson(
      json['homecondition'] as Map<String, dynamic>,
    ),
    typeContainers: TypeContainers.fromJson(
      json['typecontainers'] as Map<String, dynamic>,
    ),
    totalContainer: TotalContainer.fromJson(
      json['totalcontainer'] as Map<String, dynamic>,
    ),
    aegyptiFocus: AegyptiFocus.fromJson(
      json['aegyptifocus'] as Map<String, dynamic>,
    ),
    larvicide: (json['larvicide'] as num).toDouble(),
  );
}
