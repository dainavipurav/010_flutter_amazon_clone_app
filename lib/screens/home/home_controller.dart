import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/dialog.dart';
import '../../core/utils.dart';
import '../../models/product.dart';

class HomeController extends GetxController {
  RxList<Product> products = RxList<Product>();
  RxList<int> favList = RxList<int>();
  RxBool isLoading = RxBool(false);

  Future<void> loadProducts(BuildContext context) async {
    isLoading.value = true;
    products.clear();
    products.addAll(await getAllProducts(context));
    isLoading.value = false;
  }

  Future<void> loadfavorites(BuildContext context) async {
    favList.clear();
    favList.addAll(await getFavoriteProductIdList());
  }

  Future<void> updateFavoriteList(BuildContext context,
      {required int id}) async {
    AmazonDialog.showLoaderDialog(context);

    await toggleFavorite(
      context,
      prductId: id,
    );

    await loadfavorites(context);

    Navigator.pop(context);
  }
}
