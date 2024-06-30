import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/enums.dart';
import '../../core/utils.dart';

class PaymentMethodController extends GetxController {
  Rxn<PaymentType> selectedType = Rxn();

  String getPaymentMethodName(PaymentType type) {
    switch (type) {
      case PaymentType.card:
        return 'Card';
      case PaymentType.internetBanking:
        return 'Internet Banking';
      case PaymentType.upi:
        return 'UPI';
      case PaymentType.cod:
        return 'Cash on Delivery';
    }
  }

  void makePayment(BuildContext context) {
    if (selectedType.value != PaymentType.cod) {
      showSnackbar(
        context,
        content: 'Sorry! This payment method is curently unavailable.',
      );
      return;
    }

    showSnackbar(
      context,
      content: 'Items ordered successfully.',
    );
  }
}
