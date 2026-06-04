import 'package:flutter/material.dart';

import '../../../app.dart';
import '../../../shared/widgets/privacy_notice_card.dart';

class LoginRegisterScreen extends StatelessWidget {
  const LoginRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login / Register')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'Continue safely',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text('Mock mode for MVP screens. No credentials are sent or stored.'),
            const SizedBox(height: 24),
            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'Email or phone'),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushReplacementNamed(AppRoutes.home),
              child: const Text('Enter mock app'),
            ),
            const SizedBox(height: 16),
            const PrivacyNoticeCard(
              message: 'Public records should use approximate locations and must not expose reporter identity.',
            ),
          ],
        ),
      ),
    );
  }
}
