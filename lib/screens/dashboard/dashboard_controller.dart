import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils.dart';
import '../search_list/search_list.dart';
import '../sign_up/sign_up.dart';
import '../favorite_list/favorite_list.dart';

class DashboardController extends GetxController {
  RxInt selectedIndex = RxInt(0);
  RxString appBarTitle = RxString('Home');

  void logout(BuildContext context) async {
    try {
      await firebaseAuth.signOut();

      await eraseAllBoxes();

      await setLoginKey(false);

      goToSignupPage(context);

      showSnackbar(
        context,
        content: logoutSuccess,
      );
    } on FirebaseAuthException catch (e) {
      showSnackbar(
        context,
        content: '$logoutError ${e.message}',
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
        builder: (context) => const FavoriteList(),
      ),
    );
  }

  void changeTab(int index) {
    selectedIndex(index);
    appBarTitle.value = setAppBarTitle();
  }

  String setAppBarTitle() {
    switch (selectedIndex.value) {
      case 0:
        return home;
      case 1:
        return cart;
      case 2:
        return profile;
      default:
        return home;
    }
  }
}
