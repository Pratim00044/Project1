import 'package:flutter/material.dart';
import '../organization/player_performance_detail.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);

class SquadPage extends StatefulWidget {
  const SquadPage({super.key});

  @override
  State<SquadPage> createState() => _SquadPageState();
}

class _SquadPageState extends State<SquadPage> {
  String _selectedAgeGroup = 'Under 8s';
  String _selectedLocation = 'Town Square';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _ageGroups = ['Under 8s', 'Under 10s', 'Under 12s', 'Under 18s'];
  final List<String> _locations = ['Town Square', 'Sports City', 'Jumeirah', 'Al Barsha'];

  final List<Map<String, dynamic>> _squad = [
    {
      'name': 'ALISSON BECKER',
      'pos': 'GK',
      'location': 'TOWN SQUARE',
      'phone': '+971 50 123 4567',
      'initials': 'AB',
      'category': 'GOALKEEPERS',
      'color': Color(0xFF1E3A8A)
    },
    {
      'name': 'THIBAUT COURTOIS',
      'pos': 'GK',
      'location': 'TOWN SQUARE',
      'phone': '+971 50 123 4567',
      'initials': 'TC',
      'category': 'GOALKEEPERS',
      'color': Color(0xFF3730A3)
    },
    {
      'name': 'VIRGIL VAN DIJK',
      'pos': 'CB',
      'location': 'TOWN SQUARE',
      'phone': '+971 50 123 4567',
      'initials': 'VD',
      'category': 'DEFENDERS',
      'color': Color(0xFF5B21B6)
    },
    {
      'name': 'KEVIN DE BRUYNE',
      'pos': 'CM',
      'location': 'TOWN SQUARE',
      'phone': '+971 50 123 4567',
      'initials': 'KD',
      'category': 'MIDFIELDERS',
      'color': Color(0xFF7C3AED)
    },
    {
      'name': 'LIONEL MESSI',
      'pos': 'RW',
      'location': 'TOWN SQUARE',
      'phone': '+971 50 123 4567',
      'initials': 'LM',
      'category': 'FORWARDS',
      'color': Color(0xFF9D174D)
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 30, 25, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('TEAM COMMANDER',
                      style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('SQUAD LIST',
                          style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                      _buildPlayerCountBadge('24 PLAYERS'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _buildAgeGroupFilters(),
          ),
          SliverToBoxAdapter(
            child: _buildLocationFilters(),
          ),
          SliverToBoxAdapter(
            child: _buildSearchBar(),
          ),
          ..._buildCategorizedList(),
          const SliverToBoxAdapter(child: SizedBox(height: 50)),
        ],
      ),
    );
  }

  Widget _buildPlayerCountBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          const Icon(Icons.groups_rounded, color: goldColor, size: 14),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }

  Widget _buildAgeGroupFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: _ageGroups.map((group) {
          bool isSelected = _selectedAgeGroup == group;
          return GestureDetector(
            onTap: () => setState(() => _selectedAgeGroup = group),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              decoration: BoxDecoration(
                color: isSelected ? goldColor : surfaceColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isSelected ? Colors.transparent : Colors.white.withOpacity(0.05)),
              ),
              child: Text(group,
                  style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white70, fontSize: 13, fontWeight: FontWeight.w900)),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLocationFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: _locations.map((loc) {
          bool isSelected = _selectedLocation == loc;
          return GestureDetector(
            onTap: () => setState(() => _selectedLocation = loc),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: isSelected ? goldColor : Colors.white12, width: 1.5),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on_rounded, color: isSelected ? goldColor : Colors.white24, size: 14),
                  const SizedBox(width: 8),
                  Text(loc,
                      style: TextStyle(
                          color: isSelected ? goldColor : Colors.white24, fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 10),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Search in $_selectedAgeGroup...',
          hintStyle: const TextStyle(color: Colors.white24),
          prefixIcon: const Icon(Icons.search, color: goldColor, size: 20),
          filled: true,
          fillColor: surfaceColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.white12)),
        ),
      ),
    );
  }

  List<Widget> _buildCategorizedList() {
    Map<String, List<Map<String, dynamic>>> categorized = {};
    for (var player in _squad) {
      categorized.putIfAbsent(player['category'], () => []).add(player);
    }

    List<Widget> sections = [];
    categorized.forEach((category, players) {
      sections.add(
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 35, 25, 15),
            child: Text(category,
                style: const TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
          ),
        ),
      );
      sections.add(
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildPlayerCard(players[index]),
              childCount: players.length,
            ),
          ),
        ),
      );
    });
    return sections;
  }

  Widget _buildPlayerCard(Map<String, dynamic> player) {
    return GestureDetector(
      onTap: () => _showPlayerOptions(player),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: player['color'],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.black.withOpacity(0.2),
              child: Text(player['initials'],
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(player['name'],
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(player['pos'], style: const TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.w900)),
                      const SizedBox(width: 10),
                      Text(player['location'], style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Parent Phone: ${player['phone']}', style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            _buildMiniActionIcon(),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniActionIcon() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(Icons.analytics_outlined, color: goldColor, size: 18),
    );
  }

  void _showPlayerOptions(Map<String, dynamic> player) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0D0D0D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(player['name'], style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 25),
            _buildOptionItem(Icons.auto_graph_rounded, 'View Progress & Records', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerPerformanceDetail(
                name: player['name'],
                pos: player['pos'],
                rating: 4.8,
              )));
            }),
            _buildOptionItem(Icons.star_outline_rounded, 'Rate Performance', () {
              Navigator.pop(context);
            }),
            _buildOptionItem(Icons.person_search_rounded, 'Full Player Profile', () {
              Navigator.pop(context);
            }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: goldColor),
      title: Text(label, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
      onTap: onTap,
    );
  }
}
