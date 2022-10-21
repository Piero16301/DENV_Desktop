// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_inspection_summarized.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeInspectionSummarized _$HomeInspectionSummarizedFromJson(
  Map<String, dynamic> json,
) {
  return HomeInspectionSummarized(
    id: json['id'] as String,
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    dateTime: DateTime.parse(json['datetime'] as String).toLocal(),
    photoUrl: json['photourl'] as String,
  );
}
