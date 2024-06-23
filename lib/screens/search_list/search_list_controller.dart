import 'dart:convert';

import 'package:get/get.dart';

import '../../core/utils.dart';
import '../../models/product.dart';

class SearchListController extends GetxController {
  RxList<Product> products = RxList<Product>();
  RxList<Product> filteredList = RxList<Product>();

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
    filteredList.addAll(products);
  }

  void getProductsBySearchKey(String searchKey) {
    if (searchKey.isEmpty) {
      return;
    }

    filteredList.clear();
    for (var element in products) {
      if (element.name!.toLowerCase().contains(searchKey) ||
          element.description!.toLowerCase().contains(searchKey) ||
          element.price!.isEqual(double.tryParse(searchKey) ?? 0)) {
        filteredList.add(element);
      }
    }
  }
}
