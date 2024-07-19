import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/enums.dart';
import '../../core/utils.dart';
import '../../widgets/bottom_gadient.dart';
import 'payment_method_controller.dart';

class PaymentMethod extends StatelessWidget {
  final bool showPage;
  PaymentMethod({super.key, this.showPage = false});

  final xController = Get.put(PaymentMethodController());

  @override
  Widget build(BuildContext context) {
    if (showPage == false) {
      return paymentMethodsList(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(paymentMethod),
      ),
      body: contentBody(context),
    );
  }

  Widget contentBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Stack(
        children: [
          paymentMethodsList(context),
          const BottomGradient(
            height: 80,
          ),
          proceedToCheckout(context),
        ],
      ),
    );
  }

  Widget paymentMethodsList(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: PaymentType.values
              .map(
                (e) => paymentMethodItem(context, getPaymentMethodName(e), e),
              )
              .toList(),
        ),
        const SizedBox(height: 120),
      ],
    );
  }

  Widget paymentMethodItem(
      BuildContext context, String text, PaymentType type) {
    return Obx(
      () {
        return InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => xController.selectedPaymentType.value = type,
          child: Card(
            color: xController.selectedPaymentType.value == type
                ? Theme.of(context).colorScheme.primary
                : null,
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: xController.selectedPaymentType.value == type
                          ? Colors.white
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget proceedToCheckout(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 50,
      child: ElevatedButton(
        onPressed: () => xController.makePayment(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.all(17),
        ),
        child: const Text(
          continueTxt,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
