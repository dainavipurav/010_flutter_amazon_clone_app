import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils.dart';
import '../../models/product.dart';

class SearchListController extends GetxController {
  RxList<Product> products = RxList<Product>();
  RxList<Product> filteredList = RxList<Product>();
  RxList<int> favList = RxList<int>();

  Future<void> loadAllProducts(BuildContext context) async {
    products.clear();
    products.value = await getAllProducts(context);
    await loadFavoriteProductIdList();
  }

  Future<void> loadFavoriteProductIdList() async {
    favList.clear();
    favList.value = await getFavoriteProductIdList();
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

  Future<void> updateFavoriteList(BuildContext context,
      {required int id}) async {
    await toggleFavorite(
      context,
      prductId: id,
    );

    loadFavoriteProductIdList();
  }
}
