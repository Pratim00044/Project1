import 'package:flutter/material.dart';
import 'squad_selection_page.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class ManagerTeamsPage extends StatelessWidget {
  const ManagerTeamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> teams = [
      {
        'name': 'UNDER 8s',
        'location': 'Town Square',
        'members': 18,
        'category': 'Academy',
        'colors': [const Color(0xFF007CFE), const Color(0xFF004A99)]
      },
      {
        'name': 'UNDER 10s',
        'location': 'Sports City',
        'members': 22,
        'category': 'Academy',
        'colors': [const Color(0xFFFFB75E), const Color(0xFFED8F03)]
      },
      {
        'name': 'UNDER 12s',
        'location': 'Jumeirah',
        'members': 20,
        'category': 'Club',
        'colors': [const Color(0xFF38EF7D), const Color(0xFF11998E)]
      },
      {
        'name': 'SENIOR SQUAD',
        'location': 'Al Barsha',
        'members': 25,
        'category': 'Professional',
        'colors': [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)]
      },
    ];

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('TEAM INVENTORY',
                    style: TextStyle(
                        color: goldColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2)),
                const SizedBox(height: 15),
                const Text('ACTIVE SQUADS',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                const Text('Manage all your active squads and locations from one central hub.',
                    style: TextStyle(color: Colors.white38, fontSize: 13, height: 1.5)),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final team = teams[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SquadSelectionPage()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: team['colors'] as List<Color>,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: (team['colors'] as List<Color>).first.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(Icons.shield, color: Colors.white, size: 30),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(team['name'],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text('${team['location']} | ${team['category']}',
                                  style: const TextStyle(color: Colors.white70, fontSize: 12)),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(team['members'].toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900)),
                            ),
                            const SizedBox(height: 5),
                            const Text('PLAYERS',
                                style: TextStyle(color: Colors.white60, fontSize: 8, fontWeight: FontWeight.bold, letterSpacing: 1)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: teams.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 50)),
      ],
    );
  }
}
