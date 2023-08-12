import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_condition.g.dart';

/// {@template home_condition}
/// Modelo de condición de vivienda
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class HomeCondition extends Equatable {
  /// {@macro home_condition}
  const HomeCondition({
    required this.id,
    required this.inspectedHome,
    required this.reluctantDwelling,
    required this.closedHouse,
    required this.uninhabitedHouse,
    required this.housingSpotlights,
    required this.treatedHousing,
  });

  /// Crea una instancia de [HomeCondition] a partir de un [Map]
  factory HomeCondition.fromJson(Map<String, dynamic> json) =>
      _$HomeConditionFromJson(json);

  /// Crea un [Map] a partir de una instancia de [HomeCondition]
  Map<String, dynamic> toJson() => _$HomeConditionToJson(this);

  /// Id de la condición de vivienda
  final int id;

  /// Vivienda inspeccionada
  final int inspectedHome;

  /// Vivienda renuente
  final int reluctantDwelling;

  /// Vivienda cerrada
  final int closedHouse;

  /// Vivienda deshabitada
  final int uninhabitedHouse;

  /// Focos de vivienda
  final int housingSpotlights;

  /// Vivienda tratada
  final int treatedHousing;

  @override
  List<Object?> get props => [
        id,
        inspectedHome,
        reluctantDwelling,
        closedHouse,
        uninhabitedHouse,
        housingSpotlights,
        treatedHousing,
      ];
}
