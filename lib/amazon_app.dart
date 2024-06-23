import 'package:flutter/material.dart';

import 'core/utils.dart';
import 'screens/dashboard/dashboard.dart';
import 'screens/sign_up/sign_up.dart';

class AmazonApp extends StatelessWidget {
  const AmazonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: getUserId.isNotEmpty && getLoginFlagValue
          ? const Dashboard()
          : const SignUp(),
    );
  }
}
