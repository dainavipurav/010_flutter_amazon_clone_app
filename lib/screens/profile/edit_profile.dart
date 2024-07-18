import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/enums.dart';
import '../../core/utils.dart';
import 'profile_controller.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  final xController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    xController.initializeAllControllers();
    return Scaffold(
      appBar: AppBar(
        title: const Text(editProfile),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Form(
          key: xController.formKey,
          child: Column(
            children: [
              usernameField(),
              const SizedBox(height: 20),
              firstNameField(),
              const SizedBox(height: 20),
              lastNameField(),
              const SizedBox(height: 20),
              emailField(),
              const SizedBox(height: 20),
              mobileField(),
              const SizedBox(height: 40),
              genderField(),
              const SizedBox(height: 40),
              save(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget genderField() {
    return Obx(
      () {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              gender,
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<Gender>(
              items: [
                DropdownMenuItem(
                  value: Gender.male,
                  child: Text(Gender.male.name.capitalizeFirst!),
                ),
                DropdownMenuItem(
                  value: Gender.female,
                  child: Text(Gender.female.name.capitalizeFirst!),
                ),
                DropdownMenuItem(
                  value: Gender.other,
                  child: Text(Gender.other.name.capitalizeFirst!),
                ),
              ],
              onChanged: (value) {
                xController.selectedGender.value = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              hint: const Text(gender),
              value: xController.selectedGender.value,
            ),
          ],
        );
      },
    );
  }

  Widget mobileField() {
    return TextFormField(
      controller: xController.mobileController,
      focusNode: xController.mobileFocusNode,
      decoration: const InputDecoration(labelText: mobile),
      keyboardType: TextInputType.phone,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      validator: (value) {
        if (value != null && value.length != 10) {
          return validMobileValidation;
        }
        return null;
      },
    );
  }

  Widget emailField() {
    return TextFormField(
      controller: xController.emailController,
      focusNode: xController.emailFocusNode,
      decoration: const InputDecoration(
        labelText: email,
        enabled: false,
      ),
      readOnly: true,
      enabled: false,
    );
  }

  Widget lastNameField() {
    return TextFormField(
      controller: xController.lastNameController,
      focusNode: xController.lastNameFocusNode,
      decoration: const InputDecoration(labelText: lastName),
      keyboardType: TextInputType.name,
    );
  }

  Widget firstNameField() {
    return TextFormField(
      controller: xController.firstNameController,
      focusNode: xController.firstNameFocusNode,
      decoration: const InputDecoration(labelText: firstName),
      keyboardType: TextInputType.name,
    );
  }

  Widget usernameField() {
    return TextFormField(
      controller: xController.usernameController,
      focusNode: xController.usernameFocusNode,
      decoration: const InputDecoration(labelText: username),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return usernameValidation;
        }
        return null;
      },
    );
  }

  Widget save(BuildContext context) {
    return Obx(
      () {
        return ElevatedButton(
          onPressed: () => xController.updateProfileDetails(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
          ),
          child: SizedBox(
            height: 24,
            width: 50,
            child: Center(
              child: xController.isProfileUpdating.value
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      saveText,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
