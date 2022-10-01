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
    required this.inspectedHome,
    required this.reluctantDwelling,
    required this.closedHome,
    required this.uninhabitedHouse,
    required this.housingSpotlights,
    required this.treatedHousing,
  });

  /// Crea una instancia de [HomeCondition] a partir de un [json]
  factory HomeCondition.fromJson(Map<String, dynamic> json) =>
      _$HomeConditionFromJson(json);

  /// Vivienda inspeccionada
  final int inspectedHome;

  /// Vivienda renuente
  final int reluctantDwelling;

  /// Vivienda cerrada
  final int closedHome;

  /// Vivienda deshabitada
  final int uninhabitedHouse;

  /// Focos de vivienda
  final int housingSpotlights;

  /// Vivienda tratada
  final int treatedHousing;

  @override
  List<Object?> get props => [
        inspectedHome,
        reluctantDwelling,
        closedHome,
        uninhabitedHouse,
        housingSpotlights,
        treatedHousing,
      ];
}
