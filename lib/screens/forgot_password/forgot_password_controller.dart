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

  void clearFocus() {
    if (emailFocusNode.hasFocus) {
      emailFocusNode.unfocus();
    }
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
        content:
            'Password reset email has been sent successfully to registered email address.',
      );
    } on FirebaseAuthException catch (e) {
      showSnackbar(
        context,
        content:
            'Error occurred while reset password! Please try again later ${e.message}',
      );
    }

    isLoading(false);
  }

  clearformFields() {
    emailController.clear();
  }

  void goToSignUpPage(BuildContext context) {
    clearformFields();
    clearFocus();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const SignUp(),
      ),
      ModalRoute.withName('/'),
    );
  }

  void disposeFormFields() {
    clearformFields();
    disposeFocusNodes();
    disposeTextEditingControllers();
  }

  void disposeFocusNodes() {
    emailFocusNode.dispose();
  }

  void disposeTextEditingControllers() {
    emailController.dispose();
  }
}
