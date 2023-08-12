import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

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
    required this.dateTime,
    required this.photoUrl,
  });

  /// Crea una instancia de [HomeInspectionSummarized] a partir de un [json]
  factory HomeInspectionSummarized.fromJson(Map<String, dynamic> json) =>
      _$HomeInspectionSummarizedFromJson(json);

  /// Identificador de la inspección
  final int id;

  /// Latitud de la inspección
  final double latitude;

  /// Longitud de la inspección
  final double longitude;

  /// Fecha de la inspección
  final DateTime dateTime;

  /// Url de la imagen de la inspección
  final String photoUrl;

  @override
  List<Object?> get props => [
        id,
        latitude,
        longitude,
        dateTime,
        photoUrl,
      ];
}
