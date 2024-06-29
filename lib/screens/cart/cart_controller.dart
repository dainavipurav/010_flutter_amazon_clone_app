import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/dialog.dart';
import '../../core/enums.dart';
import '../../core/utils.dart';
import '../../models/product.dart';

class CartController extends GetxController {
  RxList<Product> products = RxList<Product>();
  RxList<Product> cartList = RxList<Product>();
  RxMap cartMap = RxMap();
  RxBool isLoading = RxBool(false);

  Future<void> loadAllProducts(BuildContext context) async {
    isLoading.value = true;
    products.clear();
    products.addAll(await getAllProducts(context));
    await loadCartProductListMap();
    fetchCartList();
    isLoading.value = false;
  }

  Future<void> loadCartProductListMap() async {
    cartMap.clear();
    cartMap.addAll(await getCartProductListMap());
  }

  Future<void> updateCartList(
    BuildContext context, {
    required int productId,
    int quantity = 1,
    QuantityAction action = QuantityAction.increase,
  }) async {
    AmazonDialog.showLoaderDialog(context);

    await updateProductQuantityInCartList(
      context,
      productId: productId,
      action: action,
      quantity: quantity,
    );

    await loadAllProducts(context);

    Navigator.pop(context);
  }

  void fetchCartList() {
    cartList.clear();

    for (var element in products) {
      if (cartMap.containsKey(element.id.toString())) {
        cartList.add(element);
      }
    }
  }
}
