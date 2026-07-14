import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);

class PlayerGameDetail extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String location;
  final String type;

  const PlayerGameDetail({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    int reserved = 8;
    int total = 14;
    int spotsLeft = total - reserved;
    double progress = reserved / total;

    final List<Map<String, String>> players = [
      {'name': 'James Doe', 'pos': 'Midfielder', 'rating': '8.4', 'status': 'Going', 'image': 'assets/images/sunil.png'},
      {'name': 'Marcus Reid', 'pos': 'Forward', 'rating': '7.9', 'status': 'Going', 'image': 'assets/images/sunil.png'},
      {'name': 'Sam Khan', 'pos': 'Defender', 'rating': '8.1', 'status': 'Pending', 'image': 'assets/images/sunil.png'},
    ];

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('My Games', style: TextStyle(color: Colors.white70, fontSize: 14)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: const Color(0xFF1B2414), // Dark green tint as per image
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
                image: DecorationImage(
                  image: const AssetImage('assets/images/img1.jpeg'),
                  fit: BoxFit.cover,
                  opacity: 0.1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildPill('Open', greenAccent, Colors.black),
                      const SizedBox(width: 10),
                      _buildPill(type, goldColor.withValues(alpha: 0.2), goldColor),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.white54, size: 14),
                      const SizedBox(width: 5),
                      Text('$date • $time', style: const TextStyle(color: Colors.white54, fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.white54, size: 14),
                      const SizedBox(width: 5),
                      Text(location, style: const TextStyle(color: Colors.white54, fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),

            // Stats row
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildStatBox(reserved.toString(), 'Reserved', goldColor),
                      const SizedBox(width: 10),
                      _buildStatBox(spotsLeft.toString(), 'Spots left', greenAccent),
                      const SizedBox(width: 10),
                      _buildStatBox(total.toString(), 'Total slots', Colors.white),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: Colors.white.withValues(alpha: 0.05),
                      valueColor: const AlwaysStoppedAnimation(goldColor),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: goldColor,
                      minimumSize: const Size(double.infinity, 65),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text('Reserve my spot', 
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 18)),
                  ),
                ],
              ),
            ),

            // Players list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('PLAYERS GOING', style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                  Text('$reserved CONFIRMED', style: const TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: players.length,
              itemBuilder: (context, index) {
                final p = players[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  leading: Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: AssetImage(p['image']!), fit: BoxFit.cover),
                    ),
                  ),
                  title: Text(p['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text('${p['pos']} • ★ ${p['rating']}', style: const TextStyle(color: Colors.white38, fontSize: 12)),
                  trailing: _buildStatusPill(p['status']!),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPill(String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
      child: Text(label, style: TextStyle(color: textColor, fontSize: 10, fontWeight: FontWeight.w900)),
    );
  }

  Widget _buildStatBox(String val, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Column(
          children: [
            Text(val, style: TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.w900)),
            Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusPill(String status) {
    bool isGoing = status == 'Going';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isGoing ? greenAccent.withValues(alpha: 0.1) : goldColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(status, 
        style: TextStyle(
          color: isGoing ? greenAccent : goldColor, 
          fontSize: 10, 
          fontWeight: FontWeight.w900
        )),
    );
  }
}
