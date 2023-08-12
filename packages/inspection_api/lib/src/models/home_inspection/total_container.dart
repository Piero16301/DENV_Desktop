import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'total_container.g.dart';

/// {@template total_container}
/// Modelo de contenedores totales
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class TotalContainer extends Equatable {
  /// {@macro total_container}
  const TotalContainer({
    required this.id,
    required this.inspectedContainers,
    required this.containersSpotlights,
    required this.treatedContainers,
    required this.destroyedContainers,
  });

  /// Crea una instancia de [TotalContainer] a partir de un [Map]
  factory TotalContainer.fromJson(Map<String, dynamic> json) =>
      _$TotalContainerFromJson(json);

  /// Crea un [Map] a partir de una instancia de [TotalContainer]
  Map<String, dynamic> toJson() => _$TotalContainerToJson(this);

  /// Id del contenedor
  final int id;

  /// Contenedores inspecionados
  final int inspectedContainers;

  /// Focos de contenedores
  final int containersSpotlights;

  /// Contenedores tratados
  final int treatedContainers;

  /// Contenedores destruidos
  final int destroyedContainers;

  @override
  List<Object?> get props => [
        id,
        inspectedContainers,
        containersSpotlights,
        treatedContainers,
        destroyedContainers,
      ];
}
