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
                  labelText: 'Username',
                ),
                focusNode: xController.usernameFocusNode,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Username can\'t be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: xController.emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                focusNode: xController.emailFocusNode,
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: xController.createPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Create Password',
                ),
                focusNode: xController.createPasswordFocusNode,
                validator: (value) {
                  if (value == null || value.trim().length < 6) {
                    return 'Password should be minimum 6 characters.';
                  }
                  if (value.trim() !=
                      xController.confirmPasswordController.text.trim()) {
                    return 'Password doesn\'t match.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: xController.confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                ),
                focusNode: xController.confirmPasswordFocusNode,
                validator: (value) {
                  if (value == null || value.trim().length < 6) {
                    return 'Password should be minimum 6 characters.';
                  }
                  if (value.trim() !=
                      xController.createPasswordController.text.trim()) {
                    return 'Password doesn\'t match.';
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
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Sign Up'),
                  );
                },
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  children: [
                    TextSpan(
                      text: 'Login',
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
