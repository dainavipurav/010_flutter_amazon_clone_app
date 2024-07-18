import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/enums.dart';
import '../../core/utils.dart';
import '../../models/address.dart';
import '../saved_address_list/saved_address_list_controller.dart';

class AddressDetailsController extends GetxController {
  final formKey = GlobalKey<FormState>();

  static AddressDetailsController to() =>
      Get.isRegistered<AddressDetailsController>()
          ? Get.find<AddressDetailsController>()
          : Get.put(AddressDetailsController());

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

  RxnString addressId = RxnString();

  Rx<AddressActionType> addressActionType =
      Rx<AddressActionType>(AddressActionType.add);

  void initializePrefilledValued({
    required String prefilledAddresId,
    required Address prefilledData,
  }) {
    addressActionType.value = AddressActionType.update;
    addressId.value = prefilledAddresId;
    nameController.text = prefilledData.username ?? '';
    pincodeController.text = prefilledData.pincode ?? '';
    addressController.text = prefilledData.address ?? '';
    localityController.text = prefilledData.locality ?? '';
    cityController.text = prefilledData.city ?? '';
    stateController.text = prefilledData.state ?? '';
    mobileController.text = prefilledData.mobile ?? '';
    selectedAddressOption.value = prefilledData.type;
  }

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

      SavedAddressListController.to().getAllSavedAddresses();

      Navigator.pop(context);
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

      if (addressActionType.value == AddressActionType.add ||
          addressActionType.value == AddressActionType.addAndSelect ||
          addressId.value == null) {
        addressId.value = generateRandomKey(documentRefData.data() ?? {});
      }

      Map<String, dynamic> addMap = {addressId.value!: finalAddress.toJson()};

      if (documentRefData.data() == null) {
        dbRef.set(addMap);
      } else {
        dbRef.update(addMap);
      }

      if (addressActionType.value == AddressActionType.addAndSelect ||
          addressActionType.value == AddressActionType.updateAndSelect) {
        SavedAddressListController.to().onAddressSelect(
          updatedAddress: finalAddress,
          updatedAddressId: addressId.value ?? '',
        );
      }

      showSnackbar(
        context,
        content: addressActionType.value == AddressActionType.update ||
                addressActionType.value == AddressActionType.updateAndSelect
            ? updateAddressSuccess
            : addedAddress,
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
}
