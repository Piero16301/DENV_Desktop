// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_container.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalContainer _$TotalContainerFromJson(Map<String, dynamic> json) {
  return TotalContainer(
    inspectedContainers: json['inspectedcontainers'] as int,
    containersSpotlights: json['containersspotlights'] as int,
    treatedContainers: json['treatedcontainers'] as int,
    destroyedContainers: json['destroyedcontainers'] as int,
  );
}

Map<String, dynamic> _$TotalContainerToJson(TotalContainer instance) =>
    <String, dynamic>{
      'inspectedcontainers': instance.inspectedContainers,
      'containersspotlights': instance.containersSpotlights,
      'treatedcontainers': instance.treatedContainers,
      'destroyedcontainers': instance.destroyedContainers,
    };