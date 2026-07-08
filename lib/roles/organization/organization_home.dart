import 'package:flutter/material.dart';
import 'pending_approval_page.dart';
import 'player_profiles_management.dart';
import 'league_tables_page.dart';
import 'cdl_teams_management.dart';
import 'cdl_fixture_maker.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);
const Color cardLightColor = Color(0xFFC0C0C0);

class OrganizationHome extends StatefulWidget {
  const OrganizationHome({super.key});

  @override
  State<OrganizationHome> createState() => _OrganizationHomeState();
}

class _OrganizationHomeState extends State<OrganizationHome> {
  bool isApproved = true;

  @override
  Widget build(BuildContext context) {
    if (!isApproved) {
      return const PendingApprovalPage();
    }
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Core FC Theme .jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        endDrawer: _buildDrawer(context),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: _buildHeroCard(),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverGrid.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.9,
                        children: [
                          _buildOrgCard(context, Icons.assignment_ind_rounded, 'CDL PLAYER PROFILES', 'Create & Manage Players', () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const PlayerProfilesManagement()));
                          }),
                          _buildOrgCard(context, Icons.add_business_rounded, 'CDL TEAMS & LOGOS', 'Add Teams & Branding', () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const CdlTeamsManagement()));
                          }),
                          _buildOrgCard(context, Icons.event_available_rounded, 'CDL FIXTURE MAKER', 'Generate Match Days', () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const CdlFixtureMaker()));
                          }),
                          _buildOrgCard(context, Icons.table_view_rounded, 'CDL LEAGUE TABLES', 'Games Played & Scores', () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const LeagueTablesPage()));
                          }),
                        ],
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 30)),
                    _buildFooter(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: cardLightColor,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(Icons.admin_panel_settings_rounded, 
                size: 150, 
                color: Colors.black.withValues(alpha: 0.05)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('CDL ORGANIZER HUB',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2)),
              const SizedBox(height: 8),
              const Text('CDL LEAGUE',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                      letterSpacing: -1)),
              const Text('ADMINISTRATION',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      height: 1.0,
                      letterSpacing: -1.5)),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('OFFICIAL PANEL',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 10,
                        fontWeight: FontWeight.w800)),
              ),
            ],
          ),
        ],
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
          const Text('CDL STATIXA',
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

  Widget _buildOrgCard(BuildContext context, IconData icon, String title, String subtitle, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: surfaceColor.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                shape: BoxShape.circle,
                border: Border.all(color: goldColor.withValues(alpha: 0.3)),
              ),
              child: Icon(icon, color: goldColor, size: 24),
            ),
            const SizedBox(height: 15),
            Text(title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    letterSpacing: 0.5),
                textAlign: TextAlign.center),
            const SizedBox(height: 4),
            Text(subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white38, fontSize: 9),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.8),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        ),
        child: Column(
          children: [
            const Text('OFFICIAL CDL PARTNERS',
                style: TextStyle(
                    color: goldColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2)),
            const SizedBox(height: 25),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildFooterClub('Core FC'),
                _buildFooterClub('Dubai City Football Club'),
                _buildFooterClub('United Football Club'),
                _buildFooterClub('Eagle FC'),
                _buildFooterClub('Emirates Club'),
                _buildFooterClub('Gulf united FC'),
              ],
            ),
            const SizedBox(height: 40),
            Image.asset('assets/logo.png', height: 25, color: Colors.white10),
            const SizedBox(height: 15),
            Text('STATIXA CDL ADMINISTRATION',
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.2),
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1)),
            const SizedBox(height: 5),
            Text('© 2024 STATIXA. ALL RIGHTS RESERVED.',
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.1),
                    fontSize: 8)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterClub(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Text(
        name,
        style: const TextStyle(
          color: Colors.white54,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
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
                          child: Icon(Icons.groups_outlined, size: 35, color: goldColor),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('CDL ORGANIZER',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              Text('League Admin | STATIXA',
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
                    child: Text('CDL MANAGEMENT',
                        style: TextStyle(
                            color: Colors.white24,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2)),
                  ),
                  _buildDrawerItem(Icons.event_note_outlined, 'Season Schedule', () {}),
                  _buildDrawerItem(Icons.payments_outlined, 'League Fees', () {}),
                  _buildDrawerItem(Icons.verified_outlined, 'Club Affiliations', () {}),
                  _buildDrawerItem(Icons.settings_outlined, 'Organizer Settings', () {}),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
                    child: Text('SUPPORT',
                        style: TextStyle(
                            color: Colors.white24,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2)),
                  ),
                  _buildDrawerItem(Icons.help_outline_rounded, 'Help Center', () {}),
                  _buildDrawerItem(Icons.info_outline_rounded, 'About Statixa', () {}),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.white10, height: 1),
          _buildDrawerItem(Icons.logout_rounded, 'Logout', () {
            Navigator.pushReplacementNamed(context, '/login');
          }),
          _buildDrawerItem(Icons.delete_forever_rounded, 'Delete Account', () {
          }, isRed: true),
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
}
