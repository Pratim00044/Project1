import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class StatsSection extends StatelessWidget {
  final VoidCallback onSeeHistory;

  const StatsSection({super.key, required this.onSeeHistory});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Row(
            children: [
              const Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text('PERFORMANCE ANALYTICS',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5)),
                ),
              ),
            ],
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white.withValues(alpha: 0.1), Colors.transparent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              children: [
                Expanded(child: _buildMainMetric('94', 'GOALS', Icons.sports_soccer)),
                Container(width: 1, height: 35, color: Colors.white10),
                Expanded(child: _buildMainMetric('15', 'ASSISTS', Icons.auto_graph)),
                Container(width: 1, height: 35, color: Colors.white10),
                Expanded(child: _buildMainMetric('151', 'MATCHES', Icons.event_available)),
                Container(width: 1, height: 35, color: Colors.white10),
                Expanded(child: _buildMainMetric('42', 'SAVES', Icons.pan_tool_rounded)),
              ],
            ),
          ),
        ),

        const SizedBox(height: 25),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.5,
            children: [
              _buildSecondaryCard('WIN RATE', '68%', Icons.trending_up, Colors.purpleAccent),
              _buildSecondaryCard('YELLOW', '12', Icons.style, Colors.yellowAccent),
              _buildSecondaryCard('RED CARDS', '2', Icons.style, Colors.redAccent),
              _buildSecondaryCard('RATING', '8.4', Icons.star, Colors.orangeAccent),
            ],
          ),
        ),

        const SizedBox(height: 35),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Players Status',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5)),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _buildAttributeBar('SHOOTING', 0.90, Colors.orange),
              _buildAttributeBar('PASSING', 0.75, Colors.blue),
              _buildAttributeBar('DRIBBLING', 0.82, Colors.purple),
              _buildAttributeBar('DEFENDING', 0.35, Colors.teal),
              _buildAttributeBar('PHYSICAL', 0.88, Colors.red),
              _buildAttributeBar('SAVING', 0.92, Colors.greenAccent),
              _buildAttributeBar('SAVED', 0.85, Colors.lightBlueAccent),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMainMetric(String value, String label, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 16),
        const SizedBox(height: 6),
        FittedBox(
          child: Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900)),
        ),
        FittedBox(
          child: Text(label,
              style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 7,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5)),
        ),
      ],
    );
  }

  Widget _buildSecondaryCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 14),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(value,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900)),
                ),
                FittedBox(
                  child: Text(label,
                      style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 7,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttributeBar(String label, double progress, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1)),
              Text('${(progress * 100).toInt()}%',
                  style: TextStyle(
                      color: color, fontSize: 11, fontWeight: FontWeight.w900)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withValues(alpha: 0.03),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
