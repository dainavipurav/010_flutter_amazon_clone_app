import 'package:flutter/material.dart';

import '../core/utils.dart';

class DetailCard extends StatelessWidget {
  final String heading;
  final bool showEdit;
  final Widget child;
  const DetailCard({
    super.key,
    required this.heading,
    this.showEdit = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    heading,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                if (showEdit)
                  ElevatedButton(
                    onPressed: () => showSnackbar(
                      context,
                      content: 'Functionality pending',
                    ),
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
                  ),
              ],
            ),
            Flexible(child: child),
          ],
        ),
      ),
    );
  }
}
