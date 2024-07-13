import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/enums.dart';
import '../../core/utils.dart';
import '../../models/user_details.dart';
import 'edit_profile.dart';

class ProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();

  final usernameFocusNode = FocusNode();
  final firstNameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final mobileFocusNode = FocusNode();

  Rxn<Gender> selectedGender = Rxn();

  Rx<UserDetails> userDetails = Rx(UserDetails());

  RxBool isLoading = RxBool(false);
  RxBool isProfileUpdating = RxBool(false);

  @override
  void dispose() {
    super.dispose();
    disposeFormFields();
  }

  void initializeAllControllers() {
    usernameController.text = userDetails.value.username ?? '';
    firstNameController.text = userDetails.value.firstName ?? '';
    lastNameController.text = userDetails.value.lastName ?? '';
    emailController.text = userDetails.value.email ?? '';
    mobileController.text = userDetails.value.mobile ?? '';
  }

  void goToEditProfilePage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const EditProfile(),
      ),
    );
  }

  Future<void> getUserDetails() async {
    isLoading.value = true;
    final currentUserDocument = await firebaseFirestore
        .collection(userCollectionKey)
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    userDetails.value = UserDetails.fromJson(currentUserDocument.data() ?? {});
    selectedGender.value = userDetails.value.gender;
    isLoading.value = false;
  }

  Future<void> updateProfileDetails(BuildContext context) async {
    if (isProfileUpdating.value) {
      return;
    }

    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    isProfileUpdating.value = true;

    print('saved...');

    UserDetails updatedUserDetails = UserDetails(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: userDetails.value.email,
      gender: selectedGender.value,
      id: firebaseAuth.currentUser!.uid,
      image: userDetails.value.image,
      mobile: mobileController.text,
      password: userDetails.value.password,
      username: usernameController.text,
    );

    print('Updated user details : ${updatedUserDetails.toJson()}');

    try {
      await firebaseFirestore
          .collection(userCollectionKey)
          .doc(firebaseAuth.currentUser!.uid)
          .set(updatedUserDetails.toJson());

      userDetails.value = updatedUserDetails;
      showSnackbar(
        context,
        content: profileUpdateSuccess,
      );
    } on FirebaseException catch (e) {
      showSnackbar(
        context,
        content: e.message ?? errorOcurred,
      );
    }
    isProfileUpdating.value = false;
  }

  void clearFocus() {
    if (usernameFocusNode.hasFocus) {
      usernameFocusNode.unfocus();
    }
    if (firstNameFocusNode.hasFocus) {
      firstNameFocusNode.unfocus();
    }
    if (lastNameFocusNode.hasFocus) {
      lastNameFocusNode.unfocus();
    }
    if (emailFocusNode.hasFocus) {
      emailFocusNode.unfocus();
    }
    if (mobileFocusNode.hasFocus) {
      mobileFocusNode.unfocus();
    }
  }

  clearformFields() {
    usernameController.clear();
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    mobileController.clear();
  }

  void disposeFocusNodes() {
    usernameFocusNode.dispose();
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    emailFocusNode.dispose();
    mobileFocusNode.dispose();
  }

  void disposeTextEditingControllers() {
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
  }

  void disposeFormFields() {
    clearFocus();
    clearformFields();
    disposeFocusNodes();
    disposeTextEditingControllers();
  }
}
