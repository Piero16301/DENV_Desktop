import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'type_containers.g.dart';

/// {@template type_containers}
/// Modelo de tipo de contenedores
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class TypeContainers extends Equatable {
  /// {@macro type_containers}
  const TypeContainers({
    required this.type,
    required this.quantity,
  });

  /// Crea una instancia de [TypeContainers] a partir de un [json]
  factory TypeContainers.fromJson(Map<String, dynamic> json) =>
      _$TypeContainersFromJson(json);

  /// Tipo de contenedor
  final String type;

  /// Cantidad de contenedores
  final int quantity;

  @override
  List<Object?> get props => [
        type,
        quantity,
      ];
}
