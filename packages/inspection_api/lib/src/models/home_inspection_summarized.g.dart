// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_inspection_summarized.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeInspectionSummarized _$HomeInspectionSummarizedFromJson(
  Map<String, dynamic> json,
) {
  return HomeInspectionSummarized(
    id: json['id'] as int? ?? 0,
    latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
    longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
    dateTime: DateTime.parse(
      json['datetime'] as String? ?? '0000-00-00T00:00:00-00:00',
    ).toLocal(),
    photoUrl: json['photoUrl'] as String? ?? '',
  );
}
