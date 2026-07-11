import 'package:flutter/material.dart';
import 'trialist_database_page.dart' hide surfaceColor;
import 'manager_approvals_page.dart';
import 'manager_contracts_page.dart';
import 'manager_create_match_page.dart';
import 'manager_notifications_page.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class ManagerDashboard extends StatelessWidget {
  const ManagerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: _buildManagerHeroCard(),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const Text('SYSTEM OVERVIEW',
                  style: TextStyle(
                      color: goldColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2)),
              const SizedBox(height: 15),
              _buildClubStatusCard(),
              const SizedBox(height: 15),
              _buildCreateMatchSection(context),
              const SizedBox(height: 35),
              _buildSectionHeader('MANAGEMENT TASKS'),
              const SizedBox(height: 15),
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                children: [
                  _buildModernStatCard('08', 'APPROVALS', Icons.rule_rounded, [const Color(0xFF007CFE), const Color(0xFF004A99)], () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ManagerApprovalsPage()));
                  }),
                  _buildModernStatCard('03', 'CONTRACTS', Icons.description_rounded, [const Color(0xFFFFB75E), const Color(0xFFED8F03)], () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ManagerContractsPage()));
                  }),
                  _buildModernStatCard('LIVE', 'TRIALISTS', Icons.public_rounded, [const Color(0xFF38EF7D), const Color(0xFF11998E)], () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TrialistDatabasePage()));
                  }),
                ],
              ),
              const SizedBox(height: 35),
              _buildSectionHeader('PERFORMANCE OVERVIEW'),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: goldColor.withValues(alpha: 0.1)),
                ),
                child: Row(
                  children: [
                    _buildMiniStat('150', 'MANAGED', Icons.assignment_ind_rounded, Colors.blueAccent),
                    _buildMiniStat('12', 'TROPHIES', Icons.emoji_events_rounded, goldColor),
                    _buildMiniStat('85%', 'WIN RATE', Icons.trending_up_rounded, Colors.greenAccent),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionHeader('RECENT NOTIFICATIONS'),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ManagerNotificationsPage()));
                    },
                    child: const Text('VIEW ALL',
                        style: TextStyle(
                            color: goldColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1)),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              _buildNotificationItem('New equipment request from Coach', 'Logistics', 'Today', '10:45 AM', [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)]),
              _buildNotificationItem('Monthly budget report generated', 'Finance', 'Yesterday', '04:00 PM', [const Color(0xFFEE0979), const Color(0xFFF12711)]),
              _buildNotificationItem('Sponsorship deal under review', 'Contracts', 'Yesterday', '11:20 AM', [const Color(0xFF007CFE), const Color(0xFF004A99)]),
              _buildNotificationItem('New trialist registration received', 'Recruitment', '2 days ago', '09:00 AM', [const Color(0xFF38EF7D), const Color(0xFF11998E)]),
              const SizedBox(height: 30),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildManagerHeroCard() {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A00E0).withValues(alpha: 0.3),
            blurRadius: 40,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(Icons.manage_accounts_rounded, size: 200, color: Colors.white.withValues(alpha: 0.05)),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome back,',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        'DORIVAL JÚNIOR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'CLUB OPERATIONS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 3),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/manager.png'),
                      fit: BoxFit.cover,
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

  Widget _buildClubStatusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F2027), Color(0xFF203A43)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('CLUB OPERATIONAL OVERVIEW',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('ACTIVE',
                    style: TextStyle(
                        color: Colors.greenAccent, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBoxyStat('12', 'TEAMS', Icons.groups_rounded, [const Color(0xFF007CFE), const Color(0xFF004A99)]),
              _buildBoxyStat('150', 'PLAYERS', Icons.directions_run_rounded, [const Color(0xFF38EF7D), const Color(0xFF11998E)]),
              _buildBoxyStat('05', 'VENUES', Icons.location_on_rounded, [const Color(0xFFEE0979), const Color(0xFFF12711)]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCreateMatchSection(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ManagerCreateMatchPage())),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: goldColor.withValues(alpha: 0.3)),
          gradient: const LinearGradient(
            colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.sports_soccer_rounded, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 20),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CREATE NEW MATCH', 
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1)),
                  SizedBox(height: 4),
                  Text('Schedule custom games & manage squads', 
                    style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildBoxyStat(String val, String label, IconData icon, List<Color> colors) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: colors),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
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

  Widget _buildModernStatCard(String val, String label, IconData icon, List<Color> colors, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: colors.first.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.2), shape: BoxShape.circle),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(height: 12),
            Text(label, 
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 8, fontWeight: FontWeight.bold, letterSpacing: 1)),
            const SizedBox(height: 8),
            Text(val, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(String title, String category, String day, String time, List<Color> colors) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: colors.first.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                Text(category, style: const TextStyle(color: Colors.white70, fontSize: 11)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(day, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              Text(time, style: const TextStyle(color: Colors.white60, fontSize: 9)),
            ],
          ),
        ],
      ),
    );
  }
}
