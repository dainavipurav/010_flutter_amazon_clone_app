import 'package:flutter/material.dart';

class AmazonDialog {
  static void showLoaderDialog(BuildContext context,
      {String msg = 'Loading...'}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(
                    strokeWidth: 2.5,
                  ),
                  const SizedBox(height: 10),
                  Text(msg),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
