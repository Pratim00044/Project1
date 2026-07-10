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
    {'name': 'Manuel Neuer', 'pos': 'GK', 'role': 'STARTER'},
    {'name': 'Virgil van Dijk', 'pos': 'CB', 'role': 'STARTER'},
    {'name': 'Harry Kane', 'pos': 'ST', 'role': 'STARTER'},
    {'name': 'Luka Modrić', 'pos': 'AM', 'role': 'NONE'},
    {'name': 'Jude Bellingham', 'pos': 'CM', 'role': 'NONE'},
    {'name': 'Mohamed Salah', 'pos': 'RW', 'role': 'NONE'},
    {'name': 'Kevin De Bruyne', 'pos': 'CM', 'role': 'NONE'},
    {'name': 'Kylian Mbappé', 'pos': 'LW', 'role': 'NONE'},
    {'name': 'Erling Haaland', 'pos': 'ST', 'role': 'NONE'},
    {'name': 'Alphonso Davies', 'pos': 'LB', 'role': 'NONE'},
    {'name': 'Achraf Hakimi', 'pos': 'RB', 'role': 'NONE'},
    {'name': 'Ruben Dias', 'pos': 'CB', 'role': 'NONE'},
    {'name': 'Rodri', 'pos': 'CDM', 'role': 'NONE'},
    {'name': 'Vinícius Júnior', 'pos': 'LW', 'role': 'NONE'},
    {'name': 'Bukayo Saka', 'pos': 'RW', 'role': 'NONE'},
    {'name': 'Marcus Rashford', 'pos': 'LW', 'role': 'NONE'},
    {'name': 'Declan Rice', 'pos': 'CDM', 'role': 'NONE'},
    {'name': 'Bruno Fernandes', 'pos': 'CAM', 'role': 'NONE'},
    {'name': 'Martin Ødegaard', 'pos': 'CAM', 'role': 'NONE'},
    {'name': 'Jan Oblak', 'pos': 'GK', 'role': 'NONE'},
    {'name': 'Jack Grealish', 'pos': 'LW', 'role': 'NONE'},
    {'name': 'Phil Foden', 'pos': 'RW', 'role': 'NONE'},
  ];

  int get starterCount => _allPlayers.where((p) => p['role'] == 'STARTER').length;
  int get subCount => _allPlayers.where((p) => p['role'] == 'SUB').length;

  void _toggleRole(int index, String role) {
    setState(() {
      if (_allPlayers[index]['role'] == role) {
        _allPlayers[index]['role'] = 'NONE';
      } else {
        if (role == 'STARTER' && starterCount >= 11) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Limit of 11 Starters reached!'), backgroundColor: Colors.redAccent),
          );
          return;
        }
        if (role == 'SUB' && subCount >= 7) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Limit of 7 Substitutes reached!'), backgroundColor: Colors.redAccent),
          );
          return;
        }
        _allPlayers[index]['role'] = role;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        title: const Text('SQUAD SELECTION', style: TextStyle(color: goldColor, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('STARTERS: $starterCount / 11', style: const TextStyle(color: goldColor, fontWeight: FontWeight.w900, fontSize: 9)),
                  Text('SUBS: $subCount / 7', style: const TextStyle(color: Colors.white38, fontWeight: FontWeight.w900, fontSize: 9)),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: goldColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: goldColor.withOpacity(0.1)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: goldColor, size: 18),
                  SizedBox(width: 12),
                  Expanded(child: Text('Select 11 starters and 7 substitutes for your matchday squad.', style: TextStyle(color: Colors.white60, fontSize: 11))),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _allPlayers.length,
              itemBuilder: (context, index) {
                final player = _allPlayers[index];
                String role = player['role'];
                bool isStarter = role == 'STARTER';
                bool isSub = role == 'SUB';

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: role != 'NONE' ? goldColor.withOpacity(0.2) : Colors.white.withOpacity(0.05)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: isStarter ? goldColor : (isSub ? Colors.blueAccent.withOpacity(0.2) : Colors.white.withOpacity(0.05)),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(player['pos']!, style: TextStyle(color: isStarter ? Colors.black : Colors.white38, fontSize: 9, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(player['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                            if (role != 'NONE')
                              Text(role, style: TextStyle(color: isStarter ? goldColor : Colors.blueAccent, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          _roleButton('STARTER', isStarter, () => _toggleRole(index, 'STARTER')),
                          const SizedBox(width: 8),
                          _roleButton('SUB', isSub, () => _toggleRole(index, 'SUB')),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  if (starterCount == 11 && subCount == 7)
                    BoxShadow(color: goldColor.withOpacity(0.2), blurRadius: 15, offset: const Offset(0, 5))
                ],
              ),
              child: ElevatedButton(
                onPressed: (starterCount == 11 && subCount == 7) ? () => Navigator.pop(context) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: goldColor,
                  disabledBackgroundColor: Colors.white10,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 0,
                ),
                child: Text(
                  (starterCount == 11 && subCount == 7) ? 'CONFIRM MATCH SQUAD' : 'SELECT FULL SQUAD (${starterCount + subCount}/18)', 
                  style: TextStyle(color: (starterCount == 11 && subCount == 7) ? Colors.black : Colors.white24, fontWeight: FontWeight.w900, letterSpacing: 1, fontSize: 13)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _roleButton(String label, bool isSelected, VoidCallback onTap) {
    Color activeColor = label == 'STARTER' ? goldColor : Colors.blueAccent;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? Colors.transparent : Colors.white.withOpacity(0.05)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? (label == 'STARTER' ? Colors.black : Colors.white) : Colors.white24,
            fontSize: 8,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
