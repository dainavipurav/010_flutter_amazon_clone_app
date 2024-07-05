import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils.dart';
import '../cart/cart.dart';
import '../home/home.dart';
import '../profile/profile.dart';
import 'dashboard_controller.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final xController = Get.put(DashboardController());
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            title: Text(xController.appBarTitle.value),
            actions: [
              IconButton(
                onPressed: () => xController.goToSearchListPage(context),
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () => xController.goToFavoriteListPage(context),
                icon: const Icon(Icons.favorite_outline_rounded),
              ),
              IconButton(
                onPressed: () => xController.logout(context),
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: bodyContent(xController.selectedIndex.value),
          bottomNavigationBar: BottomNavigationBar(
            onTap: xController.changeTab,
            currentIndex: xController.selectedIndex.value,
            items: bottomNavItems(),
          ),
        );
      },
    );
  }

  Widget bodyContent(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return const Home();
      case 1:
        return const Cart();
      case 2:
        return const Profile();
      default:
        return const Home();
    }
  }

  List<BottomNavigationBarItem> bottomNavItems() {
    return const [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.house_outlined,
        ),
        activeIcon: Icon(
          Icons.house,
        ),
        label: home,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.shopping_cart_outlined,
        ),
        activeIcon: Icon(
          Icons.shopping_cart_rounded,
        ),
        label: cart,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person_2_outlined,
        ),
        activeIcon: Icon(
          Icons.person_2,
        ),
        label: profile,
      ),
    ];
  }
}
