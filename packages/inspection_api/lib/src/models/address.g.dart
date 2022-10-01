// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    formattedAddress: json['formattedaddress'] as String,
    postalCode: json['postalcode'] as String,
    country: json['country'] as String,
    department: json['department'] as String,
    province: json['province'] as String,
    district: json['district'] as String,
    urbanization: json['urbanization'] as String,
    street: json['street'] as String,
    block: json['block'] as String,
    lot: json['lot'] as String,
    streetNumber: json['streetnumber'] as String,
  );
}
