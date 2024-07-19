import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/enums.dart';
import '../../core/order_details.dart';
import '../../core/utils.dart';
import '../order_confirmation.dart/order_confirmation.dart';

class PaymentMethodController extends GetxController {
  static PaymentMethodController to() =>
      Get.isRegistered<PaymentMethodController>()
          ? Get.find<PaymentMethodController>()
          : Get.put(PaymentMethodController());

  Rxn<PaymentType> selectedPaymentType = Rxn();

  void makePayment(BuildContext context) {
    if (selectedPaymentType.value == null) {
      showSnackbar(
        context,
        content: selectPaymentMethod,
      );
      return;
    }

    OrderDetails.paymentMethod = selectedPaymentType.value!;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OrderConfirmation(),
      ),
    );
  }

  void updateDeliveryPaymentMethod(BuildContext context) {
    OrderDetails.paymentMethod = selectedPaymentType.value!;
    Navigator.of(context).pop();
  }
}
