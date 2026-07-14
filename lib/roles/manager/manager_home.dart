import 'package:flutter/material.dart';
import 'manager_dashboard.dart';
import 'manager_teams_page.dart';
import 'manager_budget_page.dart';
import 'manager_settings_page.dart';
import 'manager_notifications_page.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class ManagerHome extends StatefulWidget {
  const ManagerHome({super.key});

  @override
  State<ManagerHome> createState() => _ManagerHomeState();
}

class _ManagerHomeState extends State<ManagerHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ManagerDashboard(),
    const ManagerTeamsPage(),
    const ManagerBudgetPage(),
    const ManagerSettingsPage(),
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
    return Scaffold(
      backgroundColor: darkBg,
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
            onTap: _onItemTapped,
            selectedFontSize: 9,
            unselectedFontSize: 9,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'DASHBOARD'),
              BottomNavigationBarItem(icon: Icon(Icons.groups_rounded), label: 'TEAMS'),
              BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_rounded), label: 'BUDGET'),
              BottomNavigationBarItem(icon: Icon(Icons.settings_rounded), label: 'SETTINGS'),
            ],
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
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xFF1A1A1A),
                          child: Icon(Icons.manage_accounts_rounded, size: 35, color: goldColor),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('MANAGER Lionel Scaloni',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              Text('Club Operations | STATIXA',
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
                    child: Text('ADMINISTRATION',
                        style: TextStyle(
                            color: Colors.white24,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2)),
                  ),
                  _buildDrawerItem(Icons.business_center_outlined, 'Club Profile', () {}),
                  _buildDrawerItem(Icons.notifications_active_outlined, 'Notifications', () {
                    Navigator.pop(context); // Close drawer
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManagerNotificationsPage()));
                  }),
                  _buildDrawerItem(Icons.people_outline, 'Staff Directory', () {}),
                  _buildDrawerItem(Icons.assignment_turned_in_outlined, 'Approvals', () {}),
                  _buildDrawerItem(Icons.analytics_outlined, 'Annual Reports', () {}),
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

  Widget _buildHeader(BuildContext context) {
    const String title = 'MANAGER DASHBOARD';
    const String subtitle = 'STATIXA';

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
      child: Row(
        children: [
          Image.asset('assets/logo.png', height: 65, fit: BoxFit.contain),
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
                Text(subtitle,
                    style: TextStyle(
                        color: goldColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5)),
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
