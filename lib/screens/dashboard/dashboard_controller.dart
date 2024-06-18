import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils.dart';

class DashboardController extends GetxController {
  void logout(BuildContext context) async {
    try {
      await firebaseAuth.signOut();

      showSnackbar(
        context,
        content: 'Logged out successfully',
      );
    } on FirebaseAuthException catch (e) {
      showSnackbar(
        context,
        content:
            'Error occurred while logout! Please try again later ${e.message}',
      );
    }
  }
}
