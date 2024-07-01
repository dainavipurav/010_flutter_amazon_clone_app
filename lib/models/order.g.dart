// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => OrderedProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      addressId: json['address_id'] as String?,
      paymentType:
          $enumDecodeNullable(_$PaymentTypeEnumMap, json['payment_type']),
      orderAmount: json['order_amount'] as String?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'products': instance.products?.map((e) => e.toJson()).toList(),
      'address_id': instance.addressId,
      'payment_type': _$PaymentTypeEnumMap[instance.paymentType],
      'order_amount': instance.orderAmount,
    };

const _$PaymentTypeEnumMap = {
  PaymentType.card: 'card',
  PaymentType.internetBanking: 'internetBanking',
  PaymentType.upi: 'upi',
  PaymentType.cod: 'cod',
};
