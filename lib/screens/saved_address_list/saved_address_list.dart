import 'package:flutter/material.dart';

import '../../core/utils.dart';
import '../address/address_details.dart';
import 'saved_address_list_widget.dart';

class SavedAddressList extends StatelessWidget {
  const SavedAddressList({
    super.key,
    required this.showEdit,
    required this.showRadio,
    required this.showDelete,
  });
  final bool showEdit;
  final bool showRadio;
  final bool showDelete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(savedAddresses),
      ),
      body: SavedAddressListWidget(
        showEdit: showEdit,
        showRadio: showRadio,
        showDelete: showDelete,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const AddressDetails(),
          ),
        ),
      ),
    );
  }
}
