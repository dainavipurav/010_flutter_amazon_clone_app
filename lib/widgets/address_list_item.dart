import 'package:flutter/material.dart';

import '../models/address.dart';
import 'detail_card.dart';

class AddressListItem extends StatelessWidget {
  final Address address;
  final bool showEdit;
  final bool showRadio;
  final bool? isSelected;
  final void Function()? onEditClick;
  final void Function()? onCardSelect;
  const AddressListItem({
    super.key,
    required this.address,
    this.showEdit = false,
    this.showRadio = false,
    this.onCardSelect,
    this.onEditClick,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return DetailCard(
      heading: address.username ?? '',
      isSelected: isSelected,
      onCardSelect: onCardSelect,
      onEditClick: onEditClick,
      showEdit: showEdit,
      showRadio: showRadio,
      child: addressDetails(),
    );
  }

  Widget addressDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          address.mobile ?? '',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        Text(
          '${address.address}, ${address.locality}, ${address.city} - ${address.pincode}, ${address.state}',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
