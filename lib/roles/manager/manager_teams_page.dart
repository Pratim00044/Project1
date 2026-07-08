import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class ManagerTeamsPage extends StatelessWidget {
  const ManagerTeamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> teams = [
      {'name': 'UNDER 8s', 'location': 'Town Square', 'members': 18, 'category': 'Academy'},
      {'name': 'UNDER 10s', 'location': 'Sports City', 'members': 22, 'category': 'Academy'},
      {'name': 'UNDER 12s', 'location': 'Jumeirah', 'members': 20, 'category': 'Club'},
      {'name': 'SENIOR SQUAD', 'location': 'Al Barsha', 'members': 25, 'category': 'Professional'},
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
                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: goldColor.withValues(alpha: 0.1)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: goldColor.withValues(alpha: 0.2)),
                        ),
                        child: const Icon(Icons.shield, color: goldColor, size: 30),
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
                                style: const TextStyle(color: Colors.white38, fontSize: 12)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: goldColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(team['members'].toString(),
                                style: const TextStyle(
                                    color: goldColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900)),
                          ),
                          const SizedBox(height: 5),
                          const Text('PLAYERS',
                              style: TextStyle(color: Colors.white24, fontSize: 8, fontWeight: FontWeight.bold, letterSpacing: 1)),
                        ],
                      ),
                    ],
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
