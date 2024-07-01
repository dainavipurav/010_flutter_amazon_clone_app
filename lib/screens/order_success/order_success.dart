import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils.dart';
import '../dashboard/dashboard.dart';
import '../dashboard/dashboard_controller.dart';

class OrderSuccess extends StatelessWidget {
  const OrderSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Order Successful',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 100,
                right: 0,
                left: 0,
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      await Get.delete<DashboardController>();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const Dashboard(),
                        ),
                        ModalRoute.withName('/'),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      continueShopping,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
