import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/order_details.dart';
import '../../core/utils.dart';
import '../../widgets/bottom_gadient.dart';
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
            ListView(
              children: [
                shippingDetailCard(
                  context,
                  heading: shippingDetails,
                  showEdit: true,
                  cardChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        OrderDetails.address!.username ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: '$address : ',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  '${OrderDetails.address!.address}, ${OrderDetails.address!.locality}, ${OrderDetails.address!.city} - ${OrderDetails.address!.pincode}, ${OrderDetails.address!.state}',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                shippingDetailCard(
                  context,
                  heading: paymentMethod,
                  showEdit: true,
                  cardChild: Text(
                    getPaymentMethodName(OrderDetails.paymentMethod),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
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

  Widget shippingDetailCard(
    BuildContext context, {
    required String heading,
    bool showEdit = false,
    required Widget cardChild,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    heading,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                if (showEdit)
                  ElevatedButton(
                    onPressed: () => showSnackbar(
                      context,
                      content: 'Functionality pending',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      edit,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
              ],
            ),
            Flexible(child: cardChild),
          ],
        ),
      ),
    );
  }
}
