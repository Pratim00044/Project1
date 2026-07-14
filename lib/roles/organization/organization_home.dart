import 'package:flutter/material.dart';
import 'pending_approval_page.dart';
import 'player_profiles_management.dart';
import 'league_tables_page.dart';
import 'cdl_teams_management.dart';
import 'cdl_fixture_maker.dart';
import 'social_leagues_page.dart';
import 'create_match_page.dart';
import 'organization_dashboard.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color greenAccent = Color(0xFF2ECC71);
const Color darkBg = Color(0xFF080808);

class OrganisationHome extends StatefulWidget {
  const OrganisationHome({super.key});

  @override
  State<OrganisationHome> createState() => OrganisationHomeState();
}

class OrganisationHomeState extends State<OrganisationHome> {
  bool isApproved = true;
  int _selectedIndex = 0;

  void changeTab(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const OrganisationDashboard(),
      const PlayerProfilesManagement(),
      const CdlTeamsManagement(),
      const CdlFixtureMaker(),
      const LeagueTablesPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (!isApproved) {
      return const PendingApprovalPage();
    }
    return Scaffold(
      backgroundColor: Colors.black,
      endDrawer: _buildDrawer(context),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(child: _pages[_selectedIndex]),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: goldColor.withValues(alpha: 0.1), width: 0.5)),
          color: const Color(0xFF0D0D0D),
        ),
        child: SafeArea(
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: goldColor,
            unselectedItemColor: Colors.white24,
            currentIndex: _selectedIndex,
            onTap: changeTab,
            selectedFontSize: 9,
            unselectedFontSize: 9,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'DASHBOARD'),
              BottomNavigationBarItem(icon: Icon(Icons.person_search_rounded), label: 'PLAYERS'),
              BottomNavigationBarItem(icon: Icon(Icons.shield_outlined), label: 'TEAMS'),
              BottomNavigationBarItem(icon: Icon(Icons.event_available_rounded), label: 'FIXTURES'),
              BottomNavigationBarItem(icon: Icon(Icons.table_rows_rounded), label: 'TABLES'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    const String title = 'FOOTLAB DXB';

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
      child: Row(
        children: [
          Image.asset('assets/images/footlab.png', height: 65, fit: BoxFit.contain),
          const SizedBox(width: 20),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0)),
                ),
              ],
            ),
          ),
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
                          child: Icon(Icons.groups_outlined, size: 35, color: greenAccent),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('AHMED AL-MANSOORI',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              Text('Social Organiser | STATIXA',
                                  style: TextStyle(
                                      color: goldColor.withValues(alpha: 0.7),
                                      fontSize: 10)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
                    child: Text('MANAGEMENT',
                        style: TextStyle(
                            color: Colors.white24,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2)),
                  ),
                  _buildDrawerItem(Icons.explore_outlined, 'Social Leagues', () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SocialLeaguesPage()));
                  }),
                  _buildDrawerItem(Icons.sports_soccer_rounded, 'Create Match', () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateMatchPage()));
                  }),
                  _buildDrawerItem(Icons.assignment_ind_rounded, 'Player Profiles', () {
                    changeTab(1);
                    Navigator.pop(context);
                  }),
                  _buildDrawerItem(Icons.event_note_outlined, 'Season Schedule', () {}),
                  _buildDrawerItem(Icons.payments_outlined, 'League Fees', () {}),
                  _buildDrawerItem(Icons.verified_outlined, 'Club Affiliations', () {}),
                  _buildDrawerItem(Icons.settings_outlined, 'Organiser Settings', () {}),
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
      {bool isRed = false, bool isSelected = false, Color? accentColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListTile(
        dense: true,
        visualDensity: const VisualDensity(vertical: -2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Icon(icon,
            color: isSelected
                ? (accentColor ?? goldColor)
                : (isRed ? Colors.redAccent.withValues(alpha: 0.7) : Colors.white38),
            size: 20),
        title: Text(title,
            style: TextStyle(
                color: isSelected
                    ? (accentColor ?? goldColor)
                    : (isRed ? Colors.redAccent : Colors.white70),
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500)),
        onTap: onTap,
        selected: isSelected,
        selectedTileColor: (accentColor ?? goldColor).withValues(alpha: 0.05),
      ),
    );
  }
}
