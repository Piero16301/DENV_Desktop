import 'package:equatable/equatable.dart';
import 'package:inspection_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_inspection_detailed.g.dart';

/// {@template home_inspection_detailed}
/// Modelo de inspección de vivienda detallada
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class HomeInspectionDetailed extends Equatable {
  /// {@macro home_inspection_detailed}
  const HomeInspectionDetailed({
    required this.id,
    required this.address,
    required this.comment,
    required this.dateTime,
    required this.dni,
    required this.latitude,
    required this.longitude,
    required this.photoUrl,
    required this.numberInhabitants,
    required this.typeContainer,
    required this.homeCondition,
    required this.totalContainer,
    required this.aegyptiFocus,
    required this.larvicide,
  });

  /// Crea una instancia de [HomeInspectionDetailed] a partir de un [Map]
  factory HomeInspectionDetailed.fromJson(Map<String, dynamic> json) =>
      _$HomeInspectionDetailedFromJson(json);

  /// Crea un [Map] a partir de una instancia de [HomeInspectionDetailed]
  Map<String, dynamic> toJson() => _$HomeInspectionDetailedToJson(this);

  /// Id de la inspección
  final int id;

  /// Dirección
  final Address address;

  /// Comentario
  final String comment;

  /// Fecha de creación
  final DateTime dateTime;

  /// DNI del usuario
  final String dni;

  /// Latitud de la inspección
  final double latitude;

  /// Longitud de la inspección
  final double longitude;

  /// URL de la foto de la inspección
  final String photoUrl;

  /// Número de habitantes
  final int numberInhabitants;

  /// Tipo de contenedores
  final TypeContainer typeContainer;

  /// Condición de la vivienda
  final HomeCondition homeCondition;

  /// Total de contenedores
  final TotalContainer totalContainer;

  /// Foco de Aegypti
  final AegyptiFocus aegyptiFocus;

  /// Larvicida
  final double larvicide;

  @override
  List<Object?> get props => [
        id,
        address,
        comment,
        dateTime,
        dni,
        latitude,
        longitude,
        photoUrl,
        numberInhabitants,
        typeContainer,
        homeCondition,
        totalContainer,
        aegyptiFocus,
        larvicide,
      ];
}
