import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/enums.dart';
import '../../core/utils.dart';

class PaymentMethodController extends GetxController {
  Rxn<PaymentType> selectedType = Rxn();

  String getPaymentMethodName(PaymentType type) {
    switch (type) {
      case PaymentType.card:
        return card;
      case PaymentType.internetBanking:
        return internetBanking;
      case PaymentType.upi:
        return upi;
      case PaymentType.cod:
        return cod;
    }
  }

  void makePayment(BuildContext context) {
    if (selectedType.value == null) {
      showSnackbar(
        context,
        content: selectPaymentMethod,
      );
      return;
    }

    if (selectedType.value != PaymentType.cod) {
      showSnackbar(
        context,
        content: unavailablePaymentMethod,
      );
      return;
    }

    showSnackbar(
      context,
      content: orderSuccess,
    );
  }
}
