import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class StatsTrackerPage extends StatefulWidget {
  const StatsTrackerPage({super.key});

  @override
  State<StatsTrackerPage> createState() => _StatsTrackerPageState();
}

class _StatsTrackerPageState extends State<StatsTrackerPage> {
  final List<Map<String, dynamic>> _stats = [
    {'name': 'Ryan Cooper', 'gp': 12, 'goals': 15, 'assists': 4, 'yellow': 2, 'red': 0},
    {'name': 'Ahmed Rashid', 'gp': 10, 'goals': 8, 'assists': 12, 'yellow': 1, 'red': 0},
    {'name': 'Carlos Silva', 'gp': 11, 'goals': 1, 'assists': 2, 'yellow': 4, 'red': 1},
    {'name': 'Cristiano Ronaldo', 'gp': 9, 'goals': 14, 'assists': 3, 'yellow': 0, 'red': 0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader(context)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildStatSummaryCard('TOP SCORER', 'Ryan Cooper', '15 Goals'),
                      const SizedBox(width: 15),
                      _buildStatSummaryCard('PLAYMAKER', 'Ahmed Rashid', '12 Assist'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.white10),
                        child: DataTable(
                          columnSpacing: 25,
                          horizontalMargin: 20,
                          columns: const [
                            DataColumn(label: Text('PLAYER', style: TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('GP', style: TextStyle(color: Colors.white60, fontSize: 10))),
                            DataColumn(label: Text('G', style: TextStyle(color: Colors.white60, fontSize: 10))),
                            DataColumn(label: Text('A', style: TextStyle(color: Colors.white60, fontSize: 10))),
                            DataColumn(label: Text('Y/R', style: TextStyle(color: Colors.white60, fontSize: 10))),
                          ],
                          rows: _stats.map((s) => DataRow(cells: [
                            DataCell(Text(s['name'], style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))),
                            DataCell(Text(s['gp'].toString(), style: const TextStyle(color: Colors.white70, fontSize: 11))),
                            DataCell(Text(s['goals'].toString(), style: const TextStyle(color: Colors.greenAccent, fontSize: 11, fontWeight: FontWeight.bold))),
                            DataCell(Text(s['assists'].toString(), style: const TextStyle(color: Colors.blueAccent, fontSize: 11))),
                            DataCell(Text('${s['yellow']}/${s['red']}', style: const TextStyle(color: Colors.redAccent, fontSize: 11))),
                          ])).toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.05),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: const Text('UPDATE MATCH STATS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatSummaryCard(String title, String name, String val) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: goldColor.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white38, fontSize: 8, fontWeight: FontWeight.bold, letterSpacing: 1)),
            const SizedBox(height: 10),
            Text(name, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
            Text(val, style: const TextStyle(color: goldColor, fontSize: 15, fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 10),
          Image.asset('assets/images/footlab.png', height: 35, fit: BoxFit.contain),
          const SizedBox(width: 10),
          const Text('STATIXA',
              style: TextStyle(
                  color: Color(0xFFC0C0C0),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5)),
        ],
      ),
    );
  }
}
