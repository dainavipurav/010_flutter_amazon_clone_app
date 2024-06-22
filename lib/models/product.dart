import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product {
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
    this.name,
    this.description,
    this.price,
    this.availableQuantity,
    this.catId,
    this.subCatId,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);

  /// Connect the generated [_$ProductsToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProductsToJson(this);
}
