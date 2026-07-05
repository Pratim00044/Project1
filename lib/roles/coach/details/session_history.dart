import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class SessionHistoryPage extends StatelessWidget {
  const SessionHistoryPage({super.key});

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
        title: const Text('TRAINING SESSIONS', 
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
                color: Colors.redAccent.withValues(alpha: 0.05),
              ),
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            itemCount: 10,
            itemBuilder: (context, index) {
              return _buildTimelineSessionItem(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineSessionItem(int index) {
    final dates = ['12 JUL 2024', '11 JUL 2024', '10 JUL 2024', '09 JUL 2024'];
    final types = ['TACTICAL DRILL', 'FITNESS SESSION', 'SET PIECES', 'PRACTICE MATCH'];
    final times = ['08:00 AM', '10:30 AM', '04:00 PM', '06:00 PM'];
    
    final date = dates[index % dates.length];
    final type = types[index % types.length];
    final time = times[index % times.length];

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
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.redAccent.withValues(alpha: 0.5), blurRadius: 10, spreadRadius: 2)
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: 2,
                  color: Colors.redAccent.withValues(alpha: 0.3),
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
                  style: const TextStyle(color: Colors.redAccent, fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1)),
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
                          Text(type, 
                            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          const Icon(Icons.fitness_center_rounded, color: Colors.redAccent, size: 20),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text('CORE FC team training session scheduled.', 
                        style: TextStyle(color: Colors.white38, fontSize: 12, height: 1.5)),
                      const SizedBox(height: 20),
                      const Divider(color: Colors.white10),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Icon(Icons.access_time_rounded, color: Colors.white38, size: 14),
                          const SizedBox(width: 8),
                          Text(time, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                          const Spacer(),
                          const Icon(Icons.check_circle_rounded, color: Colors.greenAccent, size: 16),
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
