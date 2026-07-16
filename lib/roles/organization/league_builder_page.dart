import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class LeagueBuilderPage extends StatefulWidget {
  const LeagueBuilderPage({super.key});

  @override
  State<LeagueBuilderPage> createState() => _LeagueBuilderPageState();
}

class _LeagueBuilderPageState extends State<LeagueBuilderPage> {
  final List<Map<String, String>> _teams = [
    {'name': 'National Gulf FC', 'logo': 'G'},
    {'name': 'National Paints FC', 'logo': 'P'},
    {'name': 'Turan Dubai FC', 'logo': 'T'},
  ];

  final TextEditingController _leagueNameController = TextEditingController();
  final TextEditingController _teamNameController = TextEditingController();

  void _addTeam() {
    if (_teamNameController.text.isNotEmpty) {
      setState(() {
        _teams.add({
          'name': _teamNameController.text,
          'logo': _teamNameController.text[0].toUpperCase(),
        });
        _teamNameController.clear();
      });
    }
  }

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('CDL LEAGUE BUILDER',
                      style: TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
                  const SizedBox(height: 25),
                  const Text('LEAGUE DETAILS', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _leagueNameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'e.g. CDL Premier League 2024',
                      hintStyle: const TextStyle(color: Colors.white24, fontSize: 14),
                      filled: true,
                      fillColor: surfaceColor,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                      prefixIcon: const Icon(Icons.emoji_events_outlined, color: goldColor, size: 18),
                    ),
                  ),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('TEAMS', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1)),
                      Text('${_teams.length} ADDED', style: const TextStyle(color: Colors.white38, fontSize: 10)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _teamNameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Enter Team Name',
                            hintStyle: const TextStyle(color: Colors.white24, fontSize: 14),
                            filled: true,
                            fillColor: surfaceColor,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: _addTeam,
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(color: goldColor, borderRadius: BorderRadius.circular(15)),
                          child: const Icon(Icons.add, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _teams.length,
                    itemBuilder: (context, index) {
                      final List<List<Color>> itemGradients = [
                        [const Color(0xFF2E5B4F), const Color(0xFF3B2A50)],
                        [const Color(0xFF1E3A8A), const Color(0xFF312E81)],
                        [const Color(0xFF334155), const Color(0xFF1E293B)],
                      ];
                      final List<Color> currentGradient = itemGradients[index % itemGradients.length];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: currentGradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withOpacity(0.02)),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.white10,
                              child: Text(_teams[index]['logo']!, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 15),
                            Text(_teams[index]['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.white70, size: 18),
                              onPressed: () => setState(() => _teams.removeAt(index)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 35),
                  ElevatedButton(
                    onPressed: () => _generateFixtures(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: goldColor,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: const Text('GENERATE LEAGUE & FIXTURES', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, letterSpacing: 1)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _generateFixtures(BuildContext context) {
    if (_teams.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add at least 2 teams to generate fixtures!')));
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Fixtures Generated', style: TextStyle(color: goldColor, fontSize: 16, fontWeight: FontWeight.bold)),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _teams.length - 1,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_teams[i]['name']!, style: const TextStyle(color: Colors.white, fontSize: 13)),
                    const Text('vs', style: TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.bold)),
                    Text(_teams[i+1]['name']!, style: const TextStyle(color: Colors.white, fontSize: 13)),
                  ],
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CLOSE', style: TextStyle(color: goldColor, fontWeight: FontWeight.bold))),
        ],
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
