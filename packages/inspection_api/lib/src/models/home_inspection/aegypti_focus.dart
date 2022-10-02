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

  /// Crea una instancia de [AegyptiFocus] a partir de un [json]
  factory AegyptiFocus.fromJson(Map<String, dynamic> json) =>
      _$AegyptiFocusFromJson(json);

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
