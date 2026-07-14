import 'package:flutter/material.dart';
import '../player_home.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);
const Color darkBg = Color(0xFF000000);

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> progressData = [
      {'label': 'WEEKLY', 'value': '04', 'desc': 'Matches played this week'},
      {'label': 'MONTHLY', 'value': '18', 'desc': 'Matches played this month'},
      {'label': 'QUARTERLY', 'value': '52', 'desc': 'Matches in last 3 months'},
      {'label': 'HALF YEARLY', 'value': '94', 'desc': 'Matches in last 6 months'},
      {'label': 'YEARLY', 'value': '151', 'desc': 'Total matches this year'},
    ];

    final List<String> tileImages = [
      'assets/images/img1.jpeg',
      'assets/images/img2.jpeg',
      'assets/images/img3.jpeg',
      'assets/images/img4.jpeg',
    ];

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        centerTitle: true,
        title: const Text('MATCH PROGRESS',
            style: TextStyle(
                color: goldColor,
                fontSize: 16,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: progressData.length,
        itemBuilder: (context, index) {
          final data = progressData[index];
          final bool isEven = index % 2 == 0;
          String currentImage = tileImages[index % tileImages.length];

          Widget iconWidget = Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: goldColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: goldColor.withValues(alpha: 0.3)),
            ),
            child: const Icon(Icons.show_chart_rounded, color: goldColor, size: 24),
          );

          Widget contentWidget = Expanded(
            child: Column(
              crossAxisAlignment: isEven ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Text(data['label']!,
                    style: const TextStyle(
                        color: goldColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                        shadows: [Shadow(color: Colors.black, blurRadius: 4)])),
                const SizedBox(height: 4),
                Text(data['value']!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        height: 1.1,
                        shadows: [Shadow(color: Colors.black, blurRadius: 8)])),
                Text('MATCHES',
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1)),
                const SizedBox(height: 8),
                Text(data['desc']!,
                    textAlign: isEven ? TextAlign.left : TextAlign.right,
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        shadows: [Shadow(color: Colors.black, blurRadius: 4)])),
              ],
            ),
          );

          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 4))
              ],
            ),
            child: Row(
              children: isEven 
                ? [iconWidget, const SizedBox(width: 20), contentWidget]
                : [contentWidget, const SizedBox(width: 20), iconWidget],
            ),
          );
        },
      ),
    );
  }
}
