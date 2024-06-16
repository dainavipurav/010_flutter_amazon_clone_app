import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final xController = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                controller: xController.passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                focusNode: xController.passwordFocusNode,
                validator: (value) {
                  if (value == null || value.trim().length < 6) {
                    return 'Password should be minimum 6 characters.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: () {
                  xController.goToForgotPasswordPage(context);
                },
                child: Text(
                  'Forgot Password?',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              const SizedBox(height: 24),
              Obx(
                () {
                  return ElevatedButton(
                    onPressed: () => xController.login(context),
                    child: xController.isLoading.value
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Login'),
                  );
                },
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  text: 'Don\'t have an account? ',
                  children: [
                    TextSpan(
                      text: 'Signup',
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
    );
  }
}
