import 'package:flutter/material.dart';
import 'player_detail_page.dart';

const Color goldColor = Color(0xFFD4AF37);

class SquadPage extends StatefulWidget {
  const SquadPage({super.key});

  @override
  State<SquadPage> createState() => _SquadPageState();
}

class _SquadPageState extends State<SquadPage> {
  String _selectedTeam = 'CORE FC';
  final List<String> _myTeams = ['CORE FC', 'Dubai FC', 'City Football', 'AFC'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    const Text('SQUAD LIST',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1)),
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

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              children: [
                _buildSquadCategory('GOALKEEPERS'),
                _buildPlayerCard(context, 'Gurpreet Singh', 'GK', '1', 'assets/images/sunil.png'),
                _buildPlayerCard(context, 'Amrinder Singh', 'GK', '23', 'assets/images/sunil.png'),
                const SizedBox(height: 25),
                _buildSquadCategory('DEFENSE'),
                _buildPlayerCard(context, 'Sandesh Jhingan', 'CB', '5', 'assets/images/sunil.png'),
                _buildPlayerCard(context, 'Pritam Kotal', 'RB', '2', 'assets/images/sunil.png'),
                _buildPlayerCard(context, 'Subhasish Bose', 'LB', '3', 'assets/images/sunil.png'),
                const SizedBox(height: 25),
                _buildSquadCategory('MIDFIELD'),
                _buildPlayerCard(context, 'Sahal Abdul Samad', 'CAM', '10', 'assets/images/sunil.png'),
                _buildPlayerCard(context, 'Anirudh Thapa', 'CM', '7', 'assets/images/sunil.png'),
                const SizedBox(height: 25),
                _buildSquadCategory('ATTACK'),
                _buildPlayerCard(context, 'Sunil Chhetri', 'ST', '11', 'assets/images/sunil.png'),
                _buildPlayerCard(context, 'L. Chhangte', 'RW', '17', 'assets/images/sunil.png'),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerCountBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: goldColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: goldColor.withOpacity(0.2)),
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
          color: isSelected ? goldColor : const Color(0xFF121212),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: isSelected ? goldColor : Colors.white.withOpacity(0.05)),
          boxShadow: isSelected ? [BoxShadow(color: goldColor.withOpacity(0.2), blurRadius: 10)] : null,
        ),
        child: Text(
          team,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white38,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
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

  Widget _buildPlayerCard(BuildContext context, String name, String position, String number, String imagePath) {
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
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.03)),
        ),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
                  border: Border.all(color: goldColor.withOpacity(0.1))),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                        child: Text(position, style: const TextStyle(color: goldColor, fontSize: 9, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 8),
                      Text('Squad No: $number', style: const TextStyle(color: Colors.white24, fontSize: 10)),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.03), shape: BoxShape.circle),
              child: const Icon(Icons.analytics_outlined, color: goldColor, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}
