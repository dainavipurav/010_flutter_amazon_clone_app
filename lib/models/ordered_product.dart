import 'package:amazon/models/product.dart';
import 'package:json_annotation/json_annotation.dart';
part 'ordered_product.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderedProduct {
  Product? product;

  int? quantity;

  OrderedProduct({
    this.product,
    this.quantity,
  });

  factory OrderedProduct.fromJson(Map<String, dynamic> json) =>
      _$OrderedProductFromJson(json);

  /// Connect the generated [_$OrderedProductsToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OrderedProductToJson(this);
}
