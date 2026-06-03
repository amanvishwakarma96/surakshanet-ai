import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/services/app_state.dart';
import 'my_reports_screen.dart';

class ReportIncidentScreen extends StatefulWidget {
  const ReportIncidentScreen({super.key, required this.category});
  static const route = '/report';
  final String category;

  @override
  State<ReportIncidentScreen> createState() => _ReportIncidentScreenState();
}

class _ReportIncidentScreenState extends State<ReportIncidentScreen> {
  final description = TextEditingController();
  bool anonymous = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report Incident')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Text(widget.category, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        const ListTile(leading: Icon(Icons.my_location), title: Text('Location captured'), subtitle: Text('MVP placeholder: 12.9716, 77.5946 • exact location is protected for sensitive reports')),
        TextField(controller: description, minLines: 3, maxLines: 5, decoration: const InputDecoration(labelText: 'Optional description/evidence', border: OutlineInputBorder())),
        const SizedBox(height: 12),
        OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.camera_alt), label: const Text('Attach image/video placeholder')),
        SwitchListTile(value: anonymous, onChanged: (v) => setState(() => anonymous = v), title: const Text('Protect my identity publicly'), subtitle: const Text('Public board shows Identity Protected when enabled.')),
        ElevatedButton.icon(
          onPressed: () async {
            await context.read<AppState>().submitIncident(category: widget.category, description: description.text, anonymous: anonymous);
            if (context.mounted) Navigator.pushReplacementNamed(context, MyReportsScreen.route);
          },
          icon: const Icon(Icons.send),
          label: const Text('Submit for AI + human verification'),
        ),
      ]),
    );
  }
}
