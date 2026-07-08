import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class SquadSelectionPage extends StatefulWidget {
  const SquadSelectionPage({super.key});

  @override
  State<SquadSelectionPage> createState() => _SquadSelectionPageState();
}

class _SquadSelectionPageState extends State<SquadSelectionPage> {
  final List<Map<String, dynamic>> _allPlayers = [
    {'name': 'Gurpreet Singh', 'pos': 'GK', 'selected': true},
    {'name': 'Sandesh Jhingan', 'pos': 'CB', 'selected': true},
    {'name': 'Sunil Chhetri', 'pos': 'ST', 'selected': true},
    {'name': 'Sahal Samad', 'pos': 'AM', 'selected': false},
    {'name': 'Anirudh Thapa', 'pos': 'CM', 'selected': false},
    {'name': 'L. Chhangte', 'pos': 'RW', 'selected': false},
  ];

  @override
  Widget build(BuildContext context) {
    int selectedCount = _allPlayers.where((p) => p['selected'] as bool).length;

    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('SQUAD SELECTION', style: TextStyle(color: goldColor, fontWeight: FontWeight.bold, fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text('$selectedCount / 11', style: const TextStyle(color: goldColor, fontWeight: FontWeight.w900, fontSize: 12)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: goldColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: goldColor.withOpacity(0.2)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: goldColor, size: 20),
                  const SizedBox(width: 15),
                  Expanded(child: Text('Select 11 starters and 7 substitutes for the upcoming fixture.', style: TextStyle(color: Colors.white70, fontSize: 12))),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              itemCount: _allPlayers.length,
              itemBuilder: (context, index) {
                final player = _allPlayers[index];
                bool isSelected = player['selected'] as bool;
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: isSelected ? goldColor.withOpacity(0.3) : Colors.transparent),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(radius: 18, backgroundColor: Colors.white10, child: Text(player['pos']!, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold))),
                      const SizedBox(width: 15),
                      Expanded(child: Text(player['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                      Switch(
                        value: isSelected,
                        activeColor: goldColor,
                        onChanged: (val) => setState(() => player['selected'] = val),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: goldColor,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text('CONFIRM MATCH SQUAD', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, letterSpacing: 1)),
            ),
          ),
        ],
      ),
    );
  }
}
