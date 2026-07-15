import 'package:flutter/material.dart';
import 'player_performance_detail.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);

class PlayerProgressDashboard extends StatefulWidget {
  const PlayerProgressDashboard({super.key});

  @override
  State<PlayerProgressDashboard> createState() => _PlayerProgressDashboardState();
}

class _PlayerProgressDashboardState extends State<PlayerProgressDashboard> with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15)),
              child: TabBar(
                controller: _tab,
                indicator: BoxDecoration(color: surfaceColor, borderRadius: BorderRadius.circular(12)),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white24,
                dividerColor: Colors.transparent,
                tabs: const [Tab(text: 'Week'), Tab(text: 'Month'), Tab(text: 'All time')],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildSummaryBox('5', 'Players rated', const Color(0xFF1E3A8A)),
                const SizedBox(width: 12),
                _buildSummaryBox('3.8', 'Squad avg', const Color(0xFF3730A3)),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ALL PLAYERS', style: TextStyle(color: Colors.white24, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                Text('Sort by rating ↓', style: TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildPlayerRow(context, 'James Doe', '5 goals', 4.4, 0.3, [const Color(0xFF007CFE), const Color(0xFF004A99)]),
                _buildPlayerRow(context, 'Marcus Reid', '7 goals', 4.1, 0.5, [const Color(0xFF38EF7D), const Color(0xFF11998E)]),
                _buildPlayerRow(context, 'Sam Khan', '2 goals', 3.5, 0.0, [const Color(0xFFEE0979), const Color(0xFFF12711)]),
                _buildPlayerRow(context, 'Lena Shah', '2 clean sheets', 3.2, -0.2, [const Color(0xFFFFB75E), const Color(0xFFED8F03)]),
                _buildPlayerRow(context, 'Omar Patel', '0 goals', 2.4, -0.4, [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)], needsAttention: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryBox(String val, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Text(val, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerRow(BuildContext context, String name, String stat, double rating, double trend, List<Color> avatarColors, {bool needsAttention = false}) {
    Color ratingColor = Colors.white;
    Color tileColor = avatarColors[0];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerPerformanceDetail(name: name, rating: rating))),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(color: tileColor, borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.black.withOpacity(0.1),
                    backgroundImage: const AssetImage('assets/images/sunil.png'),
                  ),
                  if (needsAttention)
                    Positioned(
                      bottom: 0, right: 0,
                      child: Container(width: 10, height: 10, decoration: BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle, border: Border.all(color: tileColor, width: 2))),
                    ),
                ],
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 2),
                    Text('4 games • $stat', style: const TextStyle(color: Colors.white70, fontSize: 11)),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: rating / 5,
                        minHeight: 3,
                        backgroundColor: Colors.black.withOpacity(0.1),
                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('$rating', style: TextStyle(color: ratingColor, fontSize: 18, fontWeight: FontWeight.w900)),
                  Row(
                    children: [
                      Icon(trend > 0 ? Icons.arrow_upward : (trend < 0 ? Icons.arrow_downward : Icons.remove), color: Colors.white60, size: 10),
                      const SizedBox(width: 4),
                      Text(trend == 0 ? 'same' : '${trend > 0 ? '+' : ''}$trend', style: const TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
