import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/order_details.dart';
import '../../core/utils.dart';
import '../../widgets/address_list_item.dart';
import '../../widgets/bottom_gadient.dart';
import '../../widgets/detail_card.dart';
import 'order_confirmation_controller.dart';

class OrderConfirmation extends StatelessWidget {
  const OrderConfirmation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final xController = Get.put(OrderConfirmationController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(orderConfirmation),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Stack(
          children: [
            Obx(() {
              return ListView(
                children: [
                  AddressListItem(
                    address: xController.selectedAddress.value!,
                    showEdit: true,
                    onEditClick: () => xController.onChangeAddress(context),
                    showDelete: false,
                    showRadio: false,
                    editText: change,
                  ),
                  const SizedBox(height: 20),
                  DetailCard(
                    heading: paymentMethod,
                    showEdit: true,
                    showDelete: false,
                    showRadio: false,
                    editText: change,
                    onEditClick: () =>
                        xController.onChangePaymentMethod(context),
                    child: Text(
                      getPaymentMethodName(
                          xController.selectedPaymentMethod.value!),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }),
            const BottomGradient(height: 150),
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          total,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black45,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.currency_rupee_rounded,
                              size: 18,
                            ),
                            Text(
                              OrderDetails.totalAmount.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => xController.confirmOrder(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      confirmOrder,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
