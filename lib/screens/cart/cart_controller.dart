import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/dialog.dart';
import '../../core/enums.dart';
import '../../core/order_details.dart';
import '../../core/utils.dart';
import '../../models/ordered_product.dart';
import '../../models/product.dart';
import '../../widgets/select_address.dart';

class CartController extends GetxController {
  RxList<Product> products = RxList<Product>();
  RxList<Product> cartList = RxList<Product>();
  RxMap cartMap = RxMap();
  RxBool isLoading = RxBool(false);
  RxDouble subTotal = RxDouble(0);

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
    required int availableQuantity,
    int quantity = 1,
    QuantityAction action = QuantityAction.increase,
  }) async {
    if (availableQuantity == 0) {
      showSnackbar(
        context,
        content: outOfStock,
      );
      return;
    }

    if (action != QuantityAction.decrease && quantity >= availableQuantity) {
      showSnackbar(
        context,
        content: productLimitExceed,
      );
      return;
    }

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
    subTotal.value = 0;

    for (var element in products) {
      if (cartMap.containsKey(element.id.toString())) {
        cartList.add(element);
        subTotal.value =
            (subTotal.value + element.price! * cartMap[element.id.toString()])
                .toPrecision(2);
      }
    }
  }

  void proceedToBuy(BuildContext context) async {
    OrderDetails.selectedProducts.clear();
    OrderDetails.totalAmount = subTotal.value;

    for (var element in cartList) {
      OrderDetails.selectedProducts.add(
        OrderedProduct(
          product: element,
          quantity: cartMap[element.id.toString()],
        ),
      );
    }

    for (var element in OrderDetails.selectedProducts) {
      print('Ordered Product : ${element.toJson()}');
    }

    await showModalBottomSheet(
      context: context,
      builder: (ctx) => SelectAddress(),
    );
  }
}
