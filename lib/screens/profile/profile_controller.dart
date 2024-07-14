import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

import '../../core/dialog.dart';
import '../../core/enums.dart';
import '../../core/utils.dart';
import '../../models/user_details.dart';
import '../../widgets/image_picker_selection.dart';
import 'edit_profile.dart';

class ProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();

  final usernameFocusNode = FocusNode();
  final firstNameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final mobileFocusNode = FocusNode();

  Rxn<Gender> selectedGender = Rxn();

  Rx<UserDetails> userDetails = Rx(UserDetails());

  RxBool isLoading = RxBool(false);
  RxBool isProfileUpdating = RxBool(false);

  @override
  void dispose() {
    super.dispose();
    disposeFormFields();
  }

  void initializeAllControllers() {
    usernameController.text = userDetails.value.username ?? '';
    firstNameController.text = userDetails.value.firstName ?? '';
    lastNameController.text = userDetails.value.lastName ?? '';
    emailController.text = userDetails.value.email ?? '';
    mobileController.text = userDetails.value.mobile ?? '';
  }

  void goToEditProfilePage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const EditProfile(),
      ),
    );
  }

  Future<void> getUserDetails() async {
    isLoading.value = true;
    final currentUserDocument = await firebaseFirestore
        .collection(userCollectionKey)
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    userDetails.value = UserDetails.fromJson(currentUserDocument.data() ?? {});
    selectedGender.value = userDetails.value.gender;
    isLoading.value = false;
  }

  Future<void> updateProfileDetails(BuildContext context) async {
    if (isProfileUpdating.value) {
      return;
    }

    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    isProfileUpdating.value = true;

    print('saved...');

    UserDetails updatedUserDetails = UserDetails(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: userDetails.value.email,
      gender: selectedGender.value,
      id: firebaseAuth.currentUser!.uid,
      image: userDetails.value.image,
      mobile: mobileController.text,
      password: userDetails.value.password,
      username: usernameController.text,
    );

    print('Updated user details : ${updatedUserDetails.toJson()}');

    await updateDetails(
      context,
      updatedUserDetails: updatedUserDetails,
    );

    isProfileUpdating.value = false;
  }

  Future<void> updateDetails(BuildContext context,
      {required UserDetails updatedUserDetails}) async {
    try {
      await firebaseFirestore
          .collection(userCollectionKey)
          .doc(firebaseAuth.currentUser!.uid)
          .set(updatedUserDetails.toJson());

      userDetails.value = updatedUserDetails;

      showSnackbar(
        context,
        content: profileUpdateSuccess,
      );
    } on FirebaseException catch (e) {
      showSnackbar(
        context,
        content: e.message ?? errorOcurred,
      );
    }
  }

  void clearFocus() {
    if (usernameFocusNode.hasFocus) {
      usernameFocusNode.unfocus();
    }
    if (firstNameFocusNode.hasFocus) {
      firstNameFocusNode.unfocus();
    }
    if (lastNameFocusNode.hasFocus) {
      lastNameFocusNode.unfocus();
    }
    if (emailFocusNode.hasFocus) {
      emailFocusNode.unfocus();
    }
    if (mobileFocusNode.hasFocus) {
      mobileFocusNode.unfocus();
    }
  }

  clearformFields() {
    usernameController.clear();
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    mobileController.clear();
  }

  void disposeFocusNodes() {
    usernameFocusNode.dispose();
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    emailFocusNode.dispose();
    mobileFocusNode.dispose();
  }

  void disposeTextEditingControllers() {
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
  }

  void disposeFormFields() {
    clearFocus();
    clearformFields();
    disposeFocusNodes();
    disposeTextEditingControllers();
  }

  void updateProfileImage(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 20,
      builder: (ctx) => ImagePickerSelection(
        onTap: (type) => pickImage(
          context,
          type: type,
        ),
      ),
    );
  }

  void pickImage(BuildContext context, {required ImagePickerType type}) async {
    Navigator.pop(context);
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedImage = await picker.pickImage(
        source: type == ImagePickerType.camera
            ? ImageSource.camera
            : ImageSource.gallery,
      );

      if (pickedImage == null) {
        showSnackbar(
          context,
          content: type == ImagePickerType.camera
              ? 'No Image captured'
              : 'No Image selected',
        );
        return;
      }

      AmazonDialog.showLoaderDialog(context);

      final pickedFile = File(pickedImage.path);
      final imageExtension = p.extension(pickedFile.path);

      Reference ref = firebaseStorage
          .ref()
          .child(userimages)
          .child('${firebaseAuth.currentUser!.uid}$imageExtension');

      ref.putFile(pickedFile);

      final imageDownloadUrl = await ref.getDownloadURL();

      final updatedUserDetails = userDetails.value;
      updatedUserDetails.image = imageDownloadUrl;

      await updateDetails(
        context,
        updatedUserDetails: updatedUserDetails,
      );

      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      Navigator.pop(context);
      showSnackbar(
        context,
        content: e.message ?? errorOcurred,
      );
      return;
    } on Exception catch (e) {
      Navigator.pop(context);
      showSnackbar(
        context,
        content: e.toString(),
      );
      return;
    }
  }
}
