import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class AvgPointHistoryPage extends StatelessWidget {
  const AvgPointHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('AVERAGE POINTS', 
          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 4)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purpleAccent.withValues(alpha: 0.03),
              ),
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            itemCount: 4,
            itemBuilder: (context, index) {
              return _buildTimelinePointItem(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimelinePointItem(int index) {
    final seasons = ['UAE PRO LEAGUE 2024', 'GULF CUP 2024', 'PRESIDENTS CUP 2023', 'ACL 2023'];
    final pointValues = ['2.8', '2.5', '2.1', '1.9'];
    final stats = ['P: 10, W: 8, D: 1, L: 1', 'P: 12, W: 9, D: 1, L: 2', 'P: 15, W: 9, D: 4, L: 2', 'P: 6, W: 3, D: 2, L: 1'];
    
    final season = seasons[index % seasons.length];
    final point = pointValues[index % pointValues.length];
    final stat = stats[index % stats.length];

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.purpleAccent.withValues(alpha: 0.5), blurRadius: 10, spreadRadius: 2)
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: 2,
                  color: Colors.purpleAccent.withValues(alpha: 0.3),
                ),
              ),
            ],
          ),
          const SizedBox(width: 25),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(season, 
                  style: const TextStyle(color: Colors.purpleAccent, fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1)),
                const SizedBox(height: 15),
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('SEASON RATING', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                          Text(point, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text('Based on seasonal match performance for CORE FC.', 
                        style: const TextStyle(color: Colors.white38, fontSize: 12, height: 1.5)),
                      const SizedBox(height: 20),
                      const Divider(color: Colors.white10),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Icon(Icons.bar_chart_rounded, color: Colors.purpleAccent, size: 16),
                          const SizedBox(width: 10),
                          Text(stat, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 12)),
                          const Spacer(),
                          const Text('MAX 3.0', style: TextStyle(color: Colors.white24, fontWeight: FontWeight.w900, fontSize: 9)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
