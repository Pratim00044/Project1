import 'package:flutter/material.dart';
import 'organiser_attendance_view.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class CdlFixtureMaker extends StatelessWidget {
  const CdlFixtureMaker({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('GENERATED SCHEDULE', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
          const Text('Manage and fix upcoming league matches', style: TextStyle(color: Colors.white38, fontSize: 12)),
          const SizedBox(height: 25),
          _buildFixtureCard(context, 'Core FC', 'Dubai Lions', 'Sat, 12 Jul', '07:00 PM', 'Zayed Sports City', [const Color(0xFF1E3A8A), const Color(0xFF312E81)]),
          _buildFixtureCard(context, 'Eagle FC', 'Turan Dubai', 'Sat, 12 Jul', '09:00 PM', 'Dubai Sports World', [const Color(0xFF2E5B4F), const Color(0xFF3B2A50)]),
          _buildFixtureCard(context, 'United FC', 'Emirates Club', 'Sun, 13 Jul', '06:00 PM', 'Al Barsha Pitch', [const Color(0xFF831843), const Color(0xFF701A75)]),
          const SizedBox(height: 40),
          _buildActionButton(
            label: 'AUTO FIX',
            icon: Icons.auto_awesome_rounded,
            color: goldColor,
            onTap: () {},
          ),
        ],
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
          borderRadius: BorderRadius.circular(15),
          border: color == Colors.white10 ? Border.all(color: Colors.white.withValues(alpha: 0.1)) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 20),
            const SizedBox(width: 10),
            Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 0.5)),
          ],
        ),
      ),
    );
  }

  Widget _buildFixtureCard(BuildContext context, String t1, String t2, String date, String time, String venue, List<Color> colors) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => OrganiserAttendanceView(
          title: '$t1 vs $t2',
          date: date,
          time: time,
          location: venue,
        )));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(color: colors[0].withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 5)),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(child: Text(t1.toUpperCase(), textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14))),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                    child: const Text('VS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12)),
                  ),
                  Expanded(child: Text(t2.toUpperCase(), textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14))),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
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
