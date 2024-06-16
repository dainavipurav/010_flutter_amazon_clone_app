import 'package:amazon/core/utils.dart';
import 'package:amazon/screens/dashboard/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'screens/sign_up/sign_up.dart';

class AmazonApp extends StatefulWidget {
  const AmazonApp({super.key});

  @override
  State<AmazonApp> createState() => _AmazonAppState();
}

class _AmazonAppState extends State<AmazonApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<User?>(
        stream: firebaseAuth.authStateChanges(),
        builder: (context, snapshot) => contentByConnectionState(snapshot),
      ),
    );
  }

  Widget contentByConnectionState(
    AsyncSnapshot<User?> snapshot,
  ) {
    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
        return const Center(
          child: CircularProgressIndicator(),
        );

      default:
        if (snapshot.hasData) {
          return const Dashboard();
        }
        return const SignUp();
    }
  }
}
