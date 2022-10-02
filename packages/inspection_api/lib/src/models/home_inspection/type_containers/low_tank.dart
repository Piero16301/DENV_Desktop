import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'low_tank.g.dart';

/// {@template elevated_tank}
/// Modelo de tanque bajo
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class LowTank extends Equatable {
  /// {@macro elevated_tank}
  const LowTank({
    required this.i,
    required this.p,
    required this.t,
  });

  /// Crea una instancia de [LowTank] a partir de un [json]
  factory LowTank.fromJson(Map<String, dynamic> json) =>
      _$LowTankFromJson(json);

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
