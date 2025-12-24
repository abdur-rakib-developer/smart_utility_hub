import 'package:flutter/material.dart';
import 'dart:async';
import '../constants/app_constants.dart';
import '../auth_gate.dart';

// Splash screen that displays for 2 seconds before navigating to auth gate
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to auth gate after 2 seconds
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AuthGate()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Icon/Logo
            Icon(
              Icons.dashboard_rounded,
              size: 100,
              color: AppConstants.primaryColor,
            ),
            const SizedBox(height: AppConstants.largePadding),
            // App Name
            Text(
              AppConstants.appName,
              style: AppConstants.headingStyle.copyWith(fontSize: 28),
            ),
            const SizedBox(height: AppConstants.smallPadding),
            // Tagline
            Text(
              'Your Personal Utility Hub',
              style: AppConstants.labelStyle,
            ),
            const SizedBox(height: AppConstants.largePadding * 2),
            // Loading indicator
            const CircularProgressIndicator(
              color: AppConstants.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
