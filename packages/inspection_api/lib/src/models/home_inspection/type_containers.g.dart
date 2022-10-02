// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_containers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeContainers _$TypeContainersFromJson(Map<String, dynamic> json) {
  return TypeContainers(
    elevatedTank:
        ElevatedTank.fromJson(json['elevatedtank'] as Map<String, dynamic>),
    lowTank: LowTank.fromJson(json['lowtank'] as Map<String, dynamic>),
    cylinderBarrel:
        CylinderBarrel.fromJson(json['cylinderbarrel'] as Map<String, dynamic>),
    bucketTub: BucketTub.fromJson(json['buckettub'] as Map<String, dynamic>),
    tire: Tire.fromJson(json['tire'] as Map<String, dynamic>),
    flower: Flower.fromJson(json['flower'] as Map<String, dynamic>),
    useless: Useless.fromJson(json['useless'] as Map<String, dynamic>),
    others: Others.fromJson(json['others'] as Map<String, dynamic>),
  );
}
