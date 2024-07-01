import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/enums.dart';
import '../../core/utils.dart';
import '../../widgets/bottom_gadient.dart';
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

        return Stack(
          children: [
            ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      quantity: xController.cartMap[
                              xController.cartList[index].id!.toString()] ??
                          0,
                    ),
                  ),
                  itemCount: xController.cartList.length,
                ),
                const SizedBox(height: 200),
              ],
            ),
            const BottomGradient(
              height: 100,
            ),
            Positioned(
              bottom: 0,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'SubTotal',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                const Icon(
                                  Icons.currency_rupee_sharp,
                                  size: 20,
                                ),
                                Text(
                                  xController.subTotal.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => xController.proceedToBuy(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.all(17),
                      ),
                      child: const Text(
                        proceedToBuy,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
