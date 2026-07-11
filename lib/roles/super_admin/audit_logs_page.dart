import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class AuditLogsPage extends StatelessWidget {
  const AuditLogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> _logs = [
      {'action': 'Organiser Verified', 'user': 'Admin_01', 'target': 'Footlab DXB', 'time': '10:45 AM'},
      {'action': 'Club Logo Updated', 'user': 'Admin_02', 'target': 'Core FC', 'time': '09:30 AM'},
      {'action': 'Subscription Changed', 'user': 'System', 'target': 'Elite Academy', 'time': '08:15 AM'},
      {'action': 'Bulk Export', 'user': 'Super_Admin', 'target': 'Analytics DB', 'time': 'Yesterday'},
      {'action': 'New Admin Added', 'user': 'Super_Admin', 'target': 'Admin_03', 'time': 'Yesterday'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('SYSTEM AUDIT LOGS', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(25),
        itemCount: _logs.length,
        itemBuilder: (context, index) {
          final log = _logs[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white.withOpacity(0.02)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.history_toggle_off_rounded, color: Colors.redAccent, size: 18),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(log['action']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 2),
                      Text('By ${log['user']} on ${log['target']}', style: const TextStyle(color: Colors.white38, fontSize: 11)),
                    ],
                  ),
                ),
                Text(log['time']!, style: const TextStyle(color: Colors.white24, fontSize: 10)),
              ],
            ),
          );
        },
      ),
    );
  }
}
