import 'package:flutter/material.dart';

import 'screens/sign_up/sign_up.dart';

class AmazonApp extends StatelessWidget {
  const AmazonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SignUp(),
    );
  }
}
