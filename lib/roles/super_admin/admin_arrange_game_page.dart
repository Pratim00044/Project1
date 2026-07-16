import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class AdminArrangeGamePage extends StatelessWidget {
  const AdminArrangeGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        centerTitle: true,
        title: const Text('ARRANGE GAME', 
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 2)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('GAME SCHEDULER', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
            const Text('Coordinate matches between different clubs', style: TextStyle(color: Colors.white38, fontSize: 12)),
            const SizedBox(height: 25),
            _buildFixtureCard('CORE FC', 'DUBAI LIONS', 'Sat, 12 Jul', '07:00 PM', 'Zayed Sports City'),
            _buildFixtureCard('EAGLE FC', 'TURAN DUBAI', 'Sat, 12 Jul', '09:00 PM', 'Dubai Sports World'),
            _buildFixtureCard('UNITED FC', 'EMIRATES CLUB', 'Sun, 13 Jul', '06:00 PM', 'Al Barsha Pitch'),
            const SizedBox(height: 35),
            const Text('QUICK ACTIONS', 
              style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
            const SizedBox(height: 20),
            _buildActionButton(
              label: 'GENERATE FIXTURES',
              icon: Icons.auto_awesome_rounded,
              color: goldColor,
              onTap: () {},
            ),
            const SizedBox(height: 15),
            _buildActionButton(
              label: 'BROADCAST UPDATES',
              icon: Icons.campaign_rounded,
              color: surfaceColor,
              textColor: Colors.white,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({required String label, required IconData icon, required Color color, Color textColor = Colors.black, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: color == surfaceColor ? Border.all(color: Colors.white.withValues(alpha: 0.05)) : null,
          boxShadow: color == goldColor ? [
            BoxShadow(color: goldColor.withValues(alpha: 0.2), blurRadius: 15, offset: const Offset(0, 8))
          ] : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 20),
            const SizedBox(width: 12),
            Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 1)),
          ],
        ),
      ),
    );
  }

  Widget _buildFixtureCard(String t1, String t2, String date, String time, String venue) {
    const List<Color> colors = [Color(0xFF1E3C31), Color(0xFF2A1B3D)];
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 5))
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(child: Text(t1, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(10)),
                  child: const Text('VS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12)),
                ),
                Expanded(child: Text(t2, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14))),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFixtureDetail(Icons.calendar_month, date),
                _buildFixtureDetail(Icons.access_time_filled, time),
                _buildFixtureDetail(Icons.location_on, venue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFixtureDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 14),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
