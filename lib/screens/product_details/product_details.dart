import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils.dart';
import '../../models/product.dart';
import '../../widgets/quantity_adjuster.dart';
import 'product_details_controller.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  ProductDetails({super.key, required this.product});

  final xController = Get.put(ProductDetailsController());

  @override
  Widget build(BuildContext context) {
    xController.quantity.value = 0;
    xController.loadfavorites(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name ?? productDetails),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          children: [
            prducImage(context),
            productName(),
            productActionPanel(context),
            productSpecificationsPanel(),
          ],
        ),
      ),
    );
  }

  Widget prducImage(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Image.network(
            product.image ?? '',
            height: MediaQuery.of(context).size.width - 60,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Obx(
            () => IconButton(
              onPressed: () => xController.updateFavoriteList(
                context,
                id: product.id!,
              ),
              icon: Icon(
                xController.favList.contains(product.id!)
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                size: 28,
                color: xController.favList.contains(product.id!)
                    ? Colors.red[300]
                    : Colors.white70,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: IconButton(
              onPressed: () => xController.shareProductDetails(context),
              icon: const Icon(
                Icons.share_outlined,
                size: 28,
              ),
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget productName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              product.name ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.currency_rupee_sharp,
                size: 18,
                color: Colors.grey,
              ),
              Text(
                product.price.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget productActionPanel(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: (product.availableQuantity ?? 0) == 0
            ? currenlyUnavailable()
            : adjustQuantityPanel(context),
      ),
    );
  }

  Widget currenlyUnavailable() {
    return const Center(
      child: TextOneLine(
        currentlyUnavailable,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget adjustQuantityPanel(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Obx(
            () => QuantityAdjuster(
              quantity: xController.quantity.value.toString(),
              buttonSize: 12,
              qtyFontSize: 18,
              onUpdateQuantity: (action) => xController.updateQuantity(
                context,
                availableQuantity: product.availableQuantity ?? 0,
                action: action,
              ),
            ),
          ),
        ),
        addToCartButton(context),
      ],
    );
  }

  Widget addToCartButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async => xController.addToCart(
        context,
        availableQuantity: product.availableQuantity ?? 0,
        productId: product.id!,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Text(
          add,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget productSpecificationsPanel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            details,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product.description ?? '',
            style: const TextStyle(
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
