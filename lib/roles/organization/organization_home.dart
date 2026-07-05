import 'package:flutter/material.dart';
import 'pending_approval_page.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);

class OrganizationHome extends StatefulWidget {
  const OrganizationHome({super.key});

  @override
  State<OrganizationHome> createState() => _OrganizationHomeState();
}

class _OrganizationHomeState extends State<OrganizationHome> {
  bool isApproved = false;

  @override
  Widget build(BuildContext context) {
    if (!isApproved) {
      return const PendingApprovalPage();
    }
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('STATIXA ORGANIZER HUB', style: TextStyle(color: goldColor, fontWeight: FontWeight.bold, letterSpacing: 2)),
        actions: [
          IconButton(icon: const Icon(Icons.logout, color: goldColor), onPressed: () => Navigator.pushReplacementNamed(context, '/login')),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('CLUB ADMINISTRATION', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: [
                    _buildOrgCard(Icons.add_business_rounded, 'CREATE CLUB', 'Register Team'),
                    _buildOrgCard(Icons.event_available_rounded, 'ARRANGE GAMES', 'Matches & Events'),
                    _buildOrgCard(Icons.assignment_ind_rounded, 'COACH ACCESS', 'Verify Coaches'),
                    _buildOrgCard(Icons.account_balance_wallet_rounded, 'FINANCE', 'Budgets & Fees'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrgCard(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: goldColor.withOpacity(0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: goldColor, size: 40),
          const SizedBox(height: 15),
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14), textAlign: TextAlign.center),
          const SizedBox(height: 5),
          Text(subtitle, style: const TextStyle(color: Colors.white38, fontSize: 11)),
        ],
      ),
    );
  }
}
