import 'package:flutter/material.dart';
import 'verify_organizers_page.dart';
import 'manage_clubs_page.dart';
import 'system_analytics_page.dart';
import 'coach_recruitment_hub.dart';
import 'premium_features_page.dart';
import 'audit_logs_page.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class SuperAdminHome extends StatelessWidget {
  const SuperAdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      endDrawer: _buildDrawer(context),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 250,
                    pinned: false,
                    toolbarHeight: 0,
                    automaticallyImplyLeading: false,
                    actions: const [SizedBox.shrink()],
                    backgroundColor: darkBg,
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset('assets/images/login_background.jpeg', fit: BoxFit.cover, opacity: const AlwaysStoppedAnimation(0.4)),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, darkBg.withOpacity(0.8), darkBg],
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: goldColor, width: 2),
                                ),
                                child: const CircleAvatar(
                                  radius: 45,
                                  backgroundColor: Color(0xFF1A1A1A),
                                  child: Icon(Icons.admin_panel_settings, size: 50, color: goldColor),
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Text('STATIXA COMMAND CENTER',
                                style: TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 3)),
                              const SizedBox(height: 5),
                              const Text('SUPER ADMIN',
                                style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 1)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(25),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const Text('SYSTEM MANAGEMENT', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                        const SizedBox(height: 20),
                        _buildAdminActionCard(
                          context,
                          Icons.how_to_reg_rounded, 
                          'VERIFY ORGANIZERS/HOSTS',
                          '3 Pending Applications', 
                          Colors.blueAccent,
                          () => Navigator.push(context, MaterialPageRoute(builder: (context) => const VerifyOrganizersPage()))
                        ),
                        const SizedBox(height: 15),
                        _buildAdminActionCard(
                          context,
                          Icons.contact_page_outlined, 
                          'COACH RECRUITMENT HUB', 
                          'Access coach CVs & recruitment data', 
                          Colors.purpleAccent,
                          () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CoachRecruitmentHub()))
                        ),
                        const SizedBox(height: 15),
                        _buildAdminActionCard(
                          context,
                          Icons.star_outline_rounded, 
                          'PREMIUM ACADEMY FEATURES', 
                          'Manage owner subscriptions & billing', 
                          goldColor,
                          () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PremiumFeaturesPage()))
                        ),
                        const SizedBox(height: 15),
                        _buildAdminActionCard(
                          context,
                          Icons.business_rounded, 
                          'MANAGE CLUBS & LOGOS', 
                          'Edit Names & Visual Identity', 
                          goldColor,
                          () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageClubsPage()))
                        ),
                        const SizedBox(height: 15),
                        _buildAdminActionCard(
                          context,
                          Icons.analytics_outlined, 
                          'SYSTEM ANALYTICS', 
                          'Global performance metrics', 
                          Colors.greenAccent,
                          () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SystemAnalyticsPage()))
                        ),
                        const SizedBox(height: 15),
                        _buildAdminActionCard(
                          context,
                          Icons.security_rounded, 
                          'AUDIT LOGS', 
                          'Monitor administrative actions', 
                          Colors.redAccent,
                          () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AuditLogsPage()))
                        ),
                        const SizedBox(height: 60),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        children: [
          Image.asset('assets/logo.png', height: 35, fit: BoxFit.contain),
          const SizedBox(width: 10),
          const Text('STATIXA ADMIN',
              style: TextStyle(
                  color: Color(0xFFC0C0C0),
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5)),
          const Spacer(),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: goldColor),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: darkBg,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
                    decoration: const BoxDecoration(color: Color(0xFF0D0D0D)),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xFF1A1A1A),
                          child: Icon(Icons.admin_panel_settings, size: 35, color: goldColor),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('SUPER ADMIN',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              Text('System Root | STATIXA',
                                  style: TextStyle(
                                      color: goldColor.withValues(alpha: 0.7),
                                      fontSize: 11)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
                    child: Text('SYSTEM CONTROL',
                        style: TextStyle(
                            color: Colors.white24, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
                  ),
                  _buildDrawerItem(Icons.security_outlined, 'Access Controls', () {}),
                  _buildDrawerItem(Icons.storage_outlined, 'Database Backup', () {}),
                  _buildDrawerItem(Icons.api_outlined, 'API Integrations', () {}),
                  _buildDrawerItem(Icons.settings_suggest_outlined, 'System Settings', () {}),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.white10, height: 1),
          _buildDrawerItem(Icons.logout_rounded, 'Logout', () {
            Navigator.pushReplacementNamed(context, '/login');
          }),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap,
      {bool isRed = false, bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListTile(
        dense: true,
        visualDensity: const VisualDensity(vertical: -2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Icon(icon,
            color: isSelected
                ? goldColor
                : (isRed ? Colors.redAccent.withValues(alpha: 0.7) : Colors.white38),
            size: 20),
        title: Text(title,
            style: TextStyle(
                color: isSelected
                    ? goldColor
                    : (isRed ? Colors.redAccent : Colors.white70),
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500)),
        onTap: onTap,
        selected: isSelected,
        selectedTileColor: goldColor.withValues(alpha: 0.05),
      ),
    );
  }

  Widget _buildAdminActionCard(BuildContext context, IconData icon, String title, String sub, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.03)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(sub, style: const TextStyle(color: Colors.white38, fontSize: 11)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white10, size: 14),
          ],
        ),
      ),
    );
  }
}
