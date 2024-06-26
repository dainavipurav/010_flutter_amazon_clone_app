import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils.dart';
import '../login/login.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final createPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final usernameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final createPasswordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  RxBool isLoading = RxBool(false);

  @override
  void dispose() {
    disposeFormFields();

    super.dispose();
  }

  Future<void> signUp(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    clearFocus();
    if (!isValid) {
      return;
    }

    isLoading(true);
    formKey.currentState!.save();

    try {
      UserCredential userCrdentials =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: createPasswordController.text,
      );

      User? user = userCrdentials.user;
      if (user != null && !user.emailVerified) {
        await user.updateDisplayName(usernameController.text);

        print('User Credentials : $userCrdentials');

        await user.sendEmailVerification();

        showSnackbar(
          context,
          content: signUpSuccesMsg,
        );

        goToLoginPage(context);

        clearFocus();
        clearformFields();
      } else {
        showSnackbar(
          context,
          content: errorOcurred,
        );
      }
    } on FirebaseException catch (e) {
      showSnackbar(
        context,
        content: e.message ?? signupErrorMsg,
      );
    }

    isLoading(false);
  }

  void goToLoginPage(BuildContext context) {
    clearformFields();
    clearFocus();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const Login(),
      ),
    );
  }

  void clearFocus() {
    if (usernameFocusNode.hasFocus) {
      usernameFocusNode.unfocus();
    }
    if (emailFocusNode.hasFocus) {
      emailFocusNode.unfocus();
    }
    if (createPasswordFocusNode.hasFocus) {
      createPasswordFocusNode.unfocus();
    }
    if (confirmPasswordFocusNode.hasFocus) {
      confirmPasswordFocusNode.unfocus();
    }
  }

  clearformFields() {
    usernameController.clear();
    emailController.clear();
    createPasswordController.clear();
    confirmPasswordController.clear();
  }

  void disposeFocusNodes() {
    usernameFocusNode.dispose();
    emailFocusNode.dispose();
    createPasswordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
  }

  void disposeTextEditingControllers() {
    usernameController.dispose();
    emailController.dispose();
    createPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  void disposeFormFields() {
    clearFocus();
    clearformFields();
    disposeFocusNodes();
    disposeTextEditingControllers();
  }
}
