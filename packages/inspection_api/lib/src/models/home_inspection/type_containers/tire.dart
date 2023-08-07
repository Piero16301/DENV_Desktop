import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tire.g.dart';

/// {@template elevated_tank}
/// Modelo de llanta
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class Tire extends Equatable {
  /// {@macro elevated_tank}
  const Tire({
    required this.i,
    required this.p,
    required this.t,
  });

  /// Crea una instancia de [Tire] a partir de un [Map]
  factory Tire.fromJson(Map<String, dynamic> json) => _$TireFromJson(json);

  /// Crea un [Map] a partir de una instancia de [Tire]
  Map<String, dynamic> toJson() => _$TireToJson(this);

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
