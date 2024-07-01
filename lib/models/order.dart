import 'package:amazon/core/enums.dart';
import 'package:json_annotation/json_annotation.dart';

import 'ordered_product.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  List<OrderedProduct>? products;

  @JsonKey(name: 'address_id')
  String? addressId;

  @JsonKey(name: 'payment_type')
  PaymentType? paymentType;

  @JsonKey(name: 'order_amount')
  String? orderAmount;

  Order({
    this.products,
    this.addressId,
    this.paymentType,
    this.orderAmount,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  /// Connect the generated [_$OrdersToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
