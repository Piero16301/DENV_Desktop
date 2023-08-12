// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_container.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeContainer _$TypeContainerFromJson(Map<String, dynamic> json) {
  return TypeContainer(
    id: json['id'] as int? ?? 0,
    elevatedTank: json['elevatedTank'] != null
        ? ElevatedTank.fromJson(json['elevatedTank'] as Map<String, dynamic>)
        : const ElevatedTank(id: 0, i: 0, p: 0, t: 0),
    lowTank: json['lowTank'] != null
        ? LowTank.fromJson(json['lowTank'] as Map<String, dynamic>)
        : const LowTank(id: 0, i: 0, p: 0, t: 0),
    cylinderBarrel: json['cylinderBarrel'] != null
        ? CylinderBarrel.fromJson(
            json['cylinderBarrel'] as Map<String, dynamic>,
          )
        : const CylinderBarrel(id: 0, i: 0, p: 0, t: 0),
    bucketTub: json['bucketTub'] != null
        ? BucketTub.fromJson(json['bucketTub'] as Map<String, dynamic>)
        : const BucketTub(id: 0, i: 0, p: 0, t: 0),
    tire: json['tire'] != null
        ? Tire.fromJson(json['tire'] as Map<String, dynamic>)
        : const Tire(id: 0, i: 0, p: 0, t: 0),
    flower: json['flower'] != null
        ? Flower.fromJson(json['flower'] as Map<String, dynamic>)
        : const Flower(id: 0, i: 0, p: 0, t: 0),
    useless: json['useless'] != null
        ? Useless.fromJson(json['useless'] as Map<String, dynamic>)
        : const Useless(id: 0, i: 0, p: 0, t: 0),
    others: json['others'] != null
        ? Others.fromJson(json['others'] as Map<String, dynamic>)
        : const Others(id: 0, i: 0, p: 0, t: 0),
  );
}

Map<String, dynamic> _$TypeContainerToJson(TypeContainer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'elevatedTank': instance.elevatedTank,
      'lowTank': instance.lowTank,
      'cylinderBarrel': instance.cylinderBarrel,
      'bucketTub': instance.bucketTub,
      'tire': instance.tire,
      'flower': instance.flower,
      'useless': instance.useless,
      'others': instance.others,
    };
