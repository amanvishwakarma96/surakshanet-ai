import 'package:flutter/material.dart';

class HelpRequestScreen extends StatefulWidget {
  const HelpRequestScreen({super.key});
  static const route = '/help';

  @override
  State<HelpRequestScreen> createState() => _HelpRequestScreenState();
}

class _HelpRequestScreenState extends State<HelpRequestScreen> {
  String helpType = 'I am stuck';
  bool immediateDanger = false;
  final message = TextEditingController();
  final quickHelp = ['I am stuck', 'I feel unsafe', 'Need route guidance', 'Vehicle breakdown', 'Medical help'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('I Need Help')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        DropdownButtonFormField(value: helpType, items: quickHelp.map((h) => DropdownMenuItem(value: h, child: Text(h))).toList(), onChanged: (v) => setState(() => helpType = v!), decoration: const InputDecoration(labelText: 'Quick help', border: OutlineInputBorder())),
        const SizedBox(height: 12),
        TextField(controller: message, minLines: 3, maxLines: 5, decoration: const InputDecoration(labelText: 'Message', border: OutlineInputBorder())),
        SwitchListTile(value: immediateDanger, onChanged: (v) => setState(() => immediateDanger = v), title: const Text('Are you in immediate danger?')),
        if (immediateDanger) const Card(child: Padding(padding: EdgeInsets.all(16), child: Text('Emergency options: call local emergency services, share trusted contact, and move to a safer visible area if possible.'))),
        ElevatedButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Verified helper request created with approximate location first.'))), child: const Text('Create verified helper request')),
      ]),
    );
  }
}
