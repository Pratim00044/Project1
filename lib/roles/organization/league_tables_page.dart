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
  String _selectedGameType = '7-A-SIDE';

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
        elevation: 0,
        centerTitle: true,
        title: const Text('LEAGUE TABLES', style: TextStyle(color: goldColor, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: goldColor,
          labelColor: goldColor,
          unselectedLabelColor: Colors.white38,
          labelStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1),
          tabs: const [
            Tab(text: 'TEAMS'),
            Tab(text: 'PLAYERS'),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          _buildGameTypeFilter(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTeamTable(context),
                _buildPlayerTable(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameTypeFilter() {
    final types = ['5-A-SIDE', '7-A-SIDE', '8-A-SIDE', '9-A-SIDE', '11-A-SIDE'];
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: types.length,
        itemBuilder: (context, index) {
          bool isSelected = _selectedGameType == types[index];
          return GestureDetector(
            onTap: () => setState(() => _selectedGameType = types[index]),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected ? goldColor : surfaceColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isSelected ? goldColor : Colors.white10),
              ),
              child: Center(
                child: Text(
                  types[index],
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white38,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTeamTable(BuildContext context) {
    final List<Map<String, dynamic>> standings = [
      {'pos': 1, 'team': 'National Gulf FC', 'p': 10, 'w': 8, 'd': 1, 'l': 1, 'gd': 15, 'pts': 25},
      {'pos': 2, 'team': 'Turan Dubai FC', 'p': 10, 'w': 7, 'd': 2, 'l': 1, 'gd': 12, 'pts': 23},
      {'pos': 3, 'team': 'National Paints FC', 'p': 10, 'w': 5, 'd': 2, 'l': 3, 'gd': 4, 'pts': 17},
      {'pos': 4, 'team': 'Street League FC', 'p': 10, 'w': 4, 'd': 1, 'l': 5, 'gd': -2, 'pts': 13},
      {'pos': 5, 'team': 'FC Dynamo Dubai', 'p': 10, 'w': 3, 'd': 2, 'l': 5, 'gd': -3, 'pts': 11},
      {'pos': 6, 'team': 'Core FC', 'p': 10, 'w': 3, 'd': 1, 'l': 6, 'gd': -5, 'pts': 10},
      {'pos': 7, 'team': 'Dubai City FC', 'p': 10, 'w': 2, 'd': 3, 'l': 5, 'gd': -8, 'pts': 9},
      {'pos': 8, 'team': 'United FC', 'p': 10, 'w': 2, 'd': 2, 'l': 6, 'gd': -10, 'pts': 8},
      {'pos': 9, 'team': 'Eagle FC', 'p': 10, 'w': 1, 'd': 4, 'l': 5, 'gd': -12, 'pts': 7},
      {'pos': 10, 'team': 'Emirates Club', 'p': 10, 'w': 1, 'd': 2, 'l': 7, 'gd': -15, 'pts': 5},
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Text('PREMIER LEAGUE STANDINGS', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
            child: Text('Season 2024 - Matchday 10', style: TextStyle(color: Colors.white38, fontSize: 12)),
          ),
          _buildTableContainer(
            DataTable(
              columnSpacing: 15,
              horizontalMargin: 20,
              columns: const [
                DataColumn(label: Text('#', style: TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.w900))),
                DataColumn(label: Text('TEAM', style: TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.w900))),
                DataColumn(label: Text('P', style: TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('GD', style: TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('PTS', style: TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold))),
              ],
              rows: standings.asMap().entries.map((entry) {
                final int index = entry.key;
                final Map<String, dynamic> s = entry.value;
                final List<Color> rowColors = _getRowGradients(index);
                
                return DataRow(
                  color: WidgetStateProperty.all(rowColors.first.withValues(alpha: 0.15)),
                  cells: [
                    DataCell(Text(s['pos'].toString(), style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold))),
                    DataCell(
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 10, 
                            backgroundColor: rowColors.first.withValues(alpha: 0.2), 
                            child: Text(s['team'][0], style: TextStyle(color: rowColors.first, fontSize: 8, fontWeight: FontWeight.bold))
                          ),
                          const SizedBox(width: 8),
                          Text(s['team'], style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900)),
                        ],
                      ),
                    ),
                    DataCell(Text(s['p'].toString(), style: const TextStyle(color: Colors.white70, fontSize: 11))),
                    DataCell(Text(s['gd'].toString(), style: TextStyle(color: s['gd'] >= 0 ? Colors.blueAccent : Colors.redAccent, fontSize: 11, fontWeight: FontWeight.bold))),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: rowColors),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(s['pts'].toString(), style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900)),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  List<Color> _getRowGradients(int index) {
    const gradients = [
      [Color(0xFFFFD700), Color(0xFFFF8C00)],
      [Color(0xFF00F2FE), Color(0xFF4FACFE)],
      [Color(0xFF43E97B), Color(0xFF38F9D7)],
      [Color(0xFFFA709A), Color(0xFFFEE140)],
      [Color(0xFFB721FF), Color(0xFF21D4FD)],
      [Color(0xFFFF0844), Color(0xFFFFB199)],
      [Color(0xFF667EEA), Color(0xFF764BA2)],
      [Color(0xFFF093FB), Color(0xFFF5576C)],
      [Color(0xFF00FF00), Color(0xFF000000)],
      [Color(0xFFD4145A), Color(0xFFFBB03B)],
    ];
    return gradients[index % gradients.length];
  }

  Widget _buildPlayerTable(BuildContext context) {
    final List<Map<String, dynamic>> playerStats = [
      {'pos': 1, 'name': 'Cristiano Ronaldo', 'team': 'Core FC', 'goals': 24, 'rating': 9.2},
      {'pos': 2, 'name': 'Kevin De Bruyne', 'team': 'Core FC', 'goals': 12, 'rating': 8.9},
      {'pos': 3, 'name': 'Kylian Mbappé', 'team': 'Eagle FC', 'goals': 10, 'rating': 8.7},
      {'pos': 4, 'name': 'Luka Modrić', 'team': 'United FC', 'goals': 5, 'rating': 8.5},
      {'pos': 5, 'name': 'Lionel Messi', 'team': 'Core FC', 'goals': 18, 'rating': 9.1},
      {'pos': 6, 'name': 'Erling Haaland', 'team': 'National Gulf FC', 'goals': 15, 'rating': 8.8},
      {'pos': 7, 'name': 'Mohamed Salah', 'team': 'Turan Dubai FC', 'goals': 14, 'rating': 8.6},
      {'pos': 8, 'name': 'Neymar Jr', 'team': 'Street League FC', 'goals': 9, 'rating': 8.4},
      {'pos': 9, 'name': 'Robert Lewandowski', 'team': 'National Paints FC', 'goals': 8, 'rating': 8.2},
      {'pos': 10, 'name': 'Harry Kane', 'team': 'FC Dynamo Dubai', 'goals': 7, 'rating': 8.0},
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Text('TOP PERFORMERS', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
            child: Text('Player individual statistics ranking', style: TextStyle(color: Colors.white38, fontSize: 12)),
          ),
          _buildTableContainer(
            DataTable(
              columnSpacing: 15,
              horizontalMargin: 20,
              columns: const [
                DataColumn(label: Text('#', style: TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.w900))),
                DataColumn(label: Text('PLAYER', style: TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.w900))),
                DataColumn(label: Text('GOALS', style: TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('RTG', style: TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold))),
              ],
              rows: playerStats.asMap().entries.map((entry) {
                final int index = entry.key;
                final Map<String, dynamic> s = entry.value;
                final List<Color> rowColors = _getRowGradients(index);
                
                return DataRow(
                  color: WidgetStateProperty.all(rowColors.first.withValues(alpha: 0.15)),
                  cells: [
                    DataCell(Text(s['pos'].toString(), style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold))),
                    DataCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(s['name'], style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900)),
                          Text(s['team'], style: const TextStyle(color: Colors.white38, fontSize: 9)),
                        ],
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: rowColors),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(s['goals'].toString(), style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1), 
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: rowColors.first.withValues(alpha: 0.3))
                        ),
                        child: Text(s['rating'].toString(), style: TextStyle(color: rowColors.first, fontSize: 11, fontWeight: FontWeight.w900)),
                      ),
                    ),
                  ],
                );
              }).toList(),
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
        gradient: LinearGradient(
          colors: [surfaceColor, const Color(0xFF1A1A1A)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border.symmetric(horizontal: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 5))
        ],
      ),
      child: Theme(
        data: ThemeData.dark().copyWith(dividerColor: Colors.white10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
            child: table,
          ),
        ),
      ),
    );
  }
}
