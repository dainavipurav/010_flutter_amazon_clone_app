import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/utils.dart';
import '../screens/address/address_details.dart';
import '../screens/saved_address_list/saved_address_list_controller.dart';
import '../screens/saved_address_list/saved_address_list_widget.dart';

class SelectAddress extends StatelessWidget {
  final xController = SavedAddressListController.to();

  SelectAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(context),
          body(),
          footer(context),
        ],
      ),
    );
  }

  Widget footer(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddressDetails(),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.all(17),
        ),
        child: const Text(
          addNewAddress,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget body() {
    return Flexible(
      child: SavedAddressListWidget(
        showEdit: false,
        showRadio: true,
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
        onPressed: xController.selectedAddres.value == null ||
                xController.selectedAddresId.value == null
            ? null
            : () => xController.updateDeliveryAddress(context),
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
