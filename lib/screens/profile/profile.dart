import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils.dart';
import '../../widgets/no_data_found.dart';
import 'profile_controller.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final xController = Get.put(ProfileController());

  @override
  void initState() {
    xController.getUserDetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (firebaseAuth.currentUser == null) {
      return const NoDataFound();
    }

    return Obx(
      () {
        if (xController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          children: [
            profileImage(),
            const SizedBox(height: 20),
            editButton(),
            const SizedBox(height: 20),
            section(firstName, xController.userDetails.value.firstName ?? '-'),
            const SizedBox(height: 20),
            section(lastName, xController.userDetails.value.lastName ?? '-'),
            const SizedBox(height: 20),
            section(email, xController.userDetails.value.email ?? '-'),
            const SizedBox(height: 20),
            section(mobile, xController.userDetails.value.mobile ?? '-'),
            const SizedBox(height: 20),
            section(
              gender,
              xController.userDetails.value.gender == null
                  ? '-'
                  : xController
                          .userDetails.value.gender!.name.capitalizeFirst ??
                      '',
            ),
            const SizedBox(height: 50),
          ],
        );
      },
    );
  }

  Widget editButton() {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () => xController.goToEditProfilePage(context),
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
        child: const Text(
          editProfile,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget profileImage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 64,
              backgroundColor: Colors.grey.withOpacity(0.3),
              backgroundImage: xController.userDetails.value.image == null ||
                      xController.userDetails.value.image!.trim().isEmpty
                  ? const AssetImage(defaultProfileImagePath)
                  : NetworkImage(xController.userDetails.value.image!),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: CircleAvatar(
                radius: 20,
                child: IconButton(
                  onPressed: () => xController.updateProfileImage(context),
                  icon: const Icon(Icons.edit),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        sectionHeader(
          xController.userDetails.value.username ??
              xController.userDetails.value.email ??
              anonymousUser,
          fontSize: 18,
        )
      ],
    );
  }

  Widget section(String header, String description) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionHeader(header),
            const SizedBox(height: 5),
            sectionDescription(description),
          ],
        ),
      ),
    );
  }

  Widget sectionHeader(
    String text, {
    double fontSize = 14,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget sectionDescription(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
