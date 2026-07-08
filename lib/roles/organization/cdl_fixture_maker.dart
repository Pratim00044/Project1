import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class CdlFixtureMaker extends StatelessWidget {
  const CdlFixtureMaker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('CDL FIXTURE MAKER', style: TextStyle(color: goldColor, fontSize: 14, fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('UPCOMING MATCH DAYS', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildFixtureCard('Core FC', 'Dubai Lions', 'Sat, 12 Jul', '07:00 PM'),
            _buildFixtureCard('Eagle FC', 'Turan Dubai', 'Sat, 12 Jul', '09:00 PM'),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: goldColor,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text('GENERATE AUTO-FIXTURES', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFixtureCard(String t1, String t2, String date, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: surfaceColor, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(t1, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const Text('VS', style: TextStyle(color: goldColor, fontWeight: FontWeight.w900, fontSize: 12)),
              Text(t2, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          const Divider(color: Colors.white10, height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.calendar_today, color: Colors.white24, size: 14),
              const SizedBox(width: 8),
              Text(date, style: const TextStyle(color: Colors.white38, fontSize: 12)),
              const SizedBox(width: 20),
              const Icon(Icons.access_time, color: Colors.white24, size: 14),
              const SizedBox(width: 8),
              Text(time, style: const TextStyle(color: Colors.white38, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
