import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class CleanSheetHistoryPage extends StatelessWidget {
  const CleanSheetHistoryPage({super.key});

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
        title: const Text('CLEAN SHEETS', 
          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 4)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.tealAccent.withValues(alpha: 0.03),
              ),
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            itemCount: 8,
            itemBuilder: (context, index) {
              return _buildTimelineCleanSheetItem(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCleanSheetItem(int index) {
    final dates = ['12 JUL 2024', '08 JUL 2024', '01 JUL 2024', '25 JUN 2024'];
    final opponents = ['Dubai City FC', 'United FC', 'Eagle FC', 'Emirates Club'];
    final keepers = ['Vishal Kaith', 'Gurpreet Singh', 'Amrinder Singh', 'Phurba Lachenpa'];
    
    final date = dates[index % dates.length];
    final opponent = opponents[index % opponents.length];
    final keeper = keepers[index % keepers.length];

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
                  color: Colors.tealAccent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.tealAccent.withValues(alpha: 0.5), blurRadius: 10, spreadRadius: 2)
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: 2,
                  color: Colors.tealAccent.withValues(alpha: 0.3),
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
                  style: const TextStyle(color: Colors.tealAccent, fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1)),
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
                          Text('vs $opponent', 
                            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          const Icon(Icons.shield_outlined, color: Colors.tealAccent, size: 20),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text('CORE FC defense kept a clean sheet throughout the match.', 
                        style: const TextStyle(color: Colors.white38, fontSize: 12, height: 1.5)),
                      const SizedBox(height: 20),
                      const Divider(color: Colors.white10),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.tealAccent.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.person, color: Colors.tealAccent, size: 14),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('GOALKEEPER', style: TextStyle(color: Colors.white24, fontSize: 8, fontWeight: FontWeight.bold)),
                              Text(keeper, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                          const Spacer(),
                          const Text('CS LOG: 100%', style: TextStyle(color: Colors.tealAccent, fontWeight: FontWeight.w900, fontSize: 9)),
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
