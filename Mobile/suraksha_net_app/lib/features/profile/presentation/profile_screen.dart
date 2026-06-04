import 'package:flutter/material.dart';

import '../../../shared/widgets/privacy_notice_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const CircleAvatar(radius: 36, child: Icon(Icons.person_rounded, size: 40)),
            const SizedBox(height: 16),
            Text(
              'Mock Citizen',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text('MVP user profile placeholder', textAlign: TextAlign.center),
            const SizedBox(height: 24),
            const PrivacyNoticeCard(
              message: 'Exact location sharing remains consent-based and should be enabled only for verified help flows.',
            ),
            const SizedBox(height: 12),
            Card(
              child: SwitchListTile.adaptive(
                value: false,
                onChanged: null,
                title: const Text('Exact location sharing'),
                subtitle: const Text('Disabled in foundation build.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
