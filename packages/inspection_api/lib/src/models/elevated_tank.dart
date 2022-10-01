import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'elevated_tank.g.dart';

/// {@template elevated_tank}
/// Modelo de tanque elevado
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class ElevatedTank extends Equatable {
  /// {@macro elevated_tank}
  const ElevatedTank({
    required this.i,
    required this.p,
    required this.t,
  });

  /// Crea una instancia de [ElevatedTank] a partir de un [json]
  factory ElevatedTank.fromJson(Map<String, dynamic> json) =>
      _$ElevatedTankFromJson(json);

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
