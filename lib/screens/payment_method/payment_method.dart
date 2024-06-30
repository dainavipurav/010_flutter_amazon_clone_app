import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/enums.dart';
import '../../core/utils.dart';
import '../../widgets/bottom_gadient.dart';
import 'payment_method_controller.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  final xController = Get.put(PaymentMethodController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(paymentMethod),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Stack(
          children: [
            ListView(
              children: [
                Column(
                  children: PaymentType.values
                      .map(
                        (e) => paymentMethodItem(
                            xController.getPaymentMethodName(e), e),
                      )
                      .toList(),
                ),
                const SizedBox(height: 120),
              ],
            ),
            const BottomGradient(
              height: 80,
            ),
            proceedToCheckout(),
          ],
        ),
      ),
    );
  }

  Widget paymentMethodItem(String text, PaymentType type) {
    return Obx(
      () {
        return InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => xController.selectedType.value = type,
          child: Card(
            color: xController.selectedType.value == type
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
                      color: xController.selectedType.value == type
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

  Widget proceedToCheckout() {
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
          makePayment,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
