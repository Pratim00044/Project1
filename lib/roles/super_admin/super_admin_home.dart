import 'package:flutter/material.dart';
import 'verify_organizers_page.dart';
import 'manage_clubs_page.dart';
import 'system_analytics_page.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class SuperAdminHome extends StatelessWidget {
  const SuperAdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: const Color(0xFF0D0D0D),
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
                      const SizedBox(height: 40),
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
            actions: [
              IconButton(icon: const Icon(Icons.logout, color: goldColor), onPressed: () => Navigator.pushReplacementNamed(context, '/login')),
            ],
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
                  'VERIFY ORGANIZERS', 
                  '3 Pending Applications', 
                  Colors.blueAccent,
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => const VerifyOrganizersPage()))
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
                  () {}
                ),
                const SizedBox(height: 60),
              ]),
            ),
          ),
        ],
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
