import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);

class PerformanceDashboard extends StatelessWidget {
  const PerformanceDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header (Initial style as requested)
            Row(
              children: [
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [goldColor, Color(0xFF996515)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(color: goldColor.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))
                    ],
                  ),
                  child: const Center(
                    child: Text('LM', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 20)),
                  ),
                ),
                const SizedBox(width: 20),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Lionel Messi', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                    Text('Performance Analysis', style: TextStyle(color: Colors.white38, fontSize: 13, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 35),
            _buildSectionHeader('SEASON STATS'),
            const SizedBox(height: 15),
            
            // Season Stats Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.1,
              children: [
                _buildStatTile('12', 'Goals'),
                _buildStatTile('7', 'Assists'),
                _buildStatTile('4', 'Clean sheets'),
                _buildStatTile('24', 'Games played'),
                _buildStatTile('87%', 'Attendance'),
                _buildStatTile('4.2', 'Avg rating'),
              ],
            ),

            const SizedBox(height: 35),
            _buildSectionHeader('PLAYER PROGRESS'),
            const SizedBox(height: 25),

            _buildSubHeader('ATTITUDE & BEHAVIOUR'),
            const SizedBox(height: 15),
            _buildProgressRow('Attitude', 4, 0),
            _buildProgressRow('Work ethic', 5, 0),
            _buildProgressRow('Communication', 3, 1),
            _buildProgressRow('Teamwork', 4, 0),
            _buildProgressRow('Readiness to learn', 2, 2),

            const SizedBox(height: 30),
            _buildSubHeader('TECHNICAL'),
            const SizedBox(height: 15),
            _buildProgressRow('Passing', 4, 0),
            _buildProgressRow('Possession', 3, 1),
            _buildProgressRow('Shooting', 5, 0),
            _buildProgressRow('Dribbling', 3, 1),
            _buildProgressRow('Defence', 2, 2),
            _buildProgressRow('Stamina', 4, 0),

            const SizedBox(height: 30),
            // Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem(greenAccent, 'On track'),
                const SizedBox(width: 15),
                _buildLegendItem(Colors.orangeAccent, 'Needs work'),
                const SizedBox(width: 15),
                _buildLegendItem(Colors.redAccent, 'Attention needed'),
              ],
            ),

            const SizedBox(height: 45),
            _buildSectionHeader('COACH FEEDBACK'),
            const SizedBox(height: 20),
            _buildFeedbackItem('JUL 12, 2024', 'Excellent work rate in today\'s training. Focus more on defensive transitions next time.'),
            _buildFeedbackItem('JUL 08, 2024', 'Great vision on the final pass. Keep working on the stamina during high intensity drills.'),
            _buildFeedbackItem('JUL 05, 2024', 'Movement off the ball is improving significantly. Well done on the finishing.'),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title,
        style: const TextStyle(color: goldColor, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5));
  }

  Widget _buildSubHeader(String title) {
    return Text(title,
        style: const TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.2));
  }

  Widget _buildStatTile(String val, String label) {
    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(val, style: const TextStyle(color: goldColor, fontSize: 20, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white38, fontSize: 9, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildProgressRow(String label, int stars, int status) {
    Color statusColor = status == 0 ? greenAccent : (status == 1 ? Colors.orangeAccent : Colors.redAccent);
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star_rounded,
                  color: index < stars ? goldColor : Colors.white.withValues(alpha: 0.05),
                  size: 16,
                );
              }),
            ),
          ),
          Container(
            width: 10, height: 10,
            decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildFeedbackItem(String date, String feedback) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date, style: const TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
              const Icon(Icons.chat_bubble_outline_rounded, color: Colors.white10, size: 14),
            ],
          ),
          const SizedBox(height: 10),
          Text(feedback, style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4)),
        ],
      ),
    );
  }
}
