import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/utils.dart';
import '../screens/payment_method/payment_method.dart';
import '../screens/payment_method/payment_method_controller.dart';

class SelectPaymentMethod extends StatelessWidget {
  SelectPaymentMethod({super.key, this.onSelectPaymentMethod});

  final void Function()? onSelectPaymentMethod;
  final xController = PaymentMethodController.to();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(context),
          body(),
        ],
      ),
    );
  }

  Widget body() {
    return Flexible(
      child: PaymentMethod(
        showPage: false,
      ),
    );
  }

  Widget header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        children: [
          title(),
          continueButton(context),
        ],
      ),
    );
  }

  Widget continueButton(BuildContext context) {
    return Obx(() {
      return ElevatedButton(
        onPressed: xController.selectedPaymentType.value == null
            ? null
            : () {
                xController.updateDeliveryPaymentMethod(context);
                if (onSelectPaymentMethod != null) {
                  onSelectPaymentMethod!();
                }
              },
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
      );
    });
  }

  Widget title() {
    return const Expanded(
      child: Text(
        selectAddress,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
