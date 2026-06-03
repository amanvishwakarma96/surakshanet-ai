import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/services/app_state.dart';
import '../../home/presentation/home_screen.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({super.key});
  static const route = '/auth';

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  final email = TextEditingController(text: 'citizen@suraksha.local');
  final password = TextEditingController(text: 'Password123!');
  bool registerMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Citizen Access')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Login or register to report hazards, request verified help, and receive geo-fenced alerts.', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 24),
          TextField(controller: email, decoration: const InputDecoration(labelText: 'Email or mobile', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder())),
          SwitchListTile(value: registerMode, onChanged: (v) => setState(() => registerMode = v), title: const Text('Create a new account')),
          ElevatedButton(
            onPressed: () async {
              await context.read<AppState>().loginOrRegister(email: email.text, password: password.text, register: registerMode);
              if (context.mounted) Navigator.pushReplacementNamed(context, HomeScreen.route);
            },
            child: Text(registerMode ? 'Register' : 'Login'),
          ),
        ],
      ),
    );
  }
}
