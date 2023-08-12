// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_inspection_detailed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeInspectionDetailed _$HomeInspectionDetailedFromJson(
  Map<String, dynamic> json,
) {
  return HomeInspectionDetailed(
    id: json['id'] as int? ?? 0,
    address: json['address'] != null
        ? Address.fromJson(json['address'] as Map<String, dynamic>)
        : const Address(
            id: 0,
            formattedAddress: '',
            postalCode: '',
            country: '',
            department: '',
            province: '',
            district: '',
            urbanization: '',
            street: '',
            block: '',
            lot: '',
            streetNumber: '',
          ),
    comment: json['comment'] as String,
    dateTime: DateTime.parse(
      json['datetime'] as String? ?? '0000-00-00T00:00:00-00:00',
    ).toLocal(),
    dni: json['dni'] as String? ?? '',
    latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
    longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
    photoUrl: json['photoUrl'] as String? ?? '',
    numberInhabitants: json['numberInhabitants'] as int? ?? 0,
    typeContainer: json['typeContainer'] != null
        ? TypeContainer.fromJson(
            json['typeContainer'] as Map<String, dynamic>,
          )
        : const TypeContainer(
            id: 0,
            elevatedTank: ElevatedTank(id: 0, i: 0, p: 0, t: 0),
            lowTank: LowTank(id: 0, i: 0, p: 0, t: 0),
            cylinderBarrel: CylinderBarrel(id: 0, i: 0, p: 0, t: 0),
            bucketTub: BucketTub(id: 0, i: 0, p: 0, t: 0),
            tire: Tire(id: 0, i: 0, p: 0, t: 0),
            flower: Flower(id: 0, i: 0, p: 0, t: 0),
            useless: Useless(id: 0, i: 0, p: 0, t: 0),
            others: Others(id: 0, i: 0, p: 0, t: 0),
          ),
    homeCondition: json['homeCondition'] != null
        ? HomeCondition.fromJson(
            json['homeCondition'] as Map<String, dynamic>,
          )
        : const HomeCondition(
            id: 0,
            inspectedHome: 0,
            reluctantDwelling: 0,
            closedHouse: 0,
            uninhabitedHouse: 0,
            housingSpotlights: 0,
            treatedHousing: 0,
          ),
    totalContainer: json['totalContainer'] != null
        ? TotalContainer.fromJson(
            json['totalContainer'] as Map<String, dynamic>,
          )
        : const TotalContainer(
            id: 0,
            inspectedContainers: 0,
            containersSpotlights: 0,
            treatedContainers: 0,
            destroyedContainers: 0,
          ),
    aegyptiFocus: json['aegyptiFocus'] != null
        ? AegyptiFocus.fromJson(
            json['aegyptiFocus'] as Map<String, dynamic>,
          )
        : const AegyptiFocus(id: 0, larvae: 0, pupae: 0, adult: 0),
    larvicide: (json['larvicide'] as num?)?.toDouble() ?? 0.0,
  );
}

Map<String, dynamic> _$HomeInspectionDetailedToJson(
  HomeInspectionDetailed instance,
) =>
    <String, dynamic>{
      'id': instance.id,
      'address': instance.address.toJson(),
      'comment': instance.comment,
      'datetime': instance.dateTime.toIso8601String(),
      'dni': instance.dni,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'photoUrl': instance.photoUrl,
      'numberInhabitants': instance.numberInhabitants,
      'typeContainer': instance.typeContainer.toJson(),
      'homeCondition': instance.homeCondition.toJson(),
      'totalContainer': instance.totalContainer.toJson(),
      'aegyptiFocus': instance.aegyptiFocus.toJson(),
      'larvicide': instance.larvicide,
    };
