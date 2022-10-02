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
    required this.inspectedContainers,
    required this.containersSpotlights,
    required this.treatedContainers,
    required this.destroyedContainers,
  });

  /// Crea una instancia de [TotalContainer] a partir de un [json]
  factory TotalContainer.fromJson(Map<String, dynamic> json) =>
      _$TotalContainerFromJson(json);

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
        inspectedContainers,
        containersSpotlights,
        treatedContainers,
        destroyedContainers,
      ];
}
