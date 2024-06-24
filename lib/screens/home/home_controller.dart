import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils.dart';
import '../../models/product.dart';

class HomeController extends GetxController {
  RxList<Product> products = RxList<Product>();
  RxList<int> favList = RxList<int>();

  Future<void> loadProducts(BuildContext context) async {
    products.clear();
    products.value = await getAllProducts(context);
  }

  Future<void> loadfavorites(BuildContext context) async {
    favList.clear();
    favList.value = await getFavoriteProductIdList();
  }

  Future<void> updateFavoriteList(BuildContext context,
      {required int id}) async {
    await toggleFavorite(
      context,
      prductId: id,
    );

    await loadfavorites(context);
  }
}
