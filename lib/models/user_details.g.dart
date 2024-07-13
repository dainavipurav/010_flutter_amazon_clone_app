// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) => UserDetails(
      id: json['user_id'] as String?,
      username: json['username'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['user_email'] as String?,
      password: json['user_password'] as String?,
      mobile: json['mobile'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      image: json['image'] as String?,
    );

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'user_id': instance.id,
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'user_email': instance.email,
      'user_password': instance.password,
      'mobile': instance.mobile,
      'gender': _$GenderEnumMap[instance.gender],
      'image': instance.image,
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.other: 'other',
};
