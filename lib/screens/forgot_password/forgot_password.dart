import 'package:amazon/core/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'forgot_password_controller.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final xController = Get.put(ForgotPasswordController());

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          xController.clearformFields();
          xController.clearFocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(forgotPassword),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: xController.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: xController.emailController,
                  decoration: const InputDecoration(
                    labelText: email,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  focusNode: xController.emailFocusNode,
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        !value.contains('@')) {
                      return emailValidation;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Obx(
                  () {
                    return ElevatedButton(
                      onPressed: () => xController.forgotPassword(context),
                      child: xController.isLoading.value
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            )
                          : const Text(resetPassword),
                    );
                  },
                ),
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    text: dontHaveAccount,
                    children: [
                      TextSpan(
                        text: signup,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            xController.goToSignUpPage(context);
                          },
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ],
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
