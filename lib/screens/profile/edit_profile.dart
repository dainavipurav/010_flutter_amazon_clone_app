import 'package:amazon/core/utils.dart';
import 'package:amazon/screens/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final xController = Get.find<ProfileController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: xController.usernameController,
                focusNode: xController.usernameFocusNode,
                decoration: const InputDecoration(labelText: username),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return usernameValidation;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: xController.emailController,
                focusNode: xController.emailFocusNode,
                decoration: const InputDecoration(labelText: email),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.contains('@') == false) {
                    return emailValidation;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: xController.mobileController,
                focusNode: xController.mobileFocusNode,
                decoration: const InputDecoration(labelText: mobile),
                validator: (value) {
                  if (value == null || value.trim().length != 10) {
                    return mobileValidation;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              DropdownButtonFormField(
                items: [
                  DropdownMenuItem(
                    child: Text('Male'),
                    value: 'Male',
                  ),
                  DropdownMenuItem(
                    child: Text('Female'),
                    value: 'Female',
                  ),
                  DropdownMenuItem(
                    child: Text('Other'),
                    value: 'Other',
                  ),
                ],
                onChanged: (value) {},
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
