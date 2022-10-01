import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

/// {@template address}
/// Modelo de dirección
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class Address extends Equatable {
  /// {@macro address}
  const Address({
    required this.formattedAddress,
    required this.postalCode,
    required this.country,
    required this.department,
    required this.province,
    required this.district,
    required this.urbanization,
    required this.street,
    required this.block,
    required this.lot,
    required this.streetNumber,
  });

  /// Crea una instancia de [Address] a partir de un [json]
  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  /// Dirección formateada
  final String formattedAddress;

  /// Código postal
  final String postalCode;

  /// País
  final String country;

  /// Departamento
  final String department;

  /// Provincia
  final String province;

  /// Distrito
  final String district;

  /// Urbanización
  final String urbanization;

  /// Calle
  final String street;

  /// Manzana
  final String block;

  /// Lote
  final String lot;

  /// Número
  final String streetNumber;

  @override
  List<Object?> get props => [
        formattedAddress,
        postalCode,
        country,
        department,
        province,
        district,
        urbanization,
        street,
        block,
        lot,
        streetNumber,
      ];
}
