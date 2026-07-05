import 'package:flutter/material.dart';
import '../teammate_profile.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class RankingSection extends StatelessWidget {
  const RankingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('GLOBAL RANKINGS',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5)),
          const SizedBox(height: 20),
          _buildRankingCard('Current Rank', '#14', 'Top 5% in Region', Icons.trending_up, Colors.greenAccent),
          const SizedBox(height: 15),
          _buildRankingCard('Club Rank', '#2', 'Star Performer', Icons.shield, goldColor),
          const SizedBox(height: 15),
          _buildRankingCard('Season Points', '2,450', '+250 from last match', Icons.bolt, Colors.blueAccent),
          const SizedBox(height: 30),
          const Text('LEADERBOARD',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5)),
          const SizedBox(height: 15),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              final names = ['L. Messi', 'C. Ronaldo', 'Neymar Jr', 'K. Mbappe', 'E. Haaland'];
              return _buildLeaderboardItem(context, index + 1, index == 0, names[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRankingCard(String label, String value, String sub, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Colors.white38, fontSize: 11)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 24)),
              ],
            ),
          ),
          Text(sub, style: TextStyle(color: color.withValues(alpha: 0.7), fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildLeaderboardItem(BuildContext context, int rank, bool isTop, String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TeammateProfile(
                playerName: name,
                playerPosition: 'Player',
                playerNumber: rank.toString(),
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isTop ? Colors.white.withValues(alpha: 0.05) : surfaceColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Text('$rank', style: TextStyle(color: isTop ? goldColor : Colors.white24, fontWeight: FontWeight.bold)),
              const SizedBox(width: 15),
              const CircleAvatar(radius: 15, backgroundColor: Colors.white10),
              const SizedBox(width: 15),
              Expanded(child: Text(name, style: const TextStyle(color: Colors.white, fontSize: 13))),
              const Text('120 Pts', style: TextStyle(color: Colors.white38, fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }
}
