// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      availableQuantity: (json['available_quantity'] as num?)?.toInt(),
      catId: (json['cat_id'] as num?)?.toInt(),
      subCatId: (json['sub_cat_id'] as num?)?.toInt(),
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'available_quantity': instance.availableQuantity,
      'cat_id': instance.catId,
      'sub_cat_id': instance.subCatId,
      'image': instance.image,
    };
