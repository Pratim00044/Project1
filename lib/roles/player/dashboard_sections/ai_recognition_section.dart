import 'package:flutter/material.dart';
import '../ai_selection_detail_page.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class AiRecognitionSection extends StatelessWidget {
  const AiRecognitionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(25, 10, 20, 15),
          child: Row(
            children: [
              Icon(Icons.auto_awesome_rounded, color: goldColor, size: 16),
              SizedBox(width: 8),
              Text('AI RECOGNITION',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2)),
            ],
          ),
        ),
        
        // Horizontal Scroll for Teams of the Week/Month/Season
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            physics: const BouncingScrollPhysics(),
            children: [
              _buildRecognitionCard(
                context,
                title: 'TEAM OF THE WEEK',
                subtitle: 'Matchweek 12',
                teamName: 'CORE FC ELITE',
                icon: Icons.flash_on_rounded,
                colors: [const Color(0xFF065F46), const Color(0xFF064E3B)],
                badge: 'LIVE',
              ),
              _buildRecognitionCard(
                context,
                title: 'TEAM OF THE MONTH',
                subtitle: 'February 2026',
                teamName: 'GULF STARS XI',
                icon: Icons.calendar_month_rounded,
                colors: [const Color(0xFF3730A3), const Color(0xFF312E81)],
                badge: 'NEW',
              ),
              _buildRecognitionCard(
                context,
                title: 'TEAM OF THE SEASON',
                subtitle: '2025/26 League',
                teamName: 'STATIXA ALL-STARS',
                icon: Icons.emoji_events_rounded,
                colors: [const Color(0xFF7C2D12), const Color(0xFF451A03)],
                badge: 'LOCKED',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecognitionCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String teamName,
    required IconData icon,
    required List<Color> colors,
    required String badge,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AiSelectionDetailPage(
              title: title,
              subtitle: subtitle,
              teamName: teamName,
              accentColors: colors,
            ),
          ),
        );
      },
      child: Container(
        width: 260,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: colors[0].withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -10,
              bottom: -10,
              child: Icon(icon, size: 80, color: Colors.white.withValues(alpha: 0.1)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(badge, 
                    style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 1)),
                ),
                const Spacer(),
                Text(title, 
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                Text(teamName, 
                  style: const TextStyle(color: goldColor, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                const SizedBox(height: 4),
                Text(subtitle, 
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 10, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('VIEW SELECTION', 
                      style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 1)),
                    const SizedBox(width: 6),
                    Icon(Icons.arrow_forward_rounded, color: Colors.white.withValues(alpha: 0.8), size: 10),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
