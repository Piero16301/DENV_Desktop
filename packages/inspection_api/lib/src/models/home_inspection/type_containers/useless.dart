import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'useless.g.dart';

/// {@template elevated_tank}
/// Modelo de desperdicios
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class Useless extends Equatable {
  /// {@macro elevated_tank}
  const Useless({
    required this.i,
    required this.p,
    required this.t,
  });

  /// Crea una instancia de [Useless] a partir de un [Map]
  factory Useless.fromJson(Map<String, dynamic> json) =>
      _$UselessFromJson(json);

  /// Crea un [Map] a partir de una instancia de [Useless]
  Map<String, dynamic> toJson() => _$UselessToJson(this);

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
