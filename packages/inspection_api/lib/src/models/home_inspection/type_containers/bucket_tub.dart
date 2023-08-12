import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bucket_tub.g.dart';

/// {@template elevated_tank}
/// Modelo de tubo de cubeta
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class BucketTub extends Equatable {
  /// {@macro elevated_tank}
  const BucketTub({
    required this.id,
    required this.i,
    required this.p,
    required this.t,
  });

  /// Crea una instancia de [BucketTub] a partir de un [Map]
  factory BucketTub.fromJson(Map<String, dynamic> json) =>
      _$BucketTubFromJson(json);

  /// Crea un [Map] a partir de una instancia de [BucketTub]
  Map<String, dynamic> toJson() => _$BucketTubToJson(this);

  /// Id del tubo de cubeta
  final int id;

  /// i
  final int i;

  /// p
  final int p;

  /// t
  final int t;

  @override
  List<Object?> get props => [
        id,
        i,
        p,
        t,
      ];
}
