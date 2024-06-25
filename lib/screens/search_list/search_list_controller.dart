import 'package:amazon/core/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils.dart';
import '../../models/product.dart';

class SearchListController extends GetxController {
  RxList<Product> products = RxList<Product>();
  RxList<Product> filteredList = RxList<Product>();
  RxList<int> favList = RxList<int>();
  RxBool isLoading = RxBool(false);

  Future<void> loadAllProducts(BuildContext context) async {
    isLoading.value = true;
    products.clear();
    products.addAll(await getAllProducts(context));
    await loadFavoriteProductIdList();
    filteredList.clear();
    filteredList.addAll(products);
    isLoading.value = false;
  }

  Future<void> loadFavoriteProductIdList() async {
    favList.clear();
    favList.addAll(await getFavoriteProductIdList());
  }

  void getProductsBySearchKey(String searchKey) {
    if (searchKey.isEmpty) {
      filteredList.clear();
      filteredList.addAll(products);
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
    AmazonDialog.showLoaderDialog(context);

    await toggleFavorite(
      context,
      prductId: id,
    );

    loadFavoriteProductIdList();

    Navigator.pop(context);
  }
}
