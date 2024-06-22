import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../../widgets/product_list_item.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemBuilder: (context, index) => ProductListItem(
        product: Product.fromJson(
          {
            "id": 26,
            "name": "Instant Pot Duo Evo Plus",
            "description":
                "10-in-1 pressure cooker with easy-seal lid and inner pot.",
            "price": 119.99,
            "available_quantity": 40,
            "cat_id": 2,
            "sub_cat_id": 5,
            "image":
                "https://fastly.picsum.photos/id/10/2500/1667.jpg?hmac=J04WWC_ebchx3WwzbM-Z4_KC_LeLBWr5LZMaAkWkF68"
          },
        ),
      ),
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 250,
      ),
    );
  }
}
