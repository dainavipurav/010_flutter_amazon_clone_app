import 'package:amazon/screens/sign_up/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils.dart';

class DashboardController extends GetxController {
  void logout(BuildContext context) async {
    try {
      await firebaseAuth.signOut();

      await eraseAllBoxes();

      await setLoginKey(false);

      goToSignupPage(context);

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

  void goToSignupPage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const SignUp(),
      ),
      ModalRoute.withName('/'),
    );
  }
}
