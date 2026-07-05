import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class GoalHistoryPage extends StatelessWidget {
  const GoalHistoryPage({super.key});

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
        title: const Text('GOALS', 
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
            itemCount: 10,
            itemBuilder: (context, index) {
              return _buildTimelineGoalItem(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineGoalItem(int index) {
    final dates = ['30 JAN 2024', '22 JAN 2024', '22 JAN 2024', '15 JAN 2024'];
    final opponents = ['Dubai City', 'Emirates', 'Emirates', 'United FC'];
    final descriptions = [
      'Header from a precision corner kick into the top left corner.',
      'Low driven penalty finish. Perfect composure.',
      'Tap-in finish after beating the offside trap.',
      'Powerful strike from outside the box.'
    ];
    final times = ["45+1'", "82'", "55'", "12'"];
    
    final date = dates[index % dates.length];
    final opponent = opponents[index % opponents.length];
    final desc = descriptions[index % descriptions.length];
    final time = times[index % times.length];
    final logNumber = 94 - index;

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
                      Text('Goal vs $opponent', 
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      Text(desc, 
                        style: const TextStyle(color: Colors.white38, fontSize: 13, height: 1.5)),
                      const SizedBox(height: 20),
                      const Divider(color: Colors.white10),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Icon(Icons.bolt, color: goldColor, size: 16),
                          const SizedBox(width: 5),
                          Text(time, style: const TextStyle(color: goldColor, fontWeight: FontWeight.bold, fontSize: 12)),
                          const SizedBox(width: 25),
                          const Icon(Icons.analytics_outlined, color: Colors.white38, size: 16),
                          const SizedBox(width: 5),
                          Text('Total Goals Log: $logNumber', style: const TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold)),
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
