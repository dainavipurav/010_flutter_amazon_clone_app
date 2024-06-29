import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/enums.dart';
import '../../widgets/cart_list_item.dart';
import '../../widgets/no_data_found.dart';
import 'cart_controller.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final xController = Get.put(CartController());
    xController.loadAllProducts(context);
    return Obx(
      () {
        if (xController.isLoading.value && xController.cartList.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (xController.cartList.isEmpty) {
          return const NoDataFound();
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemBuilder: (context, index) => Obx(
            () => CartListItem(
              product: xController.cartList[index],
              onPressed: ({
                action = QuantityAction.add,
                quantity = 1,
              }) {
                xController.updateCartList(
                  context,
                  productId: xController.cartList[index].id!,
                  action: action,
                );
              },
              quantity: xController
                      .cartMap[xController.cartList[index].id!.toString()] ??
                  0,
            ),
          ),
          itemCount: xController.cartList.length,
        );
      },
    );
  }
}
