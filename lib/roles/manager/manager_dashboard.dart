import 'package:flutter/material.dart';
import '../coach/dashboard_page.dart';

const Color goldColor = Color(0xFFD4AF37);

class ManagerDashboard extends StatelessWidget {
  const ManagerDashboard({super.key});

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
                        const Text('CLUB OPERATIONS & MANAGEMENT',
                            style: TextStyle(
                                color: goldColor,
                                fontSize: 10,
                                letterSpacing: 3,
                                fontWeight: FontWeight.w900)),
                        const SizedBox(height: 5),
                        const Row(
                          children: [
                            Text('Hi, ',
                                style: TextStyle(color: Colors.white60, fontSize: 24)),
                            Text('Manager',
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
                _buildClubStatusCard(),
                const SizedBox(height: 35),
                _buildSectionHeader('MANAGEMENT TASKS'),
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
                      _buildModernStatCard('08', 'PENDING APPROVALS', Icons.rule_rounded, goldColor),
                      _buildModernStatCard('₹4.2L', 'BUDGET STATUS', Icons.account_balance_wallet_rounded, Colors.greenAccent),
                      _buildModernStatCard('15', 'STAFF MEMBERS', Icons.people_alt_rounded, Colors.blueAccent),
                      _buildModernStatCard('03', 'CONTRACT RENEWALS', Icons.description_rounded, Colors.orangeAccent),
                    ],
                  );
                }),
                const SizedBox(height: 35),
                _buildSectionHeader('PERFORMANCE OVERVIEW'),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StatDetailsPage(playerName: 'XYZ', isCoach: true),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: const Color(0xFF121212),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: goldColor.withValues(alpha: 0.1)),
                    ),
                    child: Row(
                      children: [
                        _buildMiniStat('150', 'MANAGED', Icons.assignment_ind_rounded, Colors.blueAccent),
                        _buildMiniStat('12', 'TROPHIES', Icons.emoji_events_rounded, goldColor),
                        _buildMiniStat('85%', 'WIN RATE', Icons.trending_up_rounded, Colors.greenAccent),
                        const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white24, size: 16),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                _buildSectionHeader('RECENT NOTIFICATIONS'),
                const SizedBox(height: 15),
                _buildNotificationItem('New equipment request from Coach', 'Logistics', 'Today', '10:45 AM'),
                _buildNotificationItem('Monthly budget report generated', 'Finance', 'Yesterday', '04:00 PM'),
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
          child: const Icon(Icons.manage_accounts_rounded, color: goldColor),
        ),
      ),
    );
  }

  Widget _buildClubStatusCard() {
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
            children: [
              const Text('CLUB OPERATIONAL OVERVIEW',
                  style: TextStyle(
                      color: goldColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: goldColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('ACTIVE',
                    style: TextStyle(
                        color: goldColor, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBoxyStat('12', 'TEAMS', Icons.groups_rounded, Colors.blueAccent),
              _buildBoxyStat('45', 'STAFF', Icons.badge_rounded, goldColor),
              _buildBoxyStat('150', 'PLAYERS', Icons.directions_run_rounded, Colors.greenAccent),
              _buildBoxyStat('05', 'VENUES', Icons.location_on_rounded, Colors.redAccent),
            ],
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

  Widget _buildMiniStat(String val, String label, IconData icon, Color color) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(val, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Colors.white38, fontSize: 8, fontWeight: FontWeight.bold)),
        ],
      ),
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

  Widget _buildNotificationItem(String title, String category, String day, String time) {
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
            child: Icon(Icons.notifications_outlined, color: goldColor, size: 16),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                Text(category, style: const TextStyle(color: Colors.white38, fontSize: 11)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(day, style: const TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.bold)),
              Text(time, style: const TextStyle(color: Colors.white24, fontSize: 9)),
            ],
          ),
        ],
      ),
    );
  }
}
