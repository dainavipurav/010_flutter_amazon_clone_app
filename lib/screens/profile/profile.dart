import 'package:amazon/core/utils.dart';
import 'package:amazon/widgets/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'profile_controller.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    if (firebaseAuth.currentUser == null) {
      return const NoDataFound();
    }

    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      children: [
        profileImage(),
        const SizedBox(height: 20),
        editButton(context),
        const SizedBox(height: 20),
        section(email, firebaseAuth.currentUser!.email ?? '-'),
        const SizedBox(height: 20),
        section('Mobile', firebaseAuth.currentUser!.phoneNumber ?? '-'),
        const SizedBox(height: 20),
        section('Gender', firebaseAuth.currentUser!.phoneNumber ?? '-'),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget editButton(BuildContext context) {
    final xController = Get.put(ProfileController());
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
          'Edit Profile',
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
        CircleAvatar(
          radius: 64,
          backgroundColor: Colors.grey.withOpacity(0.3),
          backgroundImage: firebaseAuth.currentUser!.photoURL == null
              ? const AssetImage('assets/images/profile_pic.png')
              : NetworkImage(firebaseAuth.currentUser!.photoURL!),
        ),
        const SizedBox(height: 20),
        sectionHeader(
          firebaseAuth.currentUser!.displayName ??
              firebaseAuth.currentUser!.email ??
              'Anonymous user',
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
            sectionDescription(description),
          ],
        ),
      ),
    );
  }

  Widget sectionHeader(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
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

  // Widget logout(BuildContext context) {
  //   return ElevatedButton.icon(
  //     onPressed: () => firebaseAuth.signOut(),
  //     label: const Text('Logout'),
  //     icon: const Icon(
  //       Icons.power_settings_new_rounded,
  //     ),
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: Theme.of(context).colorScheme.primary,
  //       foregroundColor: Colors.white,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(14),
  //       ),
  //       padding: const EdgeInsets.all(17),
  //     ),
  //   );
  // }
}
