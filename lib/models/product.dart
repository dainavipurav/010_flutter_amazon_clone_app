import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product {
  int? id;
  String? name;
  String? description;
  double? price;

  @JsonKey(name: 'available_quantity')
  int? availableQuantity;

  @JsonKey(name: 'cat_id')
  int? catId;

  @JsonKey(name: 'sub_cat_id')
  int? subCatId;

  String? image;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.availableQuantity,
    this.catId,
    this.subCatId,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  /// Connect the generated [_$ProductsToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
