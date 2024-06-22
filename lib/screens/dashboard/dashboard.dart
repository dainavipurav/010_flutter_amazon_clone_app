import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils.dart';
import '../home/home.dart';
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
            title: const Text('Dashboard'),
            actions: [
              IconButton(
                onPressed: () => xController.logout(context),
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: bodyContent(xController.selectedIndex.value),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) => xController.selectedIndex(value),
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
        return const Center(
          child: Text(cart),
        );
      case 2:
        return const Center(
          child: Text(profile),
        );
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
