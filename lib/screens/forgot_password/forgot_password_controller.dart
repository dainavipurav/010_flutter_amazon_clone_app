import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils.dart';
import '../sign_up/sign_up.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final emailFocusNode = FocusNode();

  RxBool isLoading = RxBool(false);

  @override
  void dispose() {
    disposeFormFields();
    super.dispose();
  }

  Future<void> forgotPassword(BuildContext context) async {
    final isValid = formKey.currentState!.validate();

    clearFocus();

    if (!isValid) {
      return;
    }

    isLoading(true);
    formKey.currentState!.save();

    try {
      await firebaseAuth.sendPasswordResetEmail(
        email: emailController.text,
      );

      showSnackbar(
        context,
        content: passwordResetMsg,
      );

      clearFocus();
      clearformFields();
    } on FirebaseAuthException catch (e) {
      showSnackbar(
        context,
        content: '$passwordResetError ${e.message}',
      );
    }

    isLoading(false);
  }

  void goToSignUpPage(BuildContext context) {
    clearFocus();
    clearformFields();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const SignUp(),
      ),
      ModalRoute.withName('/'),
    );
  }

  void clearFocus() {
    if (emailFocusNode.hasFocus) {
      emailFocusNode.unfocus();
    }
  }

  clearformFields() {
    emailController.clear();
  }

  void disposeFocusNodes() {
    emailFocusNode.dispose();
  }

  void disposeTextEditingControllers() {
    emailController.dispose();
  }

  void disposeFormFields() {
    clearFocus();
    clearformFields();
    disposeFocusNodes();
    disposeTextEditingControllers();
  }
}
