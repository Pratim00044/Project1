import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'squad_page.dart';
import 'games_page.dart';
import 'profile_page.dart';
import 'more_page.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);

class CoachHome extends StatefulWidget {
  const CoachHome({super.key});

  @override
  State<CoachHome> createState() => _CoachHomeState();
}

class _CoachHomeState extends State<CoachHome> {
  int _selectedIndex = 0;
  final List<int> _history = [0];

  final List<Widget> _pages = [
    const DashboardPage(),
    const SquadPage(),
    const GamesPage(),
    const ProfilePage(),
    const MorePage(),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
        _history.add(index);
      });
    }
  }

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
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 35,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 12),
            const Text(
              'STATIXA COACH',
              style: TextStyle(
                color: goldColor,
                fontSize: 16,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded, color: goldColor),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: _pages[_selectedIndex],
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
              BottomNavigationBarItem(icon: Icon(Icons.sports_soccer_outlined), label: 'GAME'),
              BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: 'PROFILE'),
              BottomNavigationBarItem(icon: Icon(Icons.more_horiz_rounded), label: 'MORE'),
            ],
          ),
        ),
      ),
    ),
  );
}
}
