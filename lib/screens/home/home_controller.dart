import 'dart:convert';

import 'package:amazon/core/utils.dart';
import 'package:get/get.dart';

import '../../models/product.dart';

class HomeController extends GetxController {
  RxList<Product> products = RxList<Product>();

  Future<void> loadProducts() async {
    String productData =
        await getDataByKeyFromRealtimeDatabase(productsFileName) ?? '[]';

    final List<dynamic> listData = json.decode(productData);

    products.clear();

    for (final item in listData) {
      products.add(
        Product.fromJson(item),
      );
    }
  }
}
