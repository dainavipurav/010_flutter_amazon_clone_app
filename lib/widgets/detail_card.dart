import 'package:flutter/material.dart';

import '../core/utils.dart';

class DetailCard extends StatelessWidget {
  final String heading;
  final Widget child;
  final bool showEdit;
  final bool showRadio;
  final bool? isSelected;
  final void Function()? onEditClick;
  final void Function()? onCardSelect;
  const DetailCard({
    super.key,
    required this.heading,
    required this.child,
    this.showEdit = false,
    this.showRadio = false,
    this.onCardSelect,
    this.onEditClick,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: showRadio ? onCardSelect : null,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addressDetails(),
              actionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget actionButtons(BuildContext context) {
    if (!showEdit && !showRadio) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (showEdit) editButton(context),
          if (showRadio) radioButton(context),
        ],
      ),
    );
  }

  Widget radioButton(BuildContext context) {
    return IconButton(
      onPressed: onCardSelect,
      icon: Icon(
        isSelected! ? Icons.radio_button_checked : Icons.radio_button_off,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget addressDetails() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Flexible(child: child),
        ],
      ),
    );
  }

  Widget editButton(BuildContext context) {
    if (!showEdit) {
      return const SizedBox();
    }

    return ElevatedButton(
      onPressed: onEditClick,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: const Text(
        edit,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
