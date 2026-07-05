import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('CLUB ADMINISTRATION',
                      style: TextStyle(
                          color: Colors.white38,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2)),
                  const SizedBox(height: 5),
                  const Text('MORE TOOLS',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSectionTitle('COACHING TOOLS'),
                const SizedBox(height: 15),
                _buildResponsiveGrid([
                  _buildToolCard('Scouting', Icons.search_rounded, 'Find new talents', goldColor),
                  _buildToolCard('Tactics', Icons.dashboard_customize_rounded, 'Advanced strategies', Colors.blueAccent),
                  _buildToolCard('Training', Icons.fitness_center_rounded, 'Drills & Schedules', Colors.orangeAccent),
                  _buildToolCard('Analysis', Icons.analytics_rounded, 'Match statistics', Colors.purpleAccent),
                ]),
                const SizedBox(height: 35),
                _buildSectionTitle('CLUB MANAGEMENT'),
                const SizedBox(height: 15),
                _buildMenuOption(Icons.people_alt_rounded, 'Staff Directory', 'Manage your backroom staff'),
                _buildMenuOption(Icons.account_balance_wallet_rounded, 'Finances', 'Budget & Salary management'),
                _buildMenuOption(Icons.stadium_rounded, 'Facilities', 'Stadium & Training ground'),
                _buildMenuOption(Icons.history_edu_rounded, 'Club History', 'Honours & Heritage'),
                const SizedBox(height: 35),
                _buildSectionTitle('SUPPORT & APP'),
                const SizedBox(height: 15),
                _buildMenuOption(Icons.help_outline_rounded, 'Help Center', 'FAQs & Documentation'),
                _buildMenuOption(Icons.feedback_outlined, 'Send Feedback', 'Suggest new features'),
                _buildMenuOption(Icons.info_outline_rounded, 'About App', 'Version 2.1.0 (Elite)'),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String t) => Text(t,
      style: const TextStyle(
          color: Colors.white38,
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 2));

  Widget _buildResponsiveGrid(List<Widget> children) {
    return LayoutBuilder(builder: (context, constraints) {
      return GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.6,
        ),
        children: children,
      );
    });
  }

  Widget _buildToolCard(String title, IconData icon, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              const Icon(Icons.arrow_outward_rounded, color: Colors.white10, size: 16),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
              Text(subtitle, style: const TextStyle(color: Colors.white24, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuOption(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.02)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFFD4AF37).withValues(alpha: 0.7), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                Text(subtitle, style: const TextStyle(color: Colors.white38, fontSize: 11)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: Colors.white10),
        ],
      ),
    );
  }
}
