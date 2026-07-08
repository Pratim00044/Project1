import 'package:flutter/material.dart';
import 'details/managed_history.dart';
import 'details/trophy_history.dart';
import 'details/win_rate_history.dart';
import 'details/session_history.dart';
import 'details/goal_history.dart';
import 'details/clean_sheet_history.dart';
import 'details/avg_point_history.dart';
import 'create_training_page.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
          
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('PICK A DATE', style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
                  const SizedBox(height: 15),
                  _buildDatePicker(),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSectionHeader('ACADEMY SESSIONS'),
                const SizedBox(height: 15),
                _buildSessionList(),
                const SizedBox(height: 35),
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
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateTrainingPage()));
                    },
                    icon: const Icon(Icons.add, color: Colors.black),
                    label: const Text('SCHEDULE BESPOKE SESSION', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: goldColor,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                _buildSectionHeader('MATCH SCHEDULE'),
                const SizedBox(height: 15),
                _buildUpcomingMatchItem('Mohun Bagan vs Kerala Blasters', 'ISL League', '02 JUL', '19:30'),
                _buildUpcomingMatchItem('Mohun Bagan vs East Bengal', 'Derby Friendly', '08 JUL', '18:00'),
                const SizedBox(height: 35),
                _buildSectionHeader('ACADEMY RANKINGS'),
                const SizedBox(height: 15),
                _buildRankingSection(),
                const SizedBox(height: 35),
                _buildSectionHeader('ACADEMY DIRECTORY'),
                const SizedBox(height: 15),
                _buildAcademyList(),
                const SizedBox(height: 30),
              ]),
            ),
          ),
        ],
      );
  }

  Widget _buildDatePicker() {
    return SizedBox(
      height: 90,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 14,
              itemBuilder: (context, index) {
                final date = DateTime.now().add(Duration(days: index - 1));
                final isSelected = date.day == _selectedDate.day && date.month == _selectedDate.month;
                final isToday = date.day == DateTime.now().day && date.month == DateTime.now().month;

                return GestureDetector(
                  onTap: () => setState(() => _selectedDate = date),
                  child: Container(
                    width: 75,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? greenAccent.withValues(alpha: 0.1) : surfaceColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: isSelected ? greenAccent : Colors.white.withValues(alpha: 0.05), width: 1.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(isToday ? 'TODAY' : ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'][date.weekday - 1], 
                            style: TextStyle(color: isSelected ? greenAccent : Colors.white38, fontSize: 9, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 5),
                        Text(date.day.toString(), style: TextStyle(color: isSelected ? Colors.white : Colors.white70, fontSize: 22, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 2),
                        Text(isSelected ? '•' : '3', style: TextStyle(color: isSelected ? greenAccent : Colors.white24, fontSize: 9, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionList() {
    final sessions = [
      {'time': '6-7pm', 'age': 'Under 8s', 'location': 'Town Square - Una Pitch', 'players': '12'},
      {'time': '7-8pm', 'age': 'Under 10s', 'location': 'Town Square - Una Pitch', 'players': '15'},
    ];

    return Column(
      children: sessions.map((s) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.02)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: greenAccent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
              child: Text(s['time']!, style: const TextStyle(color: greenAccent, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s['age']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: Colors.white24, size: 12),
                      const SizedBox(width: 4),
                      Text(s['location']!, style: const TextStyle(color: Colors.white38, fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const Icon(Icons.people_outline, color: goldColor, size: 16),
                Text(s['players']!, style: const TextStyle(color: goldColor, fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildRankingSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withValues(alpha: 0.02)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('ACADEMY RANKINGS', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _buildAwardTypePill('WEEK'),
                      const SizedBox(width: 8),
                      _buildAwardTypePill('MONTH'),
                      const SizedBox(width: 8),
                      _buildAwardTypePill('TERM', isActive: true),
                      const SizedBox(width: 8),
                      _buildAwardTypePill('SEASON'),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: goldColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: const Text('2024', style: TextStyle(color: goldColor, fontSize: 9, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 25),
          _buildRankingItem('TOP GK', 'Gurpreet Singh', 'Under 8s', '98% Save Rate', Colors.greenAccent),
          _buildRankingItem('TOP DEFENDER', 'Sandesh Jhingan', 'Under 10s', '45 Tackles', Colors.blueAccent),
          _buildRankingItem('TOP MIDFIELDER', 'Sahal Abdul', 'Under 8s', '12 Assists', Colors.purpleAccent),
          _buildRankingItem('TOP STRIKER', 'Sunil Chhetri', 'Under 8s', '24 Goals', Colors.orangeAccent),
        ],
      ),
    );
  }

  Widget _buildAwardTypePill(String label, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isActive ? goldColor : Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: TextStyle(color: isActive ? Colors.black : Colors.white38, fontSize: 7, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildRankingItem(String category, String name, String team, String stat, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            width: 4, height: 35,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1)),
                Text(name, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(team, style: const TextStyle(color: Colors.white38, fontSize: 10)),
              Text(stat, style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAcademyList() {
    final academies = [
      {'name': 'Premier Academy', 'location': 'Town Square', 'rating': '4.8'},
      {'name': 'SOFA', 'location': 'Dubai Sports City', 'rating': '4.9'},
      {'name': 'Football Clinic', 'location': 'Jumeirah', 'rating': '4.7'},
    ];

    return Column(
      children: academies.map((a) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              height: 40, width: 40,
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.school_outlined, color: goldColor, size: 20),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(a['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text(a['location']!, style: const TextStyle(color: Colors.white38, fontSize: 11)),
                ],
              ),
            ),
            Row(
              children: [
                const Icon(Icons.star_rounded, color: goldColor, size: 14),
                const SizedBox(width: 4),
                Text(a['rating']!, style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      )).toList(),
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
        image: const DecorationImage(
          image: AssetImage('assets/images/match.png'),
          fit: BoxFit.cover,
          opacity: 0.15,
        ),
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
            Text(isCoach ? 'Head Coach | UNDER 8s' : 'Forward | #10 | UNDER 8s',
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
