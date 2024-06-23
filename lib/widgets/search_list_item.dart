import 'package:flutter/material.dart';

import '../core/utils.dart';
import '../models/product.dart';

class SearchListItem extends StatelessWidget {
  const SearchListItem({
    required this.product,
    super.key,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              image(),
              const SizedBox(width: 10),
              productSpecifications(context),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: addToFavoriteIcon(context),
          ),
        ],
      ),
    );
  }

  Widget addToFavoriteIcon(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        onPressed: () => addToFavoriteList(product.id),
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
      ),
    );
  }
}
