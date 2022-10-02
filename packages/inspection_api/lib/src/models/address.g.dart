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
    lot: json['lot'] as int,
    streetNumber: json['streetnumber'] as int,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'formattedaddress': instance.formattedAddress,
      'postalcode': instance.postalCode,
      'country': instance.country,
      'department': instance.department,
      'province': instance.province,
      'district': instance.district,
      'urbanization': instance.urbanization,
      'street': instance.street,
      'block': instance.block,
      'lot': instance.lot,
      'streetnumber': instance.streetNumber,
    };
