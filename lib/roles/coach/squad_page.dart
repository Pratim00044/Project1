import 'package:flutter/material.dart';
import 'player_detail_page.dart';

const Color goldColor = Color(0xFFD4AF37);
const List<Color> cardColors = [
  Color(0xFF1E3A8A),
  Color(0xFF3730A3),
  Color(0xFF5B21B6),
  Color(0xFF7C3AED),
  Color(0xFF9D174D),
  Color(0xFF991B1B),
  Color(0xFF92400E),
  Color(0xFF065F46),
];

class SquadPage extends StatefulWidget {
  const SquadPage({super.key});

  @override
  State<SquadPage> createState() => _SquadPageState();
}

class _SquadPageState extends State<SquadPage> {
  String _selectedTeam = 'Under 8s';
  String _selectedLocation = 'Town Square';
  final List<String> _myTeams = ['Under 8s', 'Under 10s', 'Under 18'];
  final List<String> _locations = ['Town Square', 'Sports City', 'Jumeirah'];

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 25, 25, 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('TEAM COMMANDER',
                    style: TextStyle(
                        color: goldColor,
                        fontSize: 10,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w900)),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text('SQUAD LIST',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1)),
                    ),
                    _buildPlayerCountBadge(),
                  ],
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _myTeams.map((team) => _buildTeamChip(team)).toList(),
                  ),
                ),
                const SizedBox(height: 15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _locations.map((loc) => _buildLocationChip(loc)).toList(),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search in $_selectedTeam...',
                hintStyle: const TextStyle(color: Colors.white24, fontSize: 13),
                prefixIcon: const Icon(Icons.search, color: goldColor, size: 20),
                filled: true,
                fillColor: const Color(0xFF121212),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                children: [
                  _buildSquadCategory('GOALKEEPERS'),
                  _buildPlayerCard(context, 0, 'ALISSON BECKER', 'GK', '1', cardColors[0]),
                  _buildPlayerCard(context, 1, 'THIBAUT COURTOIS', 'GK', '23', cardColors[1]),
                  const SizedBox(height: 25),
                  _buildSquadCategory('DEFENSE'),
                  _buildPlayerCard(context, 2, 'RUBEN DIAS', 'CB', '3', cardColors[2]),
                  _buildPlayerCard(context, 3, 'KYLE WALKER', 'RB', '2', cardColors[3]),
                  _buildPlayerCard(context, 4, 'THEO HERNANDEZ', 'LB', '19', cardColors[4]),
                  _buildPlayerCard(context, 5, 'VIRGIL VAN DIJK', 'CB', '04', cardColors[5]),
                  const SizedBox(height: 25),
                  _buildSquadCategory('MIDFIELD'),
                  _buildPlayerCard(context, 6, 'KEVIN DE BRUYNE', 'CAM', '17', cardColors[6]),
                  _buildPlayerCard(context, 7, 'JUDE BELLINGHAM', 'CM', '05', cardColors[7]),
                  _buildPlayerCard(context, 8, 'LUKA MODRIC', 'CM', '10', cardColors[0]),
                  const SizedBox(height: 25),
                  _buildSquadCategory('ATTACK'),
                  _buildPlayerCard(context, 9, 'ERLING HAALAND', 'ST', '09', cardColors[1]),
                  _buildPlayerCard(context, 10, 'KYLIAN MBAPPE', 'ST', '07', cardColors[2]),
                  _buildPlayerCard(context, 11, 'CRISTIANO RONALDO', 'ST', '07', cardColors[3]),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        );
    }
  
    Widget _buildPlayerCountBadge() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: goldColor.withOpacity(0.2)),
          image: const DecorationImage(
            image: AssetImage('assets/images/img1.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
          ),
        ),
        child: const Row(
          children: [
            Icon(Icons.people_outline, color: goldColor, size: 14),
            SizedBox(width: 6),
            Text('24 PLAYERS',
                style: TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.w900)),
          ],
        ),
      );
    }
  
    Widget _buildTeamChip(String team) {
      bool isSelected = _selectedTeam == team;
      return GestureDetector(
        onTap: () => setState(() => _selectedTeam = team),
        child: Container(
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: isSelected ? goldColor : Colors.white.withOpacity(0.05)),
            image: !isSelected ? const DecorationImage(
              image: AssetImage('assets/images/img2.jpeg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
            ) : null,
            color: isSelected ? goldColor : null,
            boxShadow: isSelected ? [BoxShadow(color: goldColor.withOpacity(0.2), blurRadius: 10)] : null,
          ),
          child: Text(
            team,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  
    Widget _buildLocationChip(String loc) {
      bool isSelected = _selectedLocation == loc;
      return GestureDetector(
        onTap: () => setState(() => _selectedLocation = loc),
        child: Container(
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? goldColor.withOpacity(0.5) : Colors.white10),
          ),
          child: Row(
            children: [
              Icon(Icons.location_on_outlined, color: isSelected ? goldColor : Colors.white24, size: 12),
              const SizedBox(width: 6),
              Text(
                loc,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white24,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }
  
    Widget _buildSquadCategory(String title) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          children: [
            Text(title,
                style: const TextStyle(
                    color: goldColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5)),
            const SizedBox(width: 15),
            const Expanded(child: Divider(color: Colors.white10, thickness: 0.5)),
          ],
        ),
      );
    }
  
    Widget _buildPlayerCard(BuildContext context, int index, String name, String position, String number, Color color) {
      final List<String> tileImages = [
        'assets/images/img1.jpeg',
        'assets/images/img2.jpeg',
        'assets/images/img3.jpeg',
        'assets/images/img4.jpeg',
      ];
      String currentImage = tileImages[index % tileImages.length];
  
      return GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayerDetailPage(
              playerName: name,
              playerNumber: number,
              position: position,
            ),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            image: DecorationImage(
              image: AssetImage(currentImage),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 4))
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black.withValues(alpha: 0.8),
                  Colors.black.withValues(alpha: 0.3),
                ],
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/sunil.png'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: Colors.white.withOpacity(0.1))),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, shadows: [Shadow(color: Colors.black, blurRadius: 4)])),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(color: goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                            child: Text(position, style: const TextStyle(color: goldColor, fontSize: 9, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 8),
                          const Text('TOWN SQUARE', style: TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.bold, shadows: [Shadow(color: Colors.black, blurRadius: 4)])),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text('Parent Phone: +971 50 123 4567', style: TextStyle(color: Colors.white60, fontSize: 10, shadows: [Shadow(color: Colors.black, blurRadius: 4)])),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.analytics_outlined, color: goldColor, size: 18),
                ),
              ],
            ),
          ),
        ),
      );
    }
}
