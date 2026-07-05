import 'package:flutter/material.dart';
import 'details/managed_history.dart';
import 'details/trophy_history.dart';
import 'details/win_rate_history.dart';
import 'details/session_history.dart';
import 'details/goal_history.dart';
import 'details/clean_sheet_history.dart';
import 'details/avg_point_history.dart';

const Color goldColor = Color(0xFFD4AF37);

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('ELITE CLUB PERFORMANCE',
                            style: TextStyle(
                                color: goldColor,
                                fontSize: 10,
                                letterSpacing: 3,
                                fontWeight: FontWeight.w900)),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Text('Hi, ',
                                style: TextStyle(color: Colors.white60, fontSize: 24)),
                            const Text('James',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  _buildProfileGlow(),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildTopStatsCard(context),
                const SizedBox(height: 35),
                _buildSectionHeader('YOUR OVERVIEW'),
                const SizedBox(height: 15),
                LayoutBuilder(builder: (context, constraints) {
                  return GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 5,
                    ),
                    children: [
                      _buildModernStatCard('04', 'ACTIVE TEAMS', Icons.groups_rounded, goldColor),
                      _buildModernStatCard('JUL 02', 'NEXT MATCH', Icons.sports_soccer_rounded, Colors.blueAccent),
                      _buildModernStatCard('18:00', 'TRAINING', Icons.timer_outlined, Colors.orangeAccent),
                      _buildModernStatCard('12', 'NOTIFICATIONS', Icons.notifications_active_rounded, Colors.blueAccent),
                    ],
                  );
                }),
                const SizedBox(height: 35),
                _buildSectionHeader('MATCH SCHEDULE'),
                const SizedBox(height: 15),
                _buildUpcomingMatchItem('Mohun Bagan vs Kerala Blasters', 'ISL League', '02 JUL', '19:30'),
                _buildUpcomingMatchItem('Mohun Bagan vs East Bengal', 'Derby Friendly', '08 JUL', '18:00'),
                const SizedBox(height: 30),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileGlow() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: goldColor.withValues(alpha: 0.2), blurRadius: 20, spreadRadius: 2)],
      ),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: const Color(0xFF1A1A1A),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: const Icon(Icons.person, color: goldColor),
        ),
      ),
    );
  }

  Widget _buildTopStatsCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: goldColor.withValues(alpha: 0.1)),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A1A), Color(0xFF080808)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('COACHING SESSION PERFORMANCE',
                  style: TextStyle(
                      color: goldColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5)),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBoxyStat('15', 'MATCHES', Icons.sports_rounded, Colors.blueAccent),
              _buildBoxyStat('03', 'TROPHIES', Icons.emoji_events_rounded, goldColor),
              _buildBoxyStat('10', 'WINS', Icons.trending_up_rounded, Colors.greenAccent),
              _buildBoxyStat('02', 'LOST', Icons.trending_down_rounded, Colors.redAccent),
            ],
          ),
          const SizedBox(height: 25),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StatDetailsPage(playerName: 'James', isCoach: true),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: goldColor.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: goldColor.withValues(alpha: 0.1)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Detailed coaching stats',
                      style: TextStyle(
                          color: goldColor, fontSize: 12, fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  Icon(Icons.chevron_right, color: goldColor, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBoxyStat(String val, String label, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.1)),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 10),
        Text(val,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label,
            style: const TextStyle(
                color: Colors.white38, fontSize: 8, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 2)),
        const Icon(Icons.arrow_forward, color: Color(0xFFD4AF37), size: 16),
      ],
    );
  }

  Widget _buildModernStatCard(String val, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
          const Spacer(),
          Text(val, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildUpcomingMatchItem(String title, String type, String date, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: goldColor.withValues(alpha: 0.1))),
            child: Text(date,
                style: const TextStyle(
                    color: goldColor, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                Text(type, style: const TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          Text(time,
              style: const TextStyle(
                  color: goldColor, fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class StatDetailsPage extends StatelessWidget {
  final String playerName;
  final bool isCoach;
  const StatDetailsPage({super.key, required this.playerName, this.isCoach = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        title: Text(isCoach ? 'COACHING STATISTICS' : 'PLAYER STATISTICS',
            style: const TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0D0D0D),
        foregroundColor: goldColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('NAME: $playerName',
                style: const TextStyle(
                    color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
            Text(isCoach ? 'Head Coach | CORE FC' : 'Forward | #10 | CORE FC',
                style: const TextStyle(color: goldColor, fontSize: 14, fontWeight: FontWeight.w500)),
            const SizedBox(height: 40),
            LayoutBuilder(builder: (context, constraints) {
              return GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: constraints.maxWidth < 400 ? 1.0 : 1.2,
                ),
                children: isCoach 
                  ? [
                      _buildStatBox(context, 'Managed', '150', Icons.assignment_ind_rounded, Colors.blueAccent, const ManagedHistoryPage()),
                      _buildStatBox(context, 'Trophies', '12', Icons.emoji_events_rounded, goldColor, const TrophyHistoryPage()),
                      _buildStatBox(context, 'Win Rate', '85%', Icons.trending_up_rounded, Colors.greenAccent, const WinRateHistoryPage()),
                      _buildStatBox(context, 'Goals Team', '420', Icons.sports_soccer_rounded, Colors.orangeAccent, const GoalHistoryPage()),
                      _buildStatBox(context, 'Clean Sheets', '45', Icons.shield_rounded, Colors.tealAccent, const CleanSheetHistoryPage()),
                      _buildStatBox(context, 'Tactical', 'A+', Icons.analytics_outlined, Colors.purpleAccent, const AvgPointHistoryPage()),
                      _buildStatBox(context, 'Sessions', '850', Icons.fitness_center_rounded, Colors.redAccent, const SessionHistoryPage()),
                    ]
                  : [
                      _buildStatBox(context, 'Matches', '48', Icons.sports_soccer_rounded, Colors.blueAccent, null),
                      _buildStatBox(context, 'Goals', '24', Icons.ads_click_rounded, goldColor, null),
                      _buildStatBox(context, 'Assists', '12', Icons.assistant_navigation, Colors.greenAccent, null),
                      _buildStatBox(context, 'Minutes', '4,200', Icons.timer_rounded, Colors.orangeAccent, null),
                      _buildStatBox(context, 'Accuracy', '92%', Icons.gps_fixed_rounded, Colors.tealAccent, null),
                    ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBox(BuildContext context, String label, String value, IconData icon, Color color, Widget? targetPage) {
    return GestureDetector(
      onTap: () {
        if (targetPage != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => targetPage));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withValues(alpha: 0.1)),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A1A1A),
              Color(0xFF0D0D0D),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(value,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 4),
                Text(label.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
