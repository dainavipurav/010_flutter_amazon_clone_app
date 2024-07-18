import 'package:flutter/material.dart';

import '../../core/utils.dart';
import '../profile/profile.dart';
import '../saved_address_list/saved_address_list.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        item(
          title: profile,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const Profile(),
              ),
            );
          },
        ),
        item(
          title: savedAddresses,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const SavedAddressList(
                  showEdit: true,
                  showRadio: false,
                  showDelete: true,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget item({required String title, required void Function() onTap}) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
          onTap: onTap,
        ),
        const Divider(height: 0),
      ],
    );
  }
}
