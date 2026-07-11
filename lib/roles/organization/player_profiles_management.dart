import 'package:flutter/material.dart';
import '../player/player_profile.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class PlayerProfilesManagement extends StatefulWidget {
  const PlayerProfilesManagement({super.key});

  @override
  State<PlayerProfilesManagement> createState() => _PlayerProfilesManagementState();
}

class _PlayerProfilesManagementState extends State<PlayerProfilesManagement> {
  final List<Map<String, String>> _players = [
    {'name': 'Lionel Messi', 'team': 'Core FC', 'pos': 'FORWARD', 'no': '10'},
    {'name': 'Ryan Cooper', 'team': 'Street League FC', 'pos': 'FORWARD', 'no': '09'},
    {'name': 'Kevin De Bruyne', 'team': 'National Gulf FC', 'pos': 'MIDFIELDER', 'no': '08'},
    {'name': 'Carlos Silva', 'team': 'National Paints FC', 'pos': 'DEFENDER', 'no': '04'},
    {'name': 'Cristiano Ronaldo', 'team': 'Core FC', 'pos': 'FORWARD', 'no': '07'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        centerTitle: true,
        title: const Text('PLAYER PROFILES', style: TextStyle(color: goldColor, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(25, 20, 25, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SQUAD ROSTER', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                Text('Select a player to view and edit performance stats', style: TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: _players.length,
              itemBuilder: (context, index) {
                final player = _players[index];
  List<Color> cardColors = _getAlternatingColors(index);
                
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerProfile(
                          playerName: player['name'],
                          playerPosition: player['pos'],
                          playerNumber: player['no'],
                          isReadOnly: true,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: cardColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(color: cardColors.first.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 4))
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1),
                          ),
                          child: const CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.black,
                            backgroundImage: AssetImage('assets/images/sunil.png'),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(player['name']!.toUpperCase(), 
                                style: const TextStyle(
                                  color: Colors.black, 
                                  fontWeight: FontWeight.w900, 
                                  fontSize: 15
                                )
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(player['team']!, 
                                    style: const TextStyle(
                                      color: Colors.black87, 
                                      fontSize: 10, 
                                      fontWeight: FontWeight.bold
                                    )
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.circle, size: 4, color: Colors.black26),
                                  const SizedBox(width: 8),
                                  Text(player['pos']!, 
                                    style: const TextStyle(
                                      color: Colors.black54, 
                                      fontSize: 10
                                    )
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded, color: Colors.black, size: 24),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Color> _getAlternatingColors(int index) {
    if (index % 2 == 0) {
      // Light Green
      return [const Color(0xFFB9F6CA), const Color(0xFFA7FFEB)];
    } else {
      // Light Grey
      return [const Color(0xFFE0E0E0), const Color(0xFFBDBDBD)];
    }
  }
}
