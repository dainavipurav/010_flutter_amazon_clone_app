import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/product_list_item.dart';
import 'favorite_list_controller.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    final xController = Get.put(FavoriteListController());
    xController.loadFavorites(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text('My wish list'),
      ),
      body: Obx(
        () {
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemBuilder: (context, index) => ProductListItem(
              onPressed: () => xController.removFavorite(
                context,
                id: xController.favList[index].id!,
              ),
              product: xController.favList[index],
              isFavorite: true,
            ),
            itemCount: xController.favList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 250,
            ),
          );
        },
      ),
    );
  }
}
