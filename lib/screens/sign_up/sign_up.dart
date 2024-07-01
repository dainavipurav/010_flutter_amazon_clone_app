import 'package:amazon/core/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sign_up_controller.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final xController = Get.put(SignUpController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: xController.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: xController.usernameController,
                decoration: const InputDecoration(
                  labelText: username,
                ),
                focusNode: xController.usernameFocusNode,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return usernameValidation;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 16),
              TextFormField(
                controller: xController.createPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: createPassword,
                ),
                focusNode: xController.createPasswordFocusNode,
                validator: (value) {
                  if (value == null || value.trim().length < 6) {
                    return passwordValidation;
                  }
                  if (value.trim() !=
                      xController.confirmPasswordController.text.trim()) {
                    return passwordMatchValidation;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: xController.confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: confirmPassword,
                ),
                focusNode: xController.confirmPasswordFocusNode,
                validator: (value) {
                  if (value == null || value.trim().length < 6) {
                    return passwordValidation;
                  }
                  if (value.trim() !=
                      xController.createPasswordController.text.trim()) {
                    return passwordMatchValidation;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Obx(
                () {
                  return ElevatedButton(
                    onPressed: () => xController.signUp(context),
                    child: xController.isLoading.value
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          )
                        : const Text(signup),
                  );
                },
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  text: alreadyHaveAccount,
                  children: [
                    TextSpan(
                      text: login,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          xController.goToLoginPage(context);
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
    );
  }
}
