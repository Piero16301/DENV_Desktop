import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aegypti_focus.g.dart';

/// {@template aegypti_focus}
/// Modelo de foco de aegypti
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class AegyptiFocus extends Equatable {
  /// {@macro aegypti_focus}
  const AegyptiFocus({
    required this.larvae,
    required this.pupae,
    required this.adult,
  });

  /// Crea una instancia de [AegyptiFocus] a partir de un [Map]
  factory AegyptiFocus.fromJson(Map<String, dynamic> json) =>
      _$AegyptiFocusFromJson(json);

  /// Crea un [Map] a partir de una instancia de [AegyptiFocus]
  Map<String, dynamic> toJson() => _$AegyptiFocusToJson(this);

  /// Larvas de aegypti
  final int larvae;

  /// Pupas de aegypti
  final int pupae;

  /// Adultos de aegypti
  final int adult;

  @override
  List<Object?> get props => [
        larvae,
        pupae,
        adult,
      ];
}
