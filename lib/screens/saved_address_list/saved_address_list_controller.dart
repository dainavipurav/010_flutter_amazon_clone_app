import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/order_details.dart';
import '../../core/utils.dart';
import '../../models/address.dart';
import '../address/address_details.dart';
import '../address/address_details_controller.dart';

class SavedAddressListController extends GetxController {
  static SavedAddressListController to() =>
      Get.isRegistered<SavedAddressListController>()
          ? Get.find<SavedAddressListController>()
          : Get.put(SavedAddressListController());

  RxMap<String, Address> savedAddressMap = RxMap<String, Address>();
  RxBool isLoading = RxBool(false);

  Rxn<String> selectedAddresId = Rxn<String>();
  Rxn<Address> selectedAddres = Rxn<Address>();

  Future<void> getAllSavedAddresses() async {
    isLoading.value = true;

    initializeSelectedAddressVariables();

    final addressDocument = await firebaseFirestore
        .collection(userAddressCollectionKey)
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    if (!addressDocument.exists) {
      savedAddressMap.value = {};
      return;
    }

    if (addressDocument.data() == null) {
      savedAddressMap.value = {};
      return;
    }

    savedAddressMap.clear();

    addressDocument.data()!.forEach(
          (key, value) => savedAddressMap[key] = Address.fromJson(value),
        );

    isLoading.value = false;
  }

  void initializeSelectedAddressVariables() {
    if (OrderDetails.address == null || OrderDetails.addressId == null) {
      return;
    }

    selectedAddres.value = OrderDetails.address;
    selectedAddresId.value = OrderDetails.addressId;
  }

  void onAddressSelect({
    required String updatedAddressId,
    required Address updatedAddress,
  }) {
    selectedAddresId.value = updatedAddressId;
    selectedAddres.value = updatedAddress;
  }

  void onEditAddress(
    BuildContext context, {
    required String addressId,
    required Address address,
  }) {
    AddressDetailsController.to().initializePrefilledValued(
      prefilledAddresId: addressId,
      prefilledData: address,
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddressDetails(),
      ),
    );
  }

  void updateDeliveryAddress(BuildContext context) {
    if (selectedAddres.value == null || selectedAddresId.value == null) {
      return;
    }

    OrderDetails.addressId = selectedAddresId.value;
    OrderDetails.address = selectedAddres.value;

    Navigator.of(context).pop();
  }
}
