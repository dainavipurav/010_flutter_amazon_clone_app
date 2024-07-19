import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/dialog.dart';
import '../../core/enums.dart';
import '../../core/utils.dart';

class ProductDetailsController extends GetxController {
  RxInt quantity = RxInt(0);
  RxList<int> favList = RxList<int>();

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

  void updateQuantity(
    BuildContext context, {
    required QuantityAction action,
    required int availableQuantity,
  }) {
    if (availableQuantity == 0) {
      showSnackbar(
        context,
        content: outOfStock,
      );
      return;
    }

    switch (action) {
      case QuantityAction.increase:
        if (quantity.value == availableQuantity) {
          showSnackbar(
            context,
            content: productLimitExceed,
          );
          return;
        }
        quantity.value++;

        break;
      case QuantityAction.decrease:
        if (quantity.value == 0) {
          return;
        }
        quantity.value--;
        break;
      default:
        quantity = quantity;
        break;
    }
  }

  Future<void> addToCart(
    BuildContext context, {
    required int productId,
    required int availableQuantity,
  }) async {
    if (availableQuantity == 0) {
      showSnackbar(
        context,
        content: outOfStock,
      );
      return;
    }

    AmazonDialog.showLoaderDialog(context);

    await updateProductQuantityInCartList(
      context,
      productId: productId,
      quantity: quantity.value == 0 ? 1 : quantity.value,
      action: QuantityAction.add,
    );

    Navigator.pop(context);
  }

  void shareProductDetails(BuildContext context) {
    print('share');
  }
}
