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
    {'name': 'Lionel Messi', 'team': 'Core FC', 'no': '10'},
    {'name': 'Ryan Cooper', 'team': 'Street League FC', 'no': '09'},
    {'name': 'Kevin De Bruyne', 'team': 'National Gulf FC', 'no': '08'},
    {'name': 'Carlos Silva', 'team': 'National Paints FC', 'no': '04'},
    {'name': 'Cristiano Ronaldo', 'team': 'Core FC', 'no': '07'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
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
                final List<List<Color>> cardGradients = [
                  [const Color(0xFF2E5B4F), const Color(0xFF3B2A50)],
                  [const Color(0xFF1E3A8A), const Color(0xFF312E81)],
                  [const Color(0xFF064E3B), const Color(0xFF14532D)],
                  [const Color(0xFF334155), const Color(0xFF1E293B)],
                  [const Color(0xFF4C1D95), const Color(0xFF2E1065)],
                ];
                final List<Color> cardGradient = cardGradients[index % cardGradients.length];
                
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerProfile(
                          playerName: player['name']!,
                          playerNumber: player['no'],
                          isReadOnly: true,
                          showBackButton: true,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: cardGradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(color: cardGradient[0].withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 5))
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 1.5),
                          ),
                          child: const CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.white24,
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
                                  color: Colors.white, 
                                  fontWeight: FontWeight.w900, 
                                  fontSize: 15
                                )
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(player['team']!, 
                                    style: const TextStyle(
                                      color: Colors.white70, 
                                      fontSize: 10, 
                                      fontWeight: FontWeight.bold
                                    )
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.circle, size: 4, color: Colors.white24),
                                  const SizedBox(width: 8),
                                  Text('#${player['no']!}',
                                    style: const TextStyle(
                                      color: Colors.white60, 
                                      fontSize: 10
                                    )
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded, color: Colors.white, size: 24),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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
