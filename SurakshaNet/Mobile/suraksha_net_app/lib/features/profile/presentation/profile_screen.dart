import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/services/app_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const route = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        const CircleAvatar(radius: 36, child: Icon(Icons.person, size: 36)),
        const SizedBox(height: 12),
        const Card(child: ListTile(title: Text('Citizen User'), subtitle: Text('Verification level: Basic\nLanguage: English\nTrusted contacts: placeholder'))),
        const Card(child: ListTile(leading: Icon(Icons.notifications), title: Text('Push notification placeholder'), subtitle: Text('Geo-fenced safety alerts will be enabled here.'))),
        ElevatedButton(onPressed: () { context.read<AppState>().logout(); Navigator.popUntil(context, (route) => route.isFirst); }, child: const Text('Logout')),
      ]),
    );
  }
}
