import 'package:amazon/screens/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/product_list_item.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final xController = Get.put(HomeController());
    xController.loadProducts();

    return Obx(
      () {
        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemBuilder: (context, index) => ProductListItem(
            product: xController.products[index],
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
