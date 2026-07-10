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
          const Row(
            children: [
              Icon(Icons.emoji_events_rounded, color: goldColor, size: 20),
              SizedBox(width: 10),
              Text('GLOBAL RANKINGS',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5)),
            ],
          ),
          const SizedBox(height: 20),
          _buildRankingColoredCard(0, 'Current Rank', '#14', 'Top 5% in Region', Icons.trending_up, [const Color(0xFF007CFE), const Color(0xFF004A99)]),
          const SizedBox(height: 15),
          _buildRankingColoredCard(1, 'Season Points', '2,450', '+250 from last match', Icons.bolt, [const Color(0xFF38EF7D), const Color(0xFF11998E)]),
          const SizedBox(height: 30),
          const Text('LEADERBOARD',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
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

  Widget _buildRankingColoredCard(int index, String label, String value, String sub, IconData icon, List<Color> colors) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors[0].withValues(alpha: 0.8),
            colors[1].withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: AssetImage('assets/images/img${(index % 4) + 1}.jpeg'),
          fit: BoxFit.cover,
          opacity: 0.4,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 24)),
              ],
            ),
          ),
          Text(sub, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
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
            color: isTop ? Colors.white.withValues(alpha: 0.05) : const Color(0xFF121212),
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
