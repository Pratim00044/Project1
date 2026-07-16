import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);

class PlayerPerformanceDetail extends StatelessWidget {
  final String name;
  final String? pos;
  final double rating;
  final bool isReadOnly;

  const PlayerPerformanceDetail({
    super.key,
    required this.name,
    this.pos,
    required this.rating,
    this.isReadOnly = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white70),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Performance Progress', style: TextStyle(color: Colors.white70, fontSize: 14)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header (Image 1 Style)
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: goldColor, width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/images/sunil.png'),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text('$rating', style: const TextStyle(color: goldColor, fontSize: 28, fontWeight: FontWeight.w900)),
                    const Text('Avg rating', style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 30),
            // Metrics (Image 1 Style)
            Row(
              children: [
                _buildStatTile('4', 'Games'),
                const SizedBox(width: 12),
                _buildStatTile('2', 'Goals'),
                const SizedBox(width: 12),
                _buildStatTile('1', 'Assists'),
              ],
            ),
            const SizedBox(height: 40),
            const Text('ATTITUDE', style: TextStyle(color: Colors.white24, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
            const SizedBox(height: 20),
            _buildHorizontalAttribute('Work ethic', 4.0),
            _buildHorizontalAttribute('Communication', 3.0),
            _buildHorizontalAttribute('Teamwork', 3.8),
            const SizedBox(height: 30),
            const Text('TECHNICAL', style: TextStyle(color: Colors.white24, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
            const SizedBox(height: 20),
            _buildHorizontalAttribute('Passing', 5.0),
            _buildHorizontalAttribute('Dribbling', 3.0),
            _buildHorizontalAttribute('Defence', 2.0),
            _buildHorizontalAttribute('Stamina', 4.0),
            const SizedBox(height: 40),
            const Text('GAME HISTORY', style: TextStyle(color: Colors.white24, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
            const SizedBox(height: 20),
            _buildHistoryRow('Apr 16', 'Thursday Social 7s', 3.5),
            _buildHistoryRow('Apr 12', 'Sunday 5s', 4.0),
            _buildHistoryRow('Apr 9', 'Thursday Social 7s', 3.2),
            _buildHistoryRow('Apr 5', 'Saturday 5s', 3.3),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryRow(String date, String game, double r) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          SizedBox(width: 50, child: Text(date, style: const TextStyle(color: Colors.white24, fontSize: 12, fontWeight: FontWeight.bold))),
          Expanded(child: Text(game, style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w700))),
          Text('$r', style: const TextStyle(color: goldColor, fontSize: 14, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }

  Widget _buildStatTile(String val, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(color: surfaceColor, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withValues(alpha: 0.03))),
        child: Column(
          children: [
            Text(val, style: const TextStyle(color: goldColor, fontSize: 20, fontWeight: FontWeight.w900)),
            Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalAttribute(String label, double val) {
    Color statusColor = val >= 4 ? greenAccent : (val >= 3 ? Colors.orangeAccent : Colors.redAccent);
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: val / 5,
                minHeight: 4,
                backgroundColor: Colors.white.withValues(alpha: 0.05),
                valueColor: AlwaysStoppedAnimation(statusColor),
              ),
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 30,
            child: Text(val.toStringAsFixed(1), style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900)),
          ),
          Container(
            width: 8, height: 8,
            decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
          )
        ],
      ),
    );
  }
}
