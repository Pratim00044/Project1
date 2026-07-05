import 'package:flutter/material.dart';
import 'manager_dashboard.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);

class ManagerHome extends StatefulWidget {
  const ManagerHome({super.key});

  @override
  State<ManagerHome> createState() => _ManagerHomeState();
}

class _ManagerHomeState extends State<ManagerHome> {
  int _selectedIndex = 0;
  final List<int> _history = [0];

  final List<Widget> _pages = [
    const ManagerDashboard(),
    const Center(child: Text('Teams Page', style: TextStyle(color: Colors.white))),
    const Center(child: Text('Staff Page', style: TextStyle(color: Colors.white))),
    const Center(child: Text('Budget Page', style: TextStyle(color: Colors.white))),
    const Center(child: Text('Settings Page', style: TextStyle(color: Colors.white))),
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
              'STATIXA MANAGER',
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
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: goldColor.withValues(alpha: 0.1), width: 0.5)),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF0D0D0D),
          selectedItemColor: goldColor,
          unselectedItemColor: Colors.white24,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedFontSize: 9,
          unselectedFontSize: 9,
          showUnselectedLabels: true,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'DASHBOARD'),
            BottomNavigationBarItem(icon: Icon(Icons.groups_rounded), label: 'TEAMS'),
            BottomNavigationBarItem(icon: Icon(Icons.badge_rounded), label: 'STAFF'),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_rounded), label: 'BUDGET'),
            BottomNavigationBarItem(icon: Icon(Icons.settings_rounded), label: 'SETTINGS'),
          ],
        ),
      ),
    ),
  );
}
}
