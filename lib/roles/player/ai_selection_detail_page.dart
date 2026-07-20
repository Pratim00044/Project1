import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);

class AiSelectionDetailPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String teamName;
  final List<Color> accentColors;

  const AiSelectionDetailPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.teamName,
    required this.accentColors,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w900,
                letterSpacing: 2)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 30),
            _buildPitchLayout(),
            const SizedBox(height: 40),
            _buildSelectionInsights(),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [accentColors[0].withValues(alpha: 0.2), Colors.transparent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: accentColors[0].withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: accentColors[0].withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.auto_awesome_rounded, color: goldColor, size: 12),
                const SizedBox(width: 8),
                Text('AI ANALYZED',
                    style: TextStyle(
                        color: goldColor,
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(teamName,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildPitchLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('TACTICAL LINEUP',
            style: TextStyle(
                color: Colors.white24,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 2)),
        const SizedBox(height: 20),
        Container(
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/ground.png',
                    fit: BoxFit.cover,
                    opacity: const AlwaysStoppedAnimation(0.6),
                  ),
                ),
                _buildPlayerOnPitch(0.5, 0.15, 'L. Messi', '9.8'),
                _buildPlayerOnPitch(0.2, 0.4, 'K. Mbappe', '9.2'),
                _buildPlayerOnPitch(0.8, 0.4, 'Neymar Jr', '8.9'),
                _buildPlayerOnPitch(0.5, 0.65, 'K. De Bruyne', '9.5'),
                _buildPlayerOnPitch(0.25, 0.85, 'V. van Dijk', '8.7'),
                _buildPlayerOnPitch(0.75, 0.85, 'R. Dias', '8.8'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerOnPitch(double x, double y, String name, String rating) {
    return Align(
      alignment: FractionalOffset(x, y),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: goldColor,
              shape: BoxShape.circle,
            ),
            child: const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/sunil.png'),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Text(name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold)),
                Text(rating,
                    style: const TextStyle(
                        color: goldColor,
                        fontSize: 7,
                        fontWeight: FontWeight.w900)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionInsights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('AI SELECTION INSIGHTS',
            style: TextStyle(
                color: Colors.white24,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 2)),
        const SizedBox(height: 20),
        _buildInsightItem(
            'Attacking Dominance',
            'This squad shows a 15% increase in conversion rate compared to regional averages.',
            Icons.trending_up_rounded),
        _buildInsightItem(
            'Defensive Stability',
            'Average defensive recovery time is 3.4 seconds, the best in the league this month.',
            Icons.shield_outlined),
      ],
    );
  }

  Widget _buildInsightItem(String title, String desc, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: goldColor, size: 20),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(desc,
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 12,
                        height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
