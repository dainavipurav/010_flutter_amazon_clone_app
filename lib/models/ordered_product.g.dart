// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ordered_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderedProduct _$OrderedProductFromJson(Map<String, dynamic> json) =>
    OrderedProduct(
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderedProductToJson(OrderedProduct instance) =>
    <String, dynamic>{
      'product': instance.product?.toJson(),
      'quantity': instance.quantity,
    };
