import 'package:amazon/core/utils.dart';
import 'package:amazon/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

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
