import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils.dart';
import '../dashboard/dashboard.dart';
import '../forgot_password/forgot_password.dart';
import '../sign_up/sign_up.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

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
    if (passwordFocusNode.hasFocus) {
      passwordFocusNode.unfocus();
    }
  }

  Future<void> login(BuildContext context) async {
    final isValid = formKey.currentState!.validate();

    clearFocus();

    if (!isValid) {
      return;
    }

    isLoading(true);
    formKey.currentState!.save();

    try {
      UserCredential userCrdentials =
          await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      print('User Credentials : $userCrdentials');

      showSnackbar(
        context,
        content: 'Logged in successfully.',
      );

      clearformFields();

      disposeFormFields();

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const Dashboard(),
        ),
        ModalRoute.withName('/'),
      );
    } on FirebaseAuthException catch (e) {
      showSnackbar(
        context,
        content:
            'Error occurred while login! Please try again later ${e.message}',
      );
    }

    isLoading(false);
  }

  clearformFields() {
    emailController.clear();
    passwordController.clear();
  }

  void goToSignUpPage(BuildContext context) {
    clearformFields();
    clearFocus();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const SignUp(),
      ),
    );
  }

  void goToForgotPasswordPage(BuildContext context) {
    clearformFields();
    clearFocus();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ForgotPassword(),
      ),
    );
  }

  void disposeFormFields() {
    clearformFields();
    disposeFocusNodes();
    disposeTextEditingControllers();
    Get.delete<LoginController>();
  }

  void disposeFocusNodes() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  void disposeTextEditingControllers() {
    emailController.dispose();
    passwordController.dispose();
  }
}
