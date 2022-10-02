import 'package:equatable/equatable.dart';
import 'package:inspection_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'type_containers.g.dart';

/// {@template type_containers}
/// Modelo de tipo de contenedores
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class TypeContainers extends Equatable {
  /// {@macro type_containers}
  const TypeContainers({
    required this.elevatedTank,
    required this.lowTank,
    required this.cylinderBarrel,
    required this.bucketTub,
    required this.tire,
    required this.flower,
    required this.useless,
    required this.others,
  });

  /// Crea una instancia de [TypeContainers] a partir de un [json]
  factory TypeContainers.fromJson(Map<String, dynamic> json) =>
      _$TypeContainersFromJson(json);

  /// Crea un [json] a partir de una instancia de [TypeContainers]
  Map<String, dynamic> toJson() => _$TypeContainersToJson(this);

  /// Tanque elevado
  final ElevatedTank elevatedTank;

  /// Tanque bajo
  final LowTank lowTank;

  /// Barril de cilindro
  final CylinderBarrel cylinderBarrel;

  /// Tubo de cubeta
  final BucketTub bucketTub;

  /// Llanta
  final Tire tire;

  /// Florero
  final Flower flower;

  /// Desperdicios
  final Useless useless;

  /// Otros
  final Others others;

  @override
  List<Object?> get props => [
        elevatedTank,
        lowTank,
        cylinderBarrel,
        bucketTub,
        tire,
        flower,
        useless,
        others,
      ];
}
