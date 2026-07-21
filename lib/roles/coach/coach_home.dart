import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'squad_page.dart';
import 'games_page.dart';
import '../organization/player_progress_dashboard.dart';
import 'coach_notifications_page.dart';
import 'profile_details/privacy_security.dart';
import '../chatbot_page.dart';
import '../../widgets/animated_chatbot_fab.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class CoachHome extends StatefulWidget {
  const CoachHome({super.key});

  @override
  State<CoachHome> createState() => _CoachHomeState();
}

class _CoachHomeState extends State<CoachHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const SquadPage(),
    const GamesPage(),
    const PlayerProgressDashboard(showBackButton: false),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkBg,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        endDrawer: _buildDrawer(context),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: Stack(
                  children: [
                    _pages[_selectedIndex],
                    const Positioned(
                      top: 10,
                      right: 0,
                      child: AnimatedChatBotFAB(),
                    ),
                  ],
                ),
              ),
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
            onTap: _onItemTapped,
            selectedFontSize: 9,
            unselectedFontSize: 9,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'DASHBOARD'),
              BottomNavigationBarItem(icon: Icon(Icons.shield_outlined), label: 'SQUAD'),
              BottomNavigationBarItem(icon: Icon(Icons.calendar_today_rounded), label: 'GAMES'),
              BottomNavigationBarItem(icon: Icon(Icons.auto_graph_rounded), label: 'PROGRESS'),
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
                    decoration: const BoxDecoration(
                      color: Color(0xFF0D0D0D),
                      border: Border(bottom: BorderSide(color: Colors.white10, width: 0.5)),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 35, 
                          backgroundColor: goldColor.withValues(alpha: 0.1),
                          child: const Text('LS', style: TextStyle(color: goldColor, fontWeight: FontWeight.bold, fontSize: 24)),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'LIONEL SCALONI',
                                style: TextStyle(
                                  color: goldColor, 
                                  fontWeight: FontWeight.w900, 
                                  fontSize: 20,
                                  letterSpacing: 0.5,
                                )
                              ),
                              Text(
                                'Rank #1 | ACADEMY COACH', 
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.5), 
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
                    child: Text('APP SETTINGS',
                        style: TextStyle(
                            color: Colors.white24,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2)),
                  ),
                  _buildDrawerItem(Icons.person_outline_rounded, 'Account Preferences', () {}),
                  _buildDrawerItem(Icons.notifications_none_rounded, 'Notifications', () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CoachNotificationsPage())), badge: '3'),
                  _buildDrawerItem(Icons.verified_user_outlined, 'Privacy & Security', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacySecurityPage()))),
                  _buildDrawerItem(Icons.language_rounded, 'Language', () {}),
                  
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
                    child: Text('PERFORMANCE',
                        style: TextStyle(
                            color: Colors.white24,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2)),
                  ),
                  _buildDrawerItem(Icons.trending_up_rounded, 'Past Performance', () {}),
                  _buildDrawerItem(Icons.emoji_events_rounded, 'Trophy Cabinet', () {}),

                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
                    child: Text('SUPPORT & APP',
                        style: TextStyle(
                            color: Colors.white24,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2)),
                  ),
                  _buildDrawerItem(Icons.help_outline_rounded, 'Help Center', () {}),
                  _buildDrawerItem(Icons.feedback_outlined, 'Send Feedback', () {}),
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
        title: const Text('Permanent Delete',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
        content: const Text('Are you sure? All Statixa data will be erased.',
            style: TextStyle(color: Colors.white60, fontSize: 14)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL', style: TextStyle(color: Colors.white38))),
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
            child: const Text('DELETE',
                style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap,
      {bool isRed = false, bool isSelected = false, String? badge}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListTile(
        dense: true,
        visualDensity: const VisualDensity(vertical: -2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Stack(
          children: [
            Icon(icon,
                color: isSelected
                    ? goldColor
                    : (isRed ? Colors.redAccent.withValues(alpha: 0.7) : Colors.white38),
                size: 20),
            if (badge != null)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 8,
                    minHeight: 8,
                  ),
                ),
              ),
          ],
        ),
        title: Text(title,
            style: TextStyle(
                color: isSelected
                    ? goldColor
                    : (isRed ? Colors.redAccent : Colors.white70),
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500)),
        trailing: badge != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: goldColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: goldColor.withValues(alpha: 0.2)),
                ),
                child: Text(badge,
                    style: const TextStyle(
                        color: goldColor, fontSize: 10, fontWeight: FontWeight.bold)),
              )
            : null,
        onTap: onTap,
        selected: isSelected,
        selectedTileColor: goldColor.withValues(alpha: 0.05),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 15, 20, 10),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              if (_selectedIndex == 0) {
                // If on Dashboard, go to login
                Navigator.pushReplacementNamed(context, '/login');
              } else {
                // If on any other tab, go back to the Dashboard
                setState(() {
                  _selectedIndex = 0;
                });
              }
            },
          ),
          Image.asset('assets/logo.png', height: 65, fit: BoxFit.contain),
          const SizedBox(width: 15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Core FC',
                    style: TextStyle(
                        color: goldColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5)),
                Text('Coach Dashboard',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
    );
  }
}
