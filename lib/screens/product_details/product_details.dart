import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils.dart';
import '../../models/product.dart';
import '../../widgets/quantity_adjuster.dart';
import 'product_details_controller.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final xController = Get.put(ProductDetailsController());

  @override
  void initState() {
    xController.quantity.value = 0;
    xController.loadfavorites(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name ?? productDetails),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          children: [
            prducImage(),
            productName(),
            productActionPanel(),
            productSpecificationsPanel(),
          ],
        ),
      ),
    );
  }

  Widget prducImage() {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Image.network(
            widget.product.image ?? '',
            height: MediaQuery.of(context).size.width - 60,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Obx(
            () => IconButton(
              onPressed: () => xController.updateFavoriteList(
                context,
                id: widget.product.id!,
              ),
              icon: Icon(
                xController.favList.contains(widget.product.id!)
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
              ),
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
              widget.product.name ?? '',
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
                widget.product.price.toString(),
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

  Widget productActionPanel() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: (widget.product.availableQuantity ?? 0) == 0
            ? currenlyUnavailable()
            : adjustQuantityPanel(),
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

  Widget adjustQuantityPanel() {
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
                availableQuantity: widget.product.availableQuantity ?? 0,
                action: action,
              ),
            ),
          ),
        ),
        addToCartButton(),
      ],
    );
  }

  Widget addToCartButton() {
    return ElevatedButton(
      onPressed: () async => xController.addToCart(
        context,
        availableQuantity: widget.product.availableQuantity ?? 0,
        productId: widget.product.id!,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
      ),
      child: const Text(
        add,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
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
            widget.product.description ?? '',
            style: const TextStyle(
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
