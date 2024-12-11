import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class HidePage extends StatefulWidget {
  const HidePage({Key? key}) : super(key: key);

  @override
  State<HidePage> createState() => _HidePageState();
}

class _HidePageState extends State<HidePage> {
  final LocalAuthentication auth = LocalAuthentication();
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _authenticateUser();
  }

  Future<void> _authenticateUser() async {
    try {
      bool isAvailable = await auth.canCheckBiometrics;
      log("Biometrics available: $isAvailable");

      if (isAvailable) {
        bool authenticated = await auth.authenticate(
          localizedReason: "Please authenticate to view hidden content",
          options: const AuthenticationOptions(biometricOnly: false),
        );

        setState(() {
          isAuthenticated = authenticated;
        });
      }
    } catch (e) {
      log("Error during authentication: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hidden Page"),
      ),
      body: isAuthenticated
          ? const Center(
              child: Text(
                "🎉 Welcome to the Hidden Content! 🎉",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )
          : const Center(
              child: Text(
                "Authentication failed or canceled.",
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
    );
  }
}
