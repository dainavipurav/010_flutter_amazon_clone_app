import 'package:get/get.dart';

import '../../core/utils.dart';
import '../../models/address.dart';

class SavedAddressListController extends GetxController {
  RxMap<String, Address> savedAddressMap = RxMap<String, Address>();
  RxBool isLoading = RxBool(false);

  Future<void> getAllSavedAddresses() async {
    isLoading.value = true;

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
}
