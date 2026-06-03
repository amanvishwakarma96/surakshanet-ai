import 'package:flutter/material.dart';

class SolutionSuggestionScreen extends StatefulWidget {
  const SolutionSuggestionScreen({super.key});
  static const route = '/solutions';

  @override
  State<SolutionSuggestionScreen> createState() => _SolutionSuggestionScreenState();
}

class _SolutionSuggestionScreenState extends State<SolutionSuggestionScreen> {
  String type = 'Immediate Safety';
  final title = TextEditingController();
  final description = TextEditingController();
  final types = ['Immediate Safety', 'Department Action', 'Community Action', 'Expert Technical', 'Legal', 'Long-Term Root Cause'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Suggest a Solution')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        const Text('Select verified issue: MVP demo issue #1 - flooded underpass'),
        const SizedBox(height: 12),
        TextField(controller: title, decoration: const InputDecoration(labelText: 'Solution title', border: OutlineInputBorder())),
        const SizedBox(height: 12),
        TextField(controller: description, minLines: 3, maxLines: 5, decoration: const InputDecoration(labelText: 'Solution idea', border: OutlineInputBorder())),
        const SizedBox(height: 12),
        DropdownButtonFormField(value: type, items: types.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(), onChanged: (v) => setState(() => type = v!), decoration: const InputDecoration(labelText: 'Solution type', border: OutlineInputBorder())),
        const SizedBox(height: 12),
        ElevatedButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Solution submitted for verification.'))), child: const Text('Submit for verification')),
      ]),
    );
  }
}
