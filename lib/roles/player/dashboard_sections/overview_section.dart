import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class OverviewSection extends StatelessWidget {
  const OverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildNotificationBanner(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
          child: Row(
            children: [
              _buildSmallDataBox(Icons.history, '24 Years', 'Age', 'assets/images/Age.png'),
              const SizedBox(width: 12),
              _buildSmallDataBox(Icons.sports_soccer, 'Center Forward', 'Position', 'assets/images/Forward.png'),
              const SizedBox(width: 12),
              _buildSmallDataBox(Icons.directions_run, 'Right Foot', 'Leg', 'assets/images/Attack.png'),
            ],
          ),
        ),
        const SizedBox(height: 25),
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
          child: _buildPremiumMatchCard(),
        ),
        const SizedBox(height: 35),
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
              _buildSharpDataBox(Icons.timer_outlined, '18:00 PM', 'FEB 05', 'assets/images/league_green.png'),
              const SizedBox(width: 12),
              _buildSharpDataBox(Icons.fitness_center_rounded, 'Tactical', 'Type', 'assets/images/league_blue.png'),
              const SizedBox(width: 12),
              _buildSharpDataBox(Icons.location_on_outlined, 'Pitch 4', 'Location', 'assets/images/league_red.png'),
            ],
          ),
        ),
        const SizedBox(height: 35),
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
          child: _buildCurrentStat2026Card(),
        ),
        const SizedBox(height: 35),
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
              _buildSharpDataBox(Icons.emoji_events_rounded, '08', 'MVP TROPHIES', 'assets/images/match.png'),
              const SizedBox(width: 12),
              _buildSharpDataBox(Icons.stars_rounded, '2026', 'Season', 'assets/images/match.png'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: goldColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: goldColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.notifications_active_rounded, color: goldColor, size: 20),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('NEW MATCH CREATED', style: TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                Text('Coach James has scheduled a new league match.', style: TextStyle(color: Colors.white70, fontSize: 10)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, color: goldColor, size: 12),
        ],
      ),
    );
  }

  Widget _buildCurrentStat2026Card() {
    return Row(
      children: [
        _buildSharpDataBox(Icons.event_available, '48', 'MATCHES', 'assets/images/league_blue.png'),
        const SizedBox(width: 12),
        _buildSharpDataBox(Icons.sports_soccer, '24', 'GOALS', 'assets/images/league_gold.png'),
        const SizedBox(width: 12),
        _buildSharpDataBox(Icons.assistant_navigation, '12', 'ASSISTS', 'assets/images/league_green.png'),
      ],
    );
  }

  Widget _buildSmallDataBox(IconData icon, String val, String sub, String bgImage) {
    return Expanded(
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          image: DecorationImage(
            image: AssetImage(bgImage),
            fit: BoxFit.cover,
            opacity: 0.3,
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: Colors.white24, size: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(val,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ),
                Text(sub,
                    style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 8,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSharpDataBox(IconData icon, String val, String sub, String bgImage) {
    return Expanded(
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          image: DecorationImage(
            image: AssetImage(bgImage),
            fit: BoxFit.cover,
            opacity: 0.4,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: Colors.white24, size: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(val,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold)),
                Text(sub,
                    style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 10,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumMatchCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
        image: const DecorationImage(
          image: AssetImage('assets/images/match.png'),
          fit: BoxFit.cover,
          opacity: 0.4,
        ),
      ),
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
                  color: Colors.white.withValues(alpha: 0.05),
                  margin: const EdgeInsets.symmetric(horizontal: 20)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('FEB 02',
                      style: TextStyle(
                          color: goldColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w900)),
                  const SizedBox(height: 4),
                  Text('22:00 PM',
                      style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.4),
                          fontSize: 11,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.white10, height: 1),
          const SizedBox(height: 15),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, color: Colors.white38, size: 14),
              const SizedBox(width: 8),
              const Text('Al Hamra Stadium, Ras Al Khaimah',
                  style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMatchTeam(String name, bool highlight) {
    return Row(
      children: [
        Icon(Icons.shield, color: highlight ? goldColor : Colors.white10, size: 18),
        const SizedBox(width: 12),
        Text(name,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600)),
      ],
    );
  }
}
