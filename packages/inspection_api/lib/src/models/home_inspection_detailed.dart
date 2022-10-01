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
  });

  /// Crea una instancia de [HomeInspectionDetailed] a partir de un [json]
  factory HomeInspectionDetailed.fromJson(Map<String, dynamic> json) =>
      _$HomeInspectionDetailedFromJson(json);

  /// Id de la inspección
  final String id;

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

  @override
  List<Object?> get props => [address];
}
