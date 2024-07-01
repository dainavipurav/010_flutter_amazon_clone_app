import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/order_details.dart';
import '../../core/utils.dart';
import '../../models/order.dart';
import '../order_success/order_success.dart';

class OrderConfirmationController extends GetxController {
  Future<void> confirmOrder(BuildContext context) async {
    final order = Order(
      products: OrderDetails.selectedProducts,
      addressId: OrderDetails.addressId,
      orderAmount: OrderDetails.totalAmount.toString(),
      paymentType: OrderDetails.paymentMethod,
    );

    try {
      final currentUser = firebaseAuth.currentUser;
      final documentRef = firebaseFirestore
          .collection(ordersCollectionKey)
          .doc(currentUser!.uid);

      final documentRefData = await documentRef.get();

      Map<String, dynamic> orderMap = {
        generateRandomKey(documentRefData.data() ?? {}): order.toJson()
      };

      if (documentRefData.data() == null) {
        documentRef.set(orderMap);
      } else {
        documentRef.update(orderMap);
      }

      showSnackbar(
        context,
        content: orderSuccess,
      );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const OrderSuccess(),
        ),
      );
    } on FirebaseException catch (e) {
      showSnackbar(
        context,
        content: e.message ?? errorOcurred,
      );
    }
  }
}
