import 'package:flutter/material.dart';
import '../player_home.dart';
import '../profile_details/notifications_page.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class OverviewSection extends StatelessWidget {
  const OverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildNotificationBanner(context),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
          child: Row(
            children: [
              _buildColoredSquareTile(0, Icons.cake_rounded, '24 Years', 'Age', [const Color(0xFF007CFE), const Color(0xFF004A99)]),
              const SizedBox(width: 8),
              _buildColoredSquareTile(1, Icons.sports_soccer, 'Center Forward', 'Position', [const Color(0xFF38EF7D), const Color(0xFF11998E)]),
              const SizedBox(width: 8),
              _buildColoredSquareTile(2, Icons.directions_run, 'Right Foot', 'Leg', [const Color(0xFFEE0979), const Color(0xFFF12711)]),
            ],
          ),
        ),
        const SizedBox(height: 15),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 15),
          child: Text('CURRENT STAT 2026',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: InkWell(
            onTap: () {
              final homeState = context.findAncestorStateOfType<PlayerHomeState>();
              if (homeState != null) {
                homeState.changeTab(3);
              }
            },
            borderRadius: BorderRadius.circular(24),
            child: _buildCurrentStat2026Card(),
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 15),
          child: Text('MATCH ALERT',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: InkWell(
            onTap: () {
              final homeState = context.findAncestorStateOfType<PlayerHomeState>();
              if (homeState != null) {
                homeState.changeTab(2);
              }
            },
            borderRadius: BorderRadius.circular(30),
            child: _buildPremiumMatchCard(),
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 15),
          child: Text('UPCOMING TRAINING SESSION',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              _buildColoredSquareTile(3, Icons.timer_outlined, '18:00 PM', 'FEB 05', [const Color(0xFFFFB75E), const Color(0xFFED8F03)]),
              const SizedBox(width: 8),
              _buildColoredSquareTile(4, Icons.fitness_center_rounded, 'Tactical', 'Type', [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)]),
              const SizedBox(width: 8),
              _buildColoredSquareTile(5, Icons.location_on_outlined, 'Pitch 4', 'Location', [const Color(0xFF00D2FF), const Color(0xFF3A7BD5)]),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 15),
          child: Text('TROPHY — MVP',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              _buildColoredSquareTile(6, Icons.emoji_events_rounded, '08', 'MVP TROPHIES', [const Color(0xFF38EF7D), const Color(0xFF11998E)]),
              const SizedBox(width: 8),
              _buildColoredSquareTile(7, Icons.stars_rounded, '2026', 'Season', [const Color(0xFFEE0979), const Color(0xFFF12711)]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationBanner(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsPage())),
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: goldColor.withValues(alpha: 0.1), width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: goldColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.notifications_active_rounded, color: goldColor, size: 22),
            ),
            const SizedBox(width: 15),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('NEW MATCH CREATED', 
                    style: TextStyle(color: goldColor, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1)),
                  SizedBox(height: 4),
                  Text('Coach James has scheduled a new league match.', 
                    style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: goldColor, size: 14),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStat2026Card() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: AssetImage('assets/images/img4.jpeg'),
          fit: BoxFit.cover,
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.1),
              Colors.black.withValues(alpha: 0.3),
            ],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(Icons.event_available, '48', 'MATCHES', const Color(0xFF2979FF)),
                _buildStatItem(Icons.sports_soccer, '24', 'GOALS', goldColor),
                _buildStatItem(Icons.assistant_navigation, '12', 'ASSISTS', const Color(0xFF00C853)),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: goldColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'VIEW DETAILED PERFORMANCE PROFILE',
                style: TextStyle(color: goldColor, fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 8, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildColoredSquareTile(int index, IconData icon, String val, String label, List<Color> colors) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.8,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage('assets/images/img${(index % 4) + 1}.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.1),
                  Colors.black.withValues(alpha: 0.2),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 24),
                const SizedBox(height: 6),
                FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      val,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        shadows: [Shadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 4)],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumMatchCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(30),
        image: const DecorationImage(
          image: AssetImage('assets/images/img3.jpeg'),
          fit: BoxFit.cover,
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.4),
              Colors.black.withValues(alpha: 0.6),
            ],
          ),
        ),
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _buildMatchTeam('CORE FC', true),
                      const SizedBox(height: 16),
                      _buildMatchTeam('DUBAI CITY FC', false),
                    ],
                  ),
                ),
                Container(
                    height: 40,
                    width: 1,
                    color: Colors.white24,
                    margin: const EdgeInsets.symmetric(horizontal: 20)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('FEB 02',
                        style: TextStyle(
                            color: goldColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            shadows: [Shadow(color: Colors.black, blurRadius: 8)])),
                    const SizedBox(height: 4),
                    Text('22:00 PM',
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            shadows: [Shadow(color: Colors.black, blurRadius: 4)])),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Divider(color: Colors.white.withValues(alpha: 0.1), height: 1),
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, color: goldColor, size: 14),
                const SizedBox(width: 8),
                Expanded(
                  child: Text('Al Hamra Stadium, Ras Al Khaimah',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9), 
                        fontSize: 11, 
                        fontWeight: FontWeight.w500,
                        shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchTeam(String name, bool highlight) {
    return Row(
      children: [
        Icon(Icons.shield, 
          color: highlight ? goldColor : Colors.white24, 
          size: 18,
          shadows: [const Shadow(color: Colors.black, blurRadius: 8)],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  shadows: [Shadow(color: Colors.black, blurRadius: 8)])),
        ),
      ],
    );
  }
}
