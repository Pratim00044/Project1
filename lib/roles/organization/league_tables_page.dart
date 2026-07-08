import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class LeagueTablesPage extends StatefulWidget {
  const LeagueTablesPage({super.key});

  @override
  State<LeagueTablesPage> createState() => _LeagueTablesPageState();
}

class _LeagueTablesPageState extends State<LeagueTablesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('CDL LEAGUE TABLES', style: TextStyle(color: goldColor, fontWeight: FontWeight.bold, fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: goldColor,
          labelColor: goldColor,
          unselectedLabelColor: Colors.white38,
          tabs: const [
            Tab(text: 'TEAMS'),
            Tab(text: 'PLAYERS'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTeamTable(context),
          _buildPlayerTable(context),
        ],
      ),
    );
  }

  Widget _buildTeamTable(BuildContext context) {
    final List<Map<String, dynamic>> _standings = [
      {'pos': 1, 'team': 'National Gulf FC', 'p': 10, 'w': 8, 'd': 1, 'l': 1, 'gd': 15, 'pts': 25},
      {'pos': 2, 'team': 'Turan Dubai FC', 'p': 10, 'w': 7, 'd': 2, 'l': 1, 'gd': 12, 'pts': 23},
      {'pos': 3, 'team': 'National Paints FC', 'p': 10, 'w': 5, 'd': 2, 'l': 3, 'gd': 4, 'pts': 17},
      {'pos': 4, 'team': 'Street League FC', 'p': 10, 'w': 4, 'd': 1, 'l': 5, 'gd': -2, 'pts': 13},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('CDL PREMIER LEAGUE 2024', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          const Text('Matchday 10 of 18', style: TextStyle(color: Colors.white38, fontSize: 12)),
          const SizedBox(height: 25),
          _buildTableContainer(
            DataTable(
              columnSpacing: 12,
              horizontalMargin: 15,
              columns: const [
                DataColumn(label: Text('#', style: TextStyle(color: goldColor, fontSize: 10))),
                DataColumn(label: Text('TEAM', style: TextStyle(color: goldColor, fontSize: 10))),
                DataColumn(label: Text('GP', style: TextStyle(color: Colors.white60, fontSize: 10))),
                DataColumn(label: Text('SCORE', style: TextStyle(color: Colors.white60, fontSize: 10))),
                DataColumn(label: Text('PTS', style: TextStyle(color: Colors.white60, fontSize: 10))),
              ],
              rows: _standings.map((s) => DataRow(cells: [
                DataCell(Text(s['pos'].toString(), style: const TextStyle(color: Colors.white70, fontSize: 11))),
                DataCell(Text(s['team'], style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))),
                DataCell(Text(s['p'].toString(), style: const TextStyle(color: Colors.white70, fontSize: 11))),
                DataCell(Text(s['gd'].toString(), style: const TextStyle(color: Colors.white70, fontSize: 11))),
                DataCell(Text(s['pts'].toString(), style: const TextStyle(color: goldColor, fontSize: 12, fontWeight: FontWeight.bold))),
              ])).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerTable(BuildContext context) {
    final List<Map<String, dynamic>> _playerStats = [
      {'pos': 1, 'name': 'Sunil Chhetri', 'team': 'Under 8s', 'goals': 24, 'rating': 9.2},
      {'pos': 2, 'name': 'Sahal Abdul', 'team': 'Under 8s', 'goals': 12, 'rating': 8.9},
      {'pos': 3, 'name': 'L. Chhangte', 'team': 'Under 10s', 'goals': 10, 'rating': 8.7},
      {'pos': 4, 'name': 'Anirudh Thapa', 'team': 'Under 8s', 'goals': 5, 'rating': 8.5},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ACADEMY PLAYER RANKINGS', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          const Text('Updated weekly based on performance', style: TextStyle(color: Colors.white38, fontSize: 12)),
          const SizedBox(height: 25),
          _buildTableContainer(
            DataTable(
              columnSpacing: 12,
              horizontalMargin: 15,
              columns: const [
                DataColumn(label: Text('#', style: TextStyle(color: goldColor, fontSize: 10))),
                DataColumn(label: Text('PLAYER', style: TextStyle(color: goldColor, fontSize: 10))),
                DataColumn(label: Text('TEAM', style: TextStyle(color: Colors.white60, fontSize: 10))),
                DataColumn(label: Text('G', style: TextStyle(color: Colors.white60, fontSize: 10))),
                DataColumn(label: Text('RTG', style: TextStyle(color: Colors.white60, fontSize: 10))),
              ],
              rows: _playerStats.map((s) => DataRow(cells: [
                DataCell(Text(s['pos'].toString(), style: const TextStyle(color: Colors.white70, fontSize: 11))),
                DataCell(Text(s['name'], style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))),
                DataCell(Text(s['team'], style: const TextStyle(color: Colors.white70, fontSize: 11))),
                DataCell(Text(s['goals'].toString(), style: const TextStyle(color: Colors.white70, fontSize: 11))),
                DataCell(Text(s['rating'].toString(), style: const TextStyle(color: goldColor, fontSize: 12, fontWeight: FontWeight.bold))),
              ])).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableContainer(Widget table) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Theme(
        data: ThemeData.dark().copyWith(dividerColor: Colors.white10),
        child: table,
      ),
    );
  }
}
