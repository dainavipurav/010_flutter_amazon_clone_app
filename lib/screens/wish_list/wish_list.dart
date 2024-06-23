import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'wish_list_controller.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  @override
  Widget build(BuildContext context) {
    final xController = Get.put(WishListController());
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text('My Wish list'),
      ),
      body: Center(
        child: Text('My wish list'),
      ),
    );
  }
}
