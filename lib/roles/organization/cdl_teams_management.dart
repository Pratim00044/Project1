import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class CdlTeamsManagement extends StatefulWidget {
  const CdlTeamsManagement({super.key});

  @override
  State<CdlTeamsManagement> createState() => _CdlTeamsManagementState();
}

class _CdlTeamsManagementState extends State<CdlTeamsManagement> {
  final List<Map<String, String>> _teams = [
    {'name': 'Core FC', 'logo': 'C'},
    {'name': 'Dubai Lions', 'logo': 'D'},
    {'name': 'Eagle FC', 'logo': 'E'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('CDL TEAMS & LOGOS', style: TextStyle(color: goldColor, fontSize: 14, fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _teams.length,
        itemBuilder: (context, index) {
          final team = _teams[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: surfaceColor, borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: goldColor.withOpacity(0.1),
                  child: Text(team['logo']!, style: const TextStyle(color: goldColor, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 15),
                Text(team['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                const Spacer(),
                const Icon(Icons.edit_outlined, color: Colors.white24, size: 18),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: goldColor,
        onPressed: () => _showAddTeamDialog(),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  void _showAddTeamDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: surfaceColor,
        title: const Text('ADD NEW CDL TEAM', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Team Name',
                hintStyle: const TextStyle(color: Colors.white24),
                filled: true,
                fillColor: Colors.black,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.upload_file),
              label: const Text('UPLOAD LOGO'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white10),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL')),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('CREATE TEAM')),
        ],
      ),
    );
  }
}
