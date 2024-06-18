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

  verifyEmail() {
    firebaseAuth.sendSignInLinkToEmail(
      email: emailController.text,
      actionCodeSettings: ActionCodeSettings(
        // URL you want to redirect back to. The domain (www.example.com) for this
        // URL must be whitelisted in the Firebase Console.
        url: 'https://www.example.com/finishSignUp?cartId=1234',
      ),
    );
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

      print('User Credentials : $userCrdentials');

      User user = userCrdentials.user!;
      await user.updateDisplayName(usernameController.text);

      showSnackbar(
        context,
        content: 'Successfully created account',
      );

      disposeFormFields();
      goToLoginPage(context);
    } on FirebaseAuthException catch (e) {
      showSnackbar(
        context,
        content:
            'Error occurred while signing up! Please try again later ${e.message}',
      );
    }

    isLoading(false);
  }

  clearformFields() {
    usernameController.clear();
    emailController.clear();
    createPasswordController.clear();
    confirmPasswordController.clear();
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

  void disposeFormFields() {
    clearformFields();
    disposeFocusNodes();
    disposeTextEditingControllers();
    Get.delete<SignUpController>();
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
}
