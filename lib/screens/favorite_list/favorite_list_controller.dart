import 'package:amazon/core/utils.dart';
import 'package:amazon/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/dialog.dart';

class FavoriteListController extends GetxController {
  RxList<Product> favList = RxList<Product>();
  RxBool isLoading = RxBool(false);

  Future<void> loadFavorites(BuildContext context) async {
    isLoading.value = true;
    List<Product> allProducts = await getAllProducts(context);
    List<int> favoriteProductIdList = await getFavoriteProductIdList();

    favList.clear();

    for (var element in allProducts) {
      if (favoriteProductIdList.contains(element.id)) {
        favList.add(element);
      }
    }
    isLoading.value = false;

    print('Favorite List : $favList');
  }

  void removFavorite(BuildContext context, {required int id}) async {
    AmazonDialog.showLoaderDialog(context);

    await toggleFavorite(
      context,
      prductId: id,
    );

    loadFavorites(context);

    Navigator.pop(context);
  }
}
