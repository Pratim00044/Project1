import 'package:flutter/material.dart';
import 'organization_home.dart';

const Color goldColor = Color(0xFFD4AF37);

class OrgFooter extends StatelessWidget {
  const OrgFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.8),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFooterTool(context, Icons.person_search_rounded, 'PLAYERS', 1),
              _buildFooterTool(context, Icons.shield_outlined, 'TEAMS', 2),
              _buildFooterTool(context, Icons.event_available_rounded, 'FIXTURES', 3),
              _buildFooterTool(context, Icons.table_rows_rounded, 'TABLES', 4),
            ],
          ),
          const SizedBox(height: 40),
          Image.asset('assets/images/footlab.png', height: 25, color: Colors.white10),
          const SizedBox(height: 15),
          Text('STATIXA ADMINISTRATION',
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
    );
  }

  Widget _buildFooterTool(BuildContext context, IconData icon, String label, int index) {
    return InkWell(
      onTap: () {
        final homeState = context.findAncestorStateOfType<OrganisationHomeState>();
        homeState?.changeTab(index);
      },
      borderRadius: BorderRadius.circular(30),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: goldColor, size: 20),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white38, fontSize: 8, fontWeight: FontWeight.bold, letterSpacing: 1)),
        ],
      ),
    );
  }
}
