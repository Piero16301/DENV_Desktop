// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_container.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalContainer _$TotalContainerFromJson(Map<String, dynamic> json) {
  return TotalContainer(
    id: json['id'] as int? ?? 0,
    inspectedContainers: json['inspectedContainers'] as int? ?? 0,
    containersSpotlights: json['containersSpotlights'] as int? ?? 0,
    treatedContainers: json['treatedContainers'] as int? ?? 0,
    destroyedContainers: json['destroyedContainers'] as int? ?? 0,
  );
}

Map<String, dynamic> _$TotalContainerToJson(TotalContainer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'inspectedContainers': instance.inspectedContainers,
      'containersSpotlights': instance.containersSpotlights,
      'treatedContainers': instance.treatedContainers,
      'destroyedContainers': instance.destroyedContainers,
    };
