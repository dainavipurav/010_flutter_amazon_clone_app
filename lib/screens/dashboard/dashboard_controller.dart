import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils.dart';
import '../search_list/search_list.dart';
import '../sign_up/sign_up.dart';
import '../wish_list/wish_list.dart';

class DashboardController extends GetxController {
  RxInt selectedIndex = RxInt(0);

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

  void goToSearchListPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchList(),
      ),
    );
  }

  void goToFavoriteListPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WishList(),
      ),
    );
  }
}
