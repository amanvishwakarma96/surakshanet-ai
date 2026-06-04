import 'package:flutter/material.dart';

import '../../../app.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.verified_user_rounded, size: 76, color: Color(0xFF0F766E)),
              const SizedBox(height: 24),
              Text(
                'SurakshaNet AI',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              Text(
                'Verification-first civic safety alerts with privacy by default.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushReplacementNamed(AppRoutes.loginRegister),
                child: const Text('Get started'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
