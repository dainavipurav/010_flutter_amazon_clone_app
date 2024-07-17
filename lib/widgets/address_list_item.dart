import 'package:flutter/material.dart';

import '../models/address.dart';
import 'detail_card.dart';

class AddressListItem extends StatelessWidget {
  final Address address;
  const AddressListItem({
    super.key,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return DetailCard(
      heading: address.username ?? '',
      showEdit: false,
      child: Column(
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
      ),
    );
  }
}
