// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductsFromJson(Map<String, dynamic> json) => Product(
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      availableQuantity: (json['available_quantity'] as num?)?.toInt(),
      catId: (json['cat_id'] as num?)?.toInt(),
      subCatId: (json['sub_cat_id'] as num?)?.toInt(),
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ProductsToJson(Product instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'available_quantity': instance.availableQuantity,
      'cat_id': instance.catId,
      'sub_cat_id': instance.subCatId,
      'image': instance.image,
    };
