import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.verified_user, size: 72, color: Color(0xFF0B3D91)),
          SizedBox(height: 16),
          Text('SurakshaNet AI', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Verification-first civic safety'),
        ]),
      ),
    );
  }
}
