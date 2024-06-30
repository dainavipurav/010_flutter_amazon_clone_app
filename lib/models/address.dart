import 'package:json_annotation/json_annotation.dart';

import '../core/enums.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  String? username;
  String? mobile;
  String? pincode;
  String? address;
  String? locality;
  String? city;
  String? state;
  AddressType? type;

  Address({
    this.username,
    this.mobile,
    this.pincode,
    this.address,
    this.locality,
    this.city,
    this.state,
    this.type,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
