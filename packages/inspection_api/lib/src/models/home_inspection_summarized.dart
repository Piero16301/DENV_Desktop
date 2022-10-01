import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:inspection_api/src/models/models.dart';

part 'home_inspection_summarized.g.dart';

/// {@template home_inspection_summarized}
/// Modelo de inspección de vivienda resumida
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class HomeInspectionSummarized extends Equatable {
  /// {@macro home_inspection_summarized}
  const HomeInspectionSummarized({
    required this.id,
    required this.latitude,
    required this.longitude,
  });

  /// Crea una instancia de [HomeInspectionSummarized] a partir de un [json]
  factory HomeInspectionSummarized.fromJson(Map<String, dynamic> json) =>
      _$HomeInspectionSummarizedFromJson(json);

  /// Identificador de la inspección
  final String id;

  /// Latitud de la inspección
  final double latitude;

  /// Longitud de la inspección
  final double longitude;

  @override
  List<Object?> get props => [id, latitude, longitude];
}
