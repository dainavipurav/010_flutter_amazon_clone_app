import 'package:flutter/material.dart';

import '../../core/utils.dart';
import 'saved_address_list_widget.dart';

class SavedAddressList extends StatelessWidget {
  const SavedAddressList({
    super.key,
    required this.showEdit,
    required this.showRadio,
  });
  final bool showEdit;
  final bool showRadio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(savedAddresses),
      ),
      body: SavedAddressListWidget(
        showEdit: showEdit,
        showRadio: showRadio,
      ),
    );
  }
}
