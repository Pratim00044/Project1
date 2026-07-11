import 'package:flutter/material.dart';
import 'player_dashboard.dart' hide surfaceColor;
import 'player_team.dart' hide surfaceColor;
import 'player_games.dart';
import 'player_profile.dart';
import 'profile_details/security_detail.dart';
import 'profile_details/help_center_detail.dart';
import 'profile_details/notifications_page.dart';
import 'profile_details/progress_page.dart';
import 'drawer_pages.dart';
import 'profile_menu_pages.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class PlayerHome extends StatefulWidget {
  const PlayerHome({super.key});

  @override
  State<PlayerHome> createState() => PlayerHomeState();
}

class PlayerHomeState extends State<PlayerHome> {
  int _selectedIndex = 0;
  final List<int> _history = [0];

  void changeTab(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
        _history.add(index);
      });
    }
  }

  final List<Widget> _pages = [
    const PlayerDashboard(),
    const MyTeamsPage(),
    const PlayerGamesPage(),
    const PlayerProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _selectedIndex == 0 && _history.length <= 1,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_history.length > 1) {
          setState(() {
            _history.removeLast();
            _selectedIndex = _history.last;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: null,
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
              selectedFontSize: 10,
              unselectedFontSize: 10,
              showUnselectedLabels: true,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'DASHBOARD'),
                BottomNavigationBarItem(icon: Icon(Icons.groups_rounded), label: 'TEAM'),
                BottomNavigationBarItem(icon: Icon(Icons.calendar_today_rounded), label: 'GAMES'),
                BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'PROFILE'),
              ],
            ),
          ),
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
                        const CircleAvatar(radius: 30, backgroundImage: AssetImage('assets/images/sunil.png')),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('LIONEL MESSI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                              Text('Rank #1 | Global', style: TextStyle(color: goldColor.withValues(alpha: 0.7), fontSize: 11)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
                    child: Text('PLAYER MENU', style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
                  ),
                  _buildDrawerItem(Icons.auto_graph_rounded, 'Professional Pathway', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfessionalPathwayScreen()))),
                  _buildDrawerItem(Icons.trending_up_rounded, 'Match Progress', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProgressPage()))),
                  _buildDrawerItem(Icons.sports_soccer_rounded, 'Match History', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PlayerMatchesScreen()))),
                  _buildDrawerItem(Icons.analytics_outlined, 'Performance Stats', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PlayerStatsScreen()))),
                  _buildDrawerItem(Icons.how_to_reg_rounded, 'Attendance History', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PlayerAttendanceScreen()))),
                  _buildDrawerItem(Icons.feedback_outlined, 'Coach Feedback', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PlayerFeedbackScreen()))),

                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
                    child: Text('APP SETTINGS', style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
                  ),
                  _buildDrawerItem(Icons.person_outline_rounded, 'Account Preferences', () {}),
                  _buildDrawerItem(Icons.notifications_none_rounded, 'Notifications', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsPage()))),
                  _buildDrawerItem(Icons.verified_user_outlined, 'Privacy & Security', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SecurityDetail()))),
                  _buildDrawerItem(Icons.language_rounded, 'Language', () {}),
                  
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
                    child: Text('OTHER', style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
                  ),
                  _buildDrawerItem(Icons.play_circle_outline_rounded, 'Highlight Videos', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const VideosPage()))),
                  _buildDrawerItem(Icons.newspaper_rounded, 'Latest News', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NewsPage()))),
                  _buildDrawerItem(Icons.fitness_center_rounded, 'Academy Sessions', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SessionsPage()))),
                  _buildDrawerItem(Icons.emoji_events_rounded, 'Global Rankings', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RankingsPage()))),

                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
                    child: Text('SUPPORT', style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
                  ),
                  _buildDrawerItem(Icons.help_outline_rounded, 'Help Center', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpCenterDetail()))),
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
            _showDeleteAccountDialog(context);
          }, isRed: true),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Permanent Delete', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
        content: const Text('Are you sure? All Statixa data will be erased.', style: TextStyle(color: Colors.white60, fontSize: 14)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL', style: TextStyle(color: Colors.white38))),
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
            child: const Text('DELETE', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap, {bool isRed = false, bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListTile(
        dense: true,
        visualDensity: const VisualDensity(vertical: -2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Icon(icon, color: isSelected ? goldColor : (isRed ? Colors.redAccent.withValues(alpha: 0.7) : Colors.white38), size: 20),
        title: Text(title, style: TextStyle(color: isSelected ? goldColor : (isRed ? Colors.redAccent : Colors.white70), fontSize: 13, fontWeight: isSelected ? FontWeight.bold : FontWeight.w500)),
        onTap: onTap,
        selected: isSelected,
        selectedTileColor: goldColor.withValues(alpha: 0.05),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
      child: Row(
        children: [
          Image.asset('assets/logo.png', height: 65, fit: BoxFit.contain),
          const SizedBox(width: 20),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CORE FC',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0)),
              Text('PLAYER DASHBOARD',
                  style: TextStyle(
                      color: goldColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5)),
            ],
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
}
