import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class SystemAnalyticsPage extends StatelessWidget {
  const SystemAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        centerTitle: true,
        title: const Text('SYSTEM ANALYTICS', style: TextStyle(color: goldColor, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
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
            const Text('PLATFORM GROWTH', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
            const SizedBox(height: 20),
            _buildStatGrid(),
            const SizedBox(height: 35),
            const Text('CLUB ACTIVITY', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
            const SizedBox(height: 15),
            _buildActivityChart(),
            const SizedBox(height: 35),
            const Text('RECENT SYSTEM EVENTS', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
            const SizedBox(height: 15),
            _buildEventLog(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: [
        _buildStatCard('28', 'CLUBS', Icons.business, Colors.blueAccent),
        _buildStatCard('1.2k', 'PLAYERS', Icons.directions_run, Colors.greenAccent),
        _buildStatCard('156', 'COACHES', Icons.sports, Colors.orangeAccent),
        _buildStatCard('450', 'MATCHES', Icons.event, goldColor),
      ],
    );
  }

  Widget _buildStatCard(String val, String label, IconData icon, Color color) {
    const List<Color> colors = [Color(0xFF1E3C31), Color(0xFF2A1B3D)];
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 10),
          Text(val, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
          Text(label, style: const TextStyle(color: Colors.white38, fontSize: 9, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildActivityChart() {
    const List<Color> colors = [Color(0xFF1E3C31), Color(0xFF2A1B3D)];
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.show_chart, color: goldColor, size: 40),
            const SizedBox(height: 10),
            const Text('Monthly Engagement Chart', style: TextStyle(color: Colors.white70, fontSize: 12)),
            Text('85% Increase this month', style: TextStyle(color: Colors.greenAccent.withValues(alpha: 0.7), fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildEventLog() {
    final events = [
      {'event': 'New Club Registered', 'time': '2 mins ago', 'desc': 'Dubai City Football Club joined the platform.'},
      {'event': 'Organiser Approved', 'time': '1 hour ago', 'desc': 'John Doe was verified as organiser for CORE FC.'},
      {'event': 'System Update', 'time': '5 hours ago', 'desc': 'New evaluation metrics deployed to all coach dashboards.'},
    ];

    const List<Color> colors = [Color(0xFF1E3C31), Color(0xFF2A1B3D)];

    return Column(
      children: events.map((e) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Row(
          children: [
            const CircleAvatar(backgroundColor: Colors.white10, radius: 4, ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(e['event']!, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                      Text(e['time']!, style: const TextStyle(color: Colors.white38, fontSize: 9)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(e['desc']!, style: const TextStyle(color: Colors.white70, fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
}
