import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/product_list_item.dart';
import 'home_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final xController = Get.put(HomeController());
    xController.loadProducts(context);
    xController.loadfavorites(context);

    return Obx(
      () {
        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemBuilder: (context, index) => ProductListItem(
            product: xController.products[index],
            onPressed: () => xController.updateFavoriteList(
              context,
              id: xController.products[index].id!,
            ),
            isFavorite:
                xController.favList.contains(xController.products[index].id!),
          ),
          itemCount: xController.products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 250,
          ),
        );
      },
    );
  }
}
