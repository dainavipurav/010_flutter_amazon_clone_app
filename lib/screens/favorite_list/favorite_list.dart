import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'favorite_list_controller.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    final xController = Get.put(FavoriteListController());
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text('My wish list'),
      ),
      body: Center(
        child: Text('My favorite list'),
      ),
    );
  }
}
