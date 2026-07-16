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
        _buildNotificationsSection(context),
        const Padding(
          padding: EdgeInsets.fromLTRB(25, 10, 20, 15),
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
        const SizedBox(height: 25),
        _buildLatestAchievementCard(context),
        const Padding(
          padding: EdgeInsets.fromLTRB(25, 10, 20, 15),
          child: Text('OVERALL PERFORMANCE',
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
        const SizedBox(height: 50),
      ],
    );
  }

  Widget _buildNotificationsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 20, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('NEW ALERTS',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2)),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsPage())),
                child: const Text('VIEW ALL', 
                  style: TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
              ),
            ],
          ),
        ),
        // UPCOMING SESSION
        _buildNotificationItem(
          icon: Icons.fitness_center_rounded,
          color: const Color(0xFF2E5B4F),
          title: 'UPCOMING SESSION',
          subtitle: 'Tactical Training at Pitch 4 • FEB 05',
          time: '2h ago',
        ),
        // MVP ALERT
        _buildNotificationItem(
          icon: Icons.emoji_events_rounded,
          color: const Color(0xFF1E3A8A),
          title: 'MVP AWARDED!',
          subtitle: 'Congratulations! You received MVP for the last match.',
          time: '1d ago',
        ),
      ],
    );
  }

  Widget _buildNotificationItem({required IconData icon, required Color color, required String title, required String subtitle, required String time}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                const SizedBox(height: 4),
                Text(subtitle, 
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(time, style: const TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildLatestAchievementCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D0D),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Stack(
        children: [
          // Subtle background texture/sparkle feel
          Positioned.fill(
            child: Opacity(
              opacity: 0.03,
              child: Image.asset('assets/images/img4.jpeg', fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('LATEST ACHIEVEMENT', 
                  style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
                const SizedBox(height: 25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Trophy Section with Glow and Wreath-like feel
                    Expanded(
                      flex: 4,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: goldColor.withValues(alpha: 0.15),
                                  blurRadius: 40,
                                  spreadRadius: 5,
                                )
                              ],
                            ),
                          ),
                          const Icon(Icons.emoji_events_rounded, color: goldColor, size: 85),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    // Achievement Details Section
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.star_rounded, color: goldColor, size: 20),
                              SizedBox(width: 6),
                              Text('CONGRATULATIONS!', 
                                style: TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text('You have received the', 
                            style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 2),
                          const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text('MVP AWARD', 
                              style: TextStyle(color: goldColor, fontSize: 34, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                          ),
                          const Text('for your last match.', 
                            style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(color: Colors.white10, height: 1),
                const SizedBox(height: 15),
                const Row(
                  children: [
                    Icon(Icons.stars_rounded, color: goldColor, size: 16),
                    SizedBox(width: 10),
                    Text('Most Valuable Player', 
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 25),
                // Premium Styled Action Button
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: goldColor.withValues(alpha: 0.6), width: 1.5),
                    ),
                    child: const Center(
                      child: Text('VIEW MATCH DETAILS', 
                        style: TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStat2026Card() {
    final List<Color> cardGradient = [const Color(0xFF1E3A8A), const Color(0xFF312E81)];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: cardGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: cardGradient[0].withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 6))],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(child: _buildStatItem(Icons.event_available, '48', 'MATCHES', Colors.white)),
              Expanded(child: _buildStatItem(Icons.sports_soccer, '24', 'GOALS', Colors.white)),
              Expanded(child: _buildStatItem(Icons.assistant_navigation, '12', 'ASSISTS', Colors.white)),
              Expanded(child: _buildStatItem(Icons.emoji_events_rounded, '08', 'MVP', Colors.white)),
              Expanded(child: _buildStatItem(Icons.front_hand_rounded, '12', 'CLEAN SHEETS', Colors.white)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'VIEW DETAILED PERFORMANCE PROFILE',
              style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, 
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 8, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildPremiumMatchCard() {
    final List<Color> cardGradient = [const Color(0xFF2E5B4F), const Color(0xFF3B2A50)];
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: cardGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: cardGradient[0].withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 6))],
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
                  color: Colors.white30,
                  margin: const EdgeInsets.symmetric(horizontal: 20)),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('FEB 02',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w900)),
                  SizedBox(height: 4),
                  Text('22:00 PM',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(color: Colors.white.withValues(alpha: 0.2), height: 1),
          const SizedBox(height: 15),
          const Row(
            children: [
              Icon(Icons.location_on_outlined, color: Colors.white, size: 14),
              SizedBox(width: 8),
              Expanded(
                child: Text('Al Hamra Stadium, Ras Al Khaimah',
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 11, 
                      fontWeight: FontWeight.w500,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMatchTeam(String name, bool highlight) {
    return Row(
      children: [
        const Icon(Icons.shield, 
          color: Colors.white, 
          size: 18,
          shadows: [Shadow(color: Colors.black26, blurRadius: 8)],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  shadows: [Shadow(color: Colors.black26, blurRadius: 8)])),
        ),
      ],
    );
  }
}
