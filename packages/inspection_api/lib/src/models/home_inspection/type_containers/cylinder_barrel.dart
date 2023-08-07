import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cylinder_barrel.g.dart';

/// {@template elevated_tank}
/// Modelo de barril de cilindro
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class CylinderBarrel extends Equatable {
  /// {@macro elevated_tank}
  const CylinderBarrel({
    required this.i,
    required this.p,
    required this.t,
  });

  /// Crea una instancia de [CylinderBarrel] a partir de un [Map]
  factory CylinderBarrel.fromJson(Map<String, dynamic> json) =>
      _$CylinderBarrelFromJson(json);

  /// Crea un [Map] a partir de una instancia de [CylinderBarrel]
  Map<String, dynamic> toJson() => _$CylinderBarrelToJson(this);

  /// i
  final int i;

  /// p
  final int p;

  /// t
  final int t;

  @override
  List<Object?> get props => [
        i,
        p,
        t,
      ];
}
