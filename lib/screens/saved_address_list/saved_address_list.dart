import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils.dart';
import '../../widgets/address_list_item.dart';
import '../../widgets/no_data_found.dart';
import 'saved_address_list_controller.dart';

class SavedAddressList extends StatelessWidget {
  SavedAddressList({super.key});

  final xController = Get.put(SavedAddressListController());

  @override
  Widget build(BuildContext context) {
    xController.getAllSavedAddresses();

    return Obx(
      () {
        if (xController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (xController.savedAddressMap.isEmpty) {
          return const NoDataFound(
            msg: noSavedAddresses,
          );
        }

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: data(),
        );
      },
    );
  }

  List<Widget> data() {
    List<Widget> data = [];

    xController.savedAddressMap.forEach(
      (key, value) {
        data.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: AddressListItem(address: value),
          ),
        );
      },
    );

    return data;
  }
}
