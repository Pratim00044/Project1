import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class TrophyHistoryPage extends StatelessWidget {
  const TrophyHistoryPage({super.key});

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
        title: const Text('TROPHY CABINET', 
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
                color: goldColor.withValues(alpha: 0.05),
              ),
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            itemCount: 4,
            itemBuilder: (context, index) {
              return _buildTimelineTrophyItem(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineTrophyItem(int index) {
    final dates = ['20 MAY 2024', '15 FEB 2024', '10 DEC 2023', '05 SEP 2023'];
    final trophies = ['UAE PRO LEAGUE', 'GULF CUP', 'PRESIDENTS CUP', 'SUPER CUP'];
    final opponents = ['Dubai City FC', 'United FC', 'Eagle FC', 'Emirates Club'];
    
    final date = dates[index % dates.length];
    final trophy = trophies[index % trophies.length];
    final opponent = opponents[index % opponents.length];

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
                  color: goldColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: goldColor.withValues(alpha: 0.5), blurRadius: 10, spreadRadius: 2)
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: 2,
                  color: goldColor.withValues(alpha: 0.3),
                ),
              ),
            ],
          ),
          const SizedBox(width: 25),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date, 
                  style: const TextStyle(color: goldColor, fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1)),
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
                          Expanded(
                            child: Text(trophy, 
                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          const Icon(Icons.emoji_events_rounded, color: goldColor, size: 24),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text('CHAMPIONS WITH CORE FC', style: TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
                      const SizedBox(height: 20),
                      const Divider(color: Colors.white10),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Icon(Icons.groups_outlined, color: Colors.white38, size: 16),
                          const SizedBox(width: 8),
                          const Text('Final vs:', style: TextStyle(color: Colors.white38, fontSize: 12)),
                          const SizedBox(width: 8),
                          Text(opponent, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
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
