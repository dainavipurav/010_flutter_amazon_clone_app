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

      await saveUserData(
        userCrdentials: userCrdentials,
        userPassword: passwordController.text,
      );

      await setLoginKey(true);

      goToDashoardPage(context);

      showSnackbar(
        context,
        content: 'Logged in successfully.',
      );

      clearFocus();
      clearformFields();
    } on FirebaseAuthException catch (e) {
      showSnackbar(
        context,
        content:
            'Error occurred while login! Please try again later ${e.message}',
      );
    }

    isLoading(false);
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
    clearFocus();
    clearformFields();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ForgotPassword(),
      ),
    );
  }

  void goToDashoardPage(BuildContext context) {
    clearFocus();
    clearformFields();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const Dashboard(),
      ),
      ModalRoute.withName('/'),
    );
  }

  void clearFocus() {
    if (emailFocusNode.hasFocus) {
      emailFocusNode.unfocus();
    }
    if (passwordFocusNode.hasFocus) {
      passwordFocusNode.unfocus();
    }
  }

  clearformFields() {
    emailController.clear();
    passwordController.clear();
  }

  void disposeFocusNodes() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  void disposeTextEditingControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  void disposeFormFields() {
    clearFocus();
    clearformFields();
    disposeFocusNodes();
    disposeTextEditingControllers();
  }
}
