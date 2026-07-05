import 'package:flutter/material.dart';
import 'player_home.dart';
import 'teammate_profile.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class MyTeamsPage extends StatelessWidget {
  const MyTeamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: goldColor.withValues(alpha: 0.1)),
              ),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: goldColor.withValues(alpha: 0.2)),
                    ),
                    child: const Icon(Icons.shield, color: goldColor, size: 30),
                  ),
                  const SizedBox(width: 15),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CORE FC', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('India | Pro League', style: TextStyle(color: Colors.white38, fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Text('TEAMMATES', style: TextStyle(color: Colors.white24, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final teammates = [
                    {'name': 'Gurpreet Singh Sandhu', 'pos': 'Goalkeeper', 'no': '1', 'shooting': '15', 'passing': '82', 'dribbling': '45', 'defending': '90', 'physical': '95', 'saving': '98', 'speed': '65', 'stamina': '88'},
                    {'name': 'Sandesh Jhingan', 'pos': 'Defender', 'no': '5', 'shooting': '40', 'passing': '75', 'dribbling': '55', 'defending': '95', 'physical': '98', 'saving': '10', 'speed': '72', 'stamina': '92'},
                    {'name': 'Sunil Chhetri', 'pos': 'Forward', 'no': '11', 'shooting': '98', 'passing': '88', 'dribbling': '92', 'defending': '45', 'physical': '85', 'saving': '10', 'speed': '88', 'stamina': '94'},
                    {'name': 'Lallianzuala Chhangte', 'pos': 'Winger', 'no': '17', 'shooting': '85', 'passing': '80', 'dribbling': '96', 'defending': '40', 'physical': '78', 'saving': '10', 'speed': '95', 'stamina': '90'},
                    {'name': 'Sahal Abdul Samad', 'pos': 'Midfielder', 'no': '10', 'shooting': '82', 'passing': '95', 'dribbling': '94', 'defending': '65', 'physical': '75', 'saving': '10', 'speed': '82', 'stamina': '88'},
                    {'name': 'Anirudh Thapa', 'pos': 'Midfielder', 'no': '7', 'shooting': '78', 'passing': '92', 'dribbling': '85', 'defending': '75', 'physical': '82', 'saving': '10', 'speed': '80', 'stamina': '95'},
                    {'name': 'Subhasish Bose', 'pos': 'Defender', 'no': '3', 'shooting': '45', 'passing': '78', 'dribbling': '65', 'defending': '88', 'physical': '90', 'saving': '10', 'speed': '78', 'stamina': '92'},
                  ];
                  final member = teammates[index];
                  bool isMe = member['name'] == 'Sunil Chhetri';

                  return GestureDetector(
                    onTap: () {
                      if (isMe) {
                        final homeState = context.findAncestorStateOfType<PlayerHomeState>();
                        if (homeState != null) {
                          homeState.changeTab(3);
                        }
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TeammateProfile(
                              playerName: member['name'],
                              playerPosition: member['pos'],
                              playerNumber: member['no'],
                              playerStats: member,
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: surfaceColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isMe ? goldColor.withValues(alpha: 0.3) : Colors.white.withValues(alpha: 0.03)),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white10,
                            child: Text(member['no']!, style: const TextStyle(color: goldColor, fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(member['name']!, style: TextStyle(color: isMe ? goldColor : Colors.white, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                                Text(member['pos']!, style: const TextStyle(color: Colors.white38, fontSize: 11)),
                              ],
                            ),
                          ),
                          if (isMe)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: goldColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(5)),
                              child: const Text('ME', style: TextStyle(color: goldColor, fontSize: 9, fontWeight: FontWeight.bold)),
                            )
                          else
                            const Icon(Icons.analytics_outlined, color: Colors.white10, size: 20),
                        ],
                      ),
                    ),
                  );
                },
                childCount: 7,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 50)),
        ],
      );
  }

  void _showPlayerStats(BuildContext context, Map<String, String> player) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF080808),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 25),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: goldColor.withValues(alpha: 0.1),
                    child: Text(player['no']!, style: const TextStyle(color: goldColor, fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(player['name']!, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(player['pos']!, style: const TextStyle(color: goldColor, fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              const Text('PLAYER STATUS', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
              const SizedBox(height: 25),
              _buildStatBar('SHOOTING', double.parse(player['shooting']!) / 100, Colors.orange),
              _buildStatBar('PASSING', double.parse(player['passing']!) / 100, Colors.blue),
              _buildStatBar('DRIBBLING', double.parse(player['dribbling']!) / 100, Colors.purple),
              _buildStatBar('DEFENDING', double.parse(player['defending']!) / 100, Colors.teal),
              _buildStatBar('PHYSICAL', double.parse(player['physical']!) / 100, Colors.red),
              _buildStatBar('SAVING', double.parse(player['saving']!) / 100, Colors.greenAccent),
              _buildStatBar('SPEED', double.parse(player['speed']!) / 100, Colors.yellowAccent),
              _buildStatBar('STAMINA', double.parse(player['stamina']!) / 100, Colors.lightBlueAccent),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatBar(String label, double val, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
              Text('${(val * 100).toInt()}%', style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w900)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: val,
              backgroundColor: Colors.white.withValues(alpha: 0.05),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
