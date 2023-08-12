// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    id: json['id'] as int? ?? 0,
    formattedAddress: json['formattedAddress'] as String? ?? '',
    postalCode: json['postalCode'] as String? ?? '',
    country: json['country'] as String? ?? '',
    department: json['department'] as String? ?? '',
    province: json['province'] as String? ?? '',
    district: json['district'] as String? ?? '',
    urbanization: json['urbanization'] as String? ?? '',
    street: json['street'] as String? ?? '',
    block: json['block'] as String? ?? '',
    lot: json['lot'] as String? ?? '',
    streetNumber: json['streetNumber'] as String? ?? '',
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'formattedAddress': instance.formattedAddress,
      'postalCode': instance.postalCode,
      'country': instance.country,
      'department': instance.department,
      'province': instance.province,
      'district': instance.district,
      'urbanization': instance.urbanization,
      'street': instance.street,
      'block': instance.block,
      'lot': instance.lot,
      'streetNumber': instance.streetNumber,
    };
