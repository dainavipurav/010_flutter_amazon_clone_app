import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils.dart';
import '../../widgets/search_list_item.dart';
import 'search_list_controller.dart';

class SearchList extends StatelessWidget {
  const SearchList({super.key});

  @override
  Widget build(BuildContext context) {
    final xController = Get.put(SearchListController());
    xController.loadProducts();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Container(
          height: 50,
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 5,
            right: 20,
          ),
          alignment: Alignment.center,
          child: TextField(
            decoration: InputDecoration(
              hintText: searchHint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
            ),
            onChanged: (value) => xController.getProductsBySearchKey(
              value.toLowerCase(),
            ),
          ),
        ),
      ),
      body: Obx(
        () {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemBuilder: (context, index) => SearchListItem(
              product: xController.filteredList[index],
            ),
            itemCount: xController.filteredList.length,
          );
        },
      ),
    );
  }
}
