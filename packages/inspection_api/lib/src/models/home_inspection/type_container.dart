import 'package:equatable/equatable.dart';
import 'package:inspection_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'type_container.g.dart';

/// {@template type_containers}
/// Modelo de tipo de contenedores
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class TypeContainer extends Equatable {
  /// {@macro type_containers}
  const TypeContainer({
    required this.id,
    required this.elevatedTank,
    required this.lowTank,
    required this.cylinderBarrel,
    required this.bucketTub,
    required this.tire,
    required this.flower,
    required this.useless,
    required this.others,
  });

  /// Crea una instancia de [TypeContainer] a partir de un [Map]
  factory TypeContainer.fromJson(Map<String, dynamic> json) =>
      _$TypeContainerFromJson(json);

  /// Crea un [Map] a partir de una instancia de [TypeContainer]
  Map<String, dynamic> toJson() => _$TypeContainerToJson(this);

  /// Id del tipo de contenedor
  final int id;

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
        id,
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
