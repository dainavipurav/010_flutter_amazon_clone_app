// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      username: json['username'] as String?,
      mobile: json['mobile'] as String?,
      pincode: json['pincode'] as String?,
      address: json['address'] as String?,
      locality: json['locality'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      type: $enumDecodeNullable(_$AddressTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'username': instance.username,
      'mobile': instance.mobile,
      'pincode': instance.pincode,
      'address': instance.address,
      'locality': instance.locality,
      'city': instance.city,
      'state': instance.state,
      'type': _$AddressTypeEnumMap[instance.type],
    };

const _$AddressTypeEnumMap = {
  AddressType.home: 'home',
  AddressType.work: 'work',
  AddressType.other: 'other',
};
