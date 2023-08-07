import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flower.g.dart';

/// {@template elevated_tank}
/// Modelo de florero
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class Flower extends Equatable {
  /// {@macro elevated_tank}
  const Flower({
    required this.i,
    required this.p,
    required this.t,
  });

  /// Crea una instancia de [Flower] a partir de un [Map]
  factory Flower.fromJson(Map<String, dynamic> json) => _$FlowerFromJson(json);

  /// Crea un [Map] a partir de una instancia de [Flower]
  Map<String, dynamic> toJson() => _$FlowerToJson(this);

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
