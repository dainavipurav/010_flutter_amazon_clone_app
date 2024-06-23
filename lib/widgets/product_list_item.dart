import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductListItem extends StatelessWidget {
  final Product product;

  const ProductListItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            image(),
            const SizedBox(height: 5),
            productSpecifications(context),
          ],
        ),
      ),
    );
  }

  Widget addToFavoriteIcon(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.favorite_border_rounded,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
        ),
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
        width: double.infinity,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget productSpecifications(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                product.name ?? '',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            addToFavoriteIcon(context),
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
        Text(
          (product.price ?? 0).toString(),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
