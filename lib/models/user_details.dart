import 'package:json_annotation/json_annotation.dart';

import '../core/enums.dart';
import '../core/utils.dart';

part 'user_details.g.dart';

@JsonSerializable(explicitToJson: true)
class UserDetails {
  @JsonKey(name: userIdKey)
  String? id;

  String? username;

  @JsonKey(name: 'first_name')
  String? firstName;

  @JsonKey(name: 'last_name')
  String? lastName;

  @JsonKey(name: userEmailKey)
  String? email;

  @JsonKey(name: userPasswordKey)
  String? password;

  String? mobile;

  Gender? gender;

  String? image;

  UserDetails({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.mobile,
    this.gender,
    this.image,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}
