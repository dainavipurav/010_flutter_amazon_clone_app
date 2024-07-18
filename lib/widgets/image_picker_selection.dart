import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/enums.dart';
import '../core/utils.dart';
import '../screens/profile/profile_controller.dart';

class ImagePickerSelection extends StatelessWidget {
  ImagePickerSelection({
    super.key,
    this.onTap,
    this.showRemoveImageOption = true,
  });

  final void Function(ImagePickerType)? onTap;
  final bool showRemoveImageOption;

  final xController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 24),
      shrinkWrap: true,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            uploadPhoto,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Divider(
          color: Colors.grey,
          height: 0,
        ),
        listItemLayout(type: ImagePickerType.camera),
        Divider(
          color: Colors.grey.withOpacity(0.5),
          height: 0,
        ),
        listItemLayout(type: ImagePickerType.files),
        if (showRemoveImageOption) ...[
          Divider(
            color: Colors.grey.withOpacity(0.5),
            height: 0,
          ),
          listItemLayout(type: ImagePickerType.remove),
        ],
      ],
    );
  }

  Widget listItemLayout({required ImagePickerType type}) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 5,
      ),
      minVerticalPadding: 0,
      title: Text(type.name.capitalizeFirst ?? ''),
      leading: Icon(getIcon(type)),
      onTap: () => onTap!(type),
    );
  }

  IconData getIcon(ImagePickerType type) {
    switch (type) {
      case ImagePickerType.camera:
        return Icons.camera_alt_outlined;
      case ImagePickerType.files:
        return Icons.folder_outlined;
      case ImagePickerType.remove:
        return Icons.delete_outline;
      default:
        return Icons.file_copy;
    }
  }
}
