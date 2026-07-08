import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class PlayerProfilesManagement extends StatefulWidget {
  const PlayerProfilesManagement({super.key});

  @override
  State<PlayerProfilesManagement> createState() => _PlayerProfilesManagementState();
}

class _PlayerProfilesManagementState extends State<PlayerProfilesManagement> {
  final List<Map<String, String>> _players = [
    {'name': 'Ryan Cooper', 'team': 'Street League FC', 'pos': 'FWD'},
    {'name': 'Ahmed Al Rashid', 'team': 'National Gulf FC', 'pos': 'MID'},
    {'name': 'Carlos Silva', 'team': 'National Paints FC', 'pos': 'DEF'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('CDL PLAYER PROFILES', style: TextStyle(color: goldColor, fontWeight: FontWeight.bold, fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_add_alt_1_outlined, color: goldColor),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _players.length,
        itemBuilder: (context, index) {
          final player = _players[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.03)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: goldColor.withOpacity(0.1),
                  child: const Icon(Icons.person_outline, color: goldColor, size: 20),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(player['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 4),
                      Text('${player['team']} | ${player['pos']}', style: const TextStyle(color: Colors.white38, fontSize: 11)),
                    ],
                  ),
                ),
                const Icon(Icons.edit_note_rounded, color: Colors.white24, size: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
