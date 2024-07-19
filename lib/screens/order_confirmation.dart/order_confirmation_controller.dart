import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_web/razorpay_web.dart';

import '../../core/enums.dart';
import '../../core/order_details.dart';
import '../../core/utils.dart';
import '../../models/address.dart';
import '../../models/order.dart';
import '../../widgets/select_address.dart';
import '../../widgets/select_payment_method.dart';
import '../order_success/order_success.dart';

class OrderConfirmationController extends GetxController {
  static OrderConfirmationController to() =>
      Get.isRegistered<OrderConfirmationController>()
          ? Get.find<OrderConfirmationController>()
          : Get.put(OrderConfirmationController());

  var razorpay = Razorpay();
  RxnString selectedAddressId = RxnString(OrderDetails.addressId);
  Rxn<Address> selectedAddress = Rxn<Address>(OrderDetails.address);
  Rxn<PaymentType> selectedPaymentMethod =
      Rxn<PaymentType>(OrderDetails.paymentMethod);

  void updateAddress(
      {required String updatedAddressId, required Address updatedAddress}) {
    selectedAddress.value = updatedAddress;
    selectedAddressId.value = updatedAddressId;
  }

  void updatePaymentMethod({required PaymentType updatedPaymentMethod}) {
    selectedPaymentMethod.value = updatedPaymentMethod;
  }

  @override
  void dispose() {
    razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  Future<void> confirmOrder(BuildContext context) async {
    try {
      initRazorPay(context);
    } on FirebaseException catch (e) {
      showSnackbar(
        context,
        content: e.message ?? errorOcurred,
      );
    }
  }

  void initRazorPay(BuildContext context) {
    var options = {
      'key': 'rzp_test_1kThO6u9CKYC9H',
      'amount': OrderDetails.totalAmount * 100,
      'name': OrderDetails.orderId,
      "currency": 'INR',
      'description': OrderDetails.selectedProducts.length,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'external': {
        'wallets': ['paytm']
      }
    };
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (response) {
      _handlePaymentSuccess(context, response);
    });
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (response) {
      _handlePaymentError(context, response);
    });
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (response) {
      _handleExternalWallet(context, response);
    });

    razorpay.open(options);
  }

  Future<void> _handlePaymentSuccess(
      BuildContext context, PaymentSuccessResponse response) async {
    print('Payment sucess response paymentId: ${response.paymentId}');
    print('Payment sucess response orderId: ${response.orderId}');
    print('Payment sucess response signature: ${response.signature}');

    showSnackbar(
      context,
      content: orderSuccess,
    );

    final order = Order(
      products: OrderDetails.selectedProducts,
      addressId: OrderDetails.addressId,
      orderAmount: OrderDetails.totalAmount.toString(),
      paymentType: OrderDetails.paymentMethod,
    );
    final currentUser = firebaseAuth.currentUser;
    final documentRef =
        firebaseFirestore.collection(ordersCollectionKey).doc(currentUser!.uid);

    final documentRefData = await documentRef.get();
    OrderDetails.orderId = generateRandomKey(documentRefData.data() ?? {});

    Map<String, dynamic> orderMap = {
      OrderDetails.orderId!: order.toJson(),
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
  }

  void _handlePaymentError(
      BuildContext context, PaymentFailureResponse response) {
    print(response.message);
    showSnackbar(context, content: '$paymentFailure : ${response.message}');
    // Do something when payment fails
  }

  void _handleExternalWallet(
      BuildContext context, ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    showSnackbar(context, content: paymentWallet);
  }

  void onChangeAddress(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (ctx) => SelectAddress(
        onSelectAddress: () {
          selectedAddress.value = OrderDetails.address;
          selectedAddressId.value = OrderDetails.addressId;
        },
      ),
    );
  }

  void onChangePaymentMethod(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (ctx) => SelectPaymentMethod(
        onSelectPaymentMethod: () {
          selectedPaymentMethod.value = OrderDetails.paymentMethod;
        },
      ),
    );
  }
}
