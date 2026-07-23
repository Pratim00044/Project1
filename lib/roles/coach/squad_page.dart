import 'package:flutter/material.dart';
import '../organization/player_performance_detail.dart';
import '../organization/pitch_rating_view.dart';
import '../player/player_profile.dart';

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
      'location': 'TOWN SQUARE',
      'phone': '+971 50 123 4567',
      'initials': 'AB',
      'position': 'Goalkeeper',
      'color': Color(0xFF1E3A8A),
      'image': 'assets/images/sunil.png'
    },
    {
      'name': 'THIBAUT COURTOIS',
      'location': 'TOWN SQUARE',
      'phone': '+971 50 123 4567',
      'initials': 'TC',
      'position': 'Goalkeeper',
      'color': Color(0xFF3730A3),
      'image': 'assets/images/sunil.png'
    },
    {
      'name': 'VIRGIL VAN DIJK',
      'location': 'TOWN SQUARE',
      'phone': '+971 50 123 4567',
      'initials': 'VD',
      'position': 'Defense',
      'color': Color(0xFF5B21B6),
      'image': 'assets/images/sunil.png'
    },
    {
      'name': 'KEVIN DE BRUYNE',
      'location': 'TOWN SQUARE',
      'phone': '+971 50 123 4567',
      'initials': 'KD',
      'position': 'Midfield',
      'color': Color(0xFF7C3AED),
      'image': 'assets/images/sunil.png'
    },
    {
      'name': 'LIONEL MESSI',
      'location': 'TOWN SQUARE',
      'phone': '+971 50 123 4567',
      'initials': 'LM',
      'position': 'Attack',
      'color': Color(0xFF9D174D),
      'image': 'assets/images/sunil.png'
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
    final categories = {
      'Goalkeeper': 'GOALKEEPERS',
      'Defense': 'DEFENDERS',
      'Midfield': 'MIDFIELDERS',
      'Attack': 'ATTACKERS',
    };

    List<Widget> slivers = [];

    categories.forEach((key, label) {
      final categoryPlayers = _squad.where((p) => p['position'] == key).toList();
      if (categoryPlayers.isNotEmpty) {
        slivers.add(
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 35, 25, 15),
              child: Text(label,
                  style: const TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
            ),
          ),
        );
        slivers.add(
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildPlayerCard(categoryPlayers[index]),
                childCount: categoryPlayers.length,
              ),
            ),
          ),
        );
      }
    });

    return slivers;
  }

  Widget _buildPlayerCard(Map<String, dynamic> player) {
    return GestureDetector(
      onTap: () => _showPlayerOptions(player),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2E5B4F), Color(0xFF3B2A50)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.black.withOpacity(0.2),
              backgroundImage: player['image'] != null ? AssetImage(player['image']) : null,
              child: player['image'] == null 
                  ? Text(player['initials'], style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))
                  : null,
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
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.fromLTRB(25, 20, 25, 30),
        decoration: const BoxDecoration(
          color: Color(0xFF0D0D0D),
          borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 25),
              CircleAvatar(
                radius: 40,
                backgroundColor: goldColor.withOpacity(0.1),
                backgroundImage: player['image'] != null ? AssetImage(player['image']) : null,
                child: player['image'] == null ? Text(player['initials'], style: const TextStyle(color: goldColor, fontWeight: FontWeight.bold, fontSize: 24)) : null,
              ),
              const SizedBox(height: 15),
              Text(player['name'].toUpperCase(), 
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1)),
              const SizedBox(height: 30),
              _buildOptionItem(Icons.chat_bubble_outline_rounded, 'Give Player Feedback', () {
                Navigator.pop(context);
                _showFeedbackDialog(player['name']);
              }),
              _buildOptionItem(Icons.auto_graph_rounded, 'View Progress & Records', () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerPerformanceDetail(
                  name: player['name'],
                  rating: 4.8,
                )));
              }),
              _buildOptionItem(Icons.star_outline_rounded, 'Rate Performance', () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => PitchRatingView(
                  title: 'Training Session',
                  date: 'Jul 12',
                  time: '11:00 AM',
                )));
              }),
              _buildOptionItem(Icons.person_search_rounded, 'Full Player Profile', () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerProfile(
                  playerName: player['name'],
                  playerNumber: '10',
                  isReadOnly: true,
                  showBackButton: true,
                )));
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionItem(IconData icon, String title, VoidCallback onTap) {
    bool isProgress = title == 'View Progress & Records';
    bool isFeedback = title == 'Give Player Feedback';
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: (isProgress || isFeedback) ? Colors.white.withOpacity(0.03) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(icon, color: goldColor, size: 24),
            const SizedBox(width: 20),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  void _showFeedbackDialog(String playerName) {
    final TextEditingController feedbackController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: const BoxDecoration(
            color: Color(0xFF161616),
            borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 25),
              Text('GIVE FEEDBACK', style: TextStyle(color: goldColor, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 2)),
              const SizedBox(height: 8),
              Text('Evaluation for $playerName', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 25),
              TextField(
                controller: feedbackController,
                maxLines: 5,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Write your notes about performance, attitude, or technical skills...',
                  hintStyle: const TextStyle(color: Colors.white24, fontSize: 13),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.03),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.all(20),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (feedbackController.text.trim().isNotEmpty) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Feedback saved for $playerName'),
                        backgroundColor: greenAccent,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: goldColor,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text('SUBMIT FEEDBACK', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, letterSpacing: 1)),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
