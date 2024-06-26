import 'package:amazon/core/utils.dart';
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
        title: const Text(login),
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
              const SizedBox(height: 16),
              TextFormField(
                controller: xController.passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: password,
                ),
                focusNode: xController.passwordFocusNode,
                validator: (value) {
                  if (value == null || value.trim().length < 6) {
                    return passwordValidation;
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
                  '$forgotPassword?',
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
    );
  }
}
