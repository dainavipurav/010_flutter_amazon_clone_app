import 'package:flutter/material.dart';

import '../core/enums.dart';
import '../models/product.dart';
import '../screens/product_details/product_details.dart';

class CartListItem extends StatelessWidget {
  const CartListItem({
    required this.product,
    required this.onPressed,
    this.quantity = 0,
    super.key,
  });
  final Product product;
  final void Function({
    QuantityAction action,
  }) onPressed;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetails(product: product),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            image(),
            const SizedBox(width: 10),
            productSpecifications(context),
          ],
        ),
      ),
    );
  }

  Widget removeFromCartIcon(BuildContext context) {
    return IconButton(
      onPressed: () {
        onPressed(
          action: QuantityAction.remove,
        );
      },
      icon: Icon(
        Icons.close_rounded,
        color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
      ),
    );
  }

  Widget image() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.network(
        product.image ??
            'https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU',
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget productSpecifications(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  product.name ?? '',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              removeFromCartIcon(context),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            product.description ?? '',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.currency_rupee_sharp,
                size: 14,
              ),
              Text(
                (product.price ?? 0).toString(),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              buildQuantityAdjusterButton(
                context,
                action: QuantityAction.decrease,
              ),
              const SizedBox(width: 20),
              Text(
                quantity.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 20),
              buildQuantityAdjusterButton(
                context,
                action: QuantityAction.increase,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildQuantityAdjusterButton(BuildContext context,
      {required QuantityAction action}) {
    return SizedBox(
      height: 30,
      width: 48,
      child: TextButton(
        onPressed: () {
          onPressed(
            action: action,
          );
        },
        style: TextButton.styleFrom(
          backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.2),
          alignment: Alignment.center,
        ),
        child: Center(
          child: Icon(
            action == QuantityAction.decrease ? Icons.remove : Icons.add,
            color: Theme.of(context).colorScheme.primary,
            size: 16,
          ),
        ),
      ),
    );
  }
}
