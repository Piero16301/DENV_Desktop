import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'others.g.dart';

/// {@template elevated_tank}
/// Modelo de otros
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class Others extends Equatable {
  /// {@macro elevated_tank}
  const Others({
    required this.i,
    required this.p,
    required this.t,
  });

  /// Crea una instancia de [Others] a partir de un [Map]
  factory Others.fromJson(Map<String, dynamic> json) => _$OthersFromJson(json);

  /// Crea un [Map] a partir de una instancia de [Others]
  Map<String, dynamic> toJson() => _$OthersToJson(this);

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
