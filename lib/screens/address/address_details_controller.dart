import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/enums.dart';
import '../../core/order_details.dart';
import '../../core/utils.dart';
import '../../models/address.dart';
import '../payment_method/payment_method.dart';

class AddressDetailsController extends GetxController {
  final formKey = GlobalKey<FormState>();

  Rxn<AddressType> selectedAddressOption = Rxn();

  final nameController = TextEditingController();
  final pincodeController = TextEditingController();
  final addressController = TextEditingController();
  final localityController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final mobileController = TextEditingController();
  final nameFocusNode = FocusNode();
  final pincodeFocusNode = FocusNode();
  final addressFocusNode = FocusNode();
  final localityFocusNode = FocusNode();
  final cityFocusNode = FocusNode();
  final stateFocusNode = FocusNode();
  final mobileFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    disposeFormFields();
  }

  void clearFocus() {
    if (nameFocusNode.hasFocus) {
      nameFocusNode.unfocus();
    }
    if (pincodeFocusNode.hasFocus) {
      pincodeFocusNode.unfocus();
    }
    if (addressFocusNode.hasFocus) {
      addressFocusNode.unfocus();
    }
    if (localityFocusNode.hasFocus) {
      localityFocusNode.unfocus();
    }
    if (cityFocusNode.hasFocus) {
      cityFocusNode.unfocus();
    }
    if (stateFocusNode.hasFocus) {
      stateFocusNode.unfocus();
    }
    if (mobileFocusNode.hasFocus) {
      mobileFocusNode.unfocus();
    }
  }

  clearformFields() {
    nameController.clear();
    pincodeController.clear();
    addressController.clear();
    localityController.clear();
    cityController.clear();
    stateController.clear();
    mobileController.clear();
  }

  void disposeFocusNodes() {
    nameFocusNode.dispose();
    pincodeFocusNode.dispose();
    addressFocusNode.dispose();
    localityFocusNode.dispose();
    cityFocusNode.dispose();
    stateFocusNode.dispose();
    mobileFocusNode.dispose();
  }

  void disposeTextEditingControllers() {
    nameController.dispose();
    pincodeController.dispose();
    addressController.dispose();
    localityController.dispose();
    cityController.dispose();
    stateController.dispose();
    mobileController.dispose();
  }

  void disposeFormFields() {
    clearFocus();
    clearformFields();
    disposeFocusNodes();
    disposeTextEditingControllers();
  }

  Future<void> validateFormAndCheckout(BuildContext context) async {
    final valid = formKey.currentState!.validate();
    if (valid) {
      await saveAddressToFirebase(context);
      formKey.currentState!.reset();
      selectedAddressOption.value = null;
      clearFocus();
      clearformFields();
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PaymentMethod(),
        ),
      );
    }
  }

  Future<void> saveAddressToFirebase(BuildContext context) async {
    try {
      final currentUser = firebaseAuth.currentUser!;
      final dbRef = firebaseFirestore
          .collection(userAddressCollectionKey)
          .doc(currentUser.uid);

      final documentRefData = await dbRef.get();

      final finalAddress = Address(
        username: nameController.text,
        mobile: mobileController.text,
        address: addressController.text,
        locality: localityController.text,
        pincode: pincodeController.text,
        city: cityController.text,
        state: stateController.text,
        type: selectedAddressOption.value,
      );

      Map<String, dynamic> addMap = {
        generateRandomKey(documentRefData.data() ?? {}): finalAddress.toJson()
      };

      if (documentRefData.data() == null) {
        dbRef.set(addMap);
      } else {
        dbRef.update(addMap);
      }

      OrderDetails.address = finalAddress;

      showSnackbar(
        context,
        content: addedAddress,
      );
      return;
    } on FirebaseException catch (e) {
      showSnackbar(
        context,
        content: e.message ?? errorOcurred,
      );
      return;
    }
  }

  void checkout() {}
}
