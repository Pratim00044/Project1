import 'package:flutter/material.dart';
import 'social_league_details.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);

class SocialLeaguesPage extends StatefulWidget {
  const SocialLeaguesPage({super.key});

  @override
  State<SocialLeaguesPage> createState() => _SocialLeaguesPageState();
}

class _SocialLeaguesPageState extends State<SocialLeaguesPage> {
  String _selectedFilter = 'ALL';
  DateTime _selectedDate = DateTime.now();

  final List<String> _filters = ['ALL', 'VETS', 'MIXED', 'MEN', 'LADIES'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('BACK', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.list_alt, color: greenAccent, size: 14),
                  const SizedBox(width: 8),
                  const Text('BOOKINGS', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: greenAccent, shape: BoxShape.circle),
                    child: const Text('3', style: TextStyle(color: Colors.black, fontSize: 9, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('SOCIAL LEAGUES', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: -1)),
                  const Text('Pick a league, find a game, and play.', style: TextStyle(color: Colors.white38, fontSize: 13, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 30),
                  const Text('PICK A DATE', style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
                  const SizedBox(height: 15),
                  _buildDatePicker(),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Text('TODAY', style: TextStyle(color: greenAccent, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1)),
                      const SizedBox(width: 8),
                      const Text('•', style: TextStyle(color: Colors.white24)),
                      const SizedBox(width: 8),
                      const Text('JULY 8', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      const Text('•', style: TextStyle(color: Colors.white24)),
                      const SizedBox(width: 8),
                      const Text('3 games', style: TextStyle(color: Colors.white38, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Divider(color: Colors.white10),
                  const SizedBox(height: 20),
                  const Text('FILTER BY', style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
                  const SizedBox(height: 15),
                  _buildFilterRow(),
                  const SizedBox(height: 30),
                  _buildLeagueSection('MIXED', 'Core FC', '45 AED', '7-A-SIDE • 1 FIXTURE', 'assets/images/match.png'),
                  const SizedBox(height: 30),
                  _buildLeagueSection('MEN', 'Dubai City Football Club', '55 AED', '5-A-SIDE • 2 FIXTURES', 'assets/images/login_background.jpeg'),
                  const SizedBox(height: 30),
                  _buildLeagueSection('MIXED', 'United Football Club', '40 AED', '8-A-SIDE • 1 FIXTURE', 'assets/images/match.png'),
                  const SizedBox(height: 30),
                  _buildLeagueSection('MEN', 'Eagle FC', '65 AED', '9-A-SIDE • 3 FIXTURES', 'assets/images/login_background.jpeg'),
                  const SizedBox(height: 30),
                  _buildLeagueSection('MEN', 'Emirates Club', '69 AED', '11-A-SIDE • 1 FIXTURE', 'assets/images/match.png'),
                  const SizedBox(height: 30),
                  _buildLeagueSection('MEN', 'Gulf united FC', '75 AED', '11-A-SIDE • 2 FIXTURES', 'assets/images/login_background.jpeg'),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    return SizedBox(
      height: 90,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: surfaceColor, shape: BoxShape.circle, border: Border.all(color: Colors.white10)),
            child: const Icon(Icons.chevron_left, color: Colors.white38, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                final date = DateTime.now().add(Duration(days: index));
                final isSelected = index == 0;
                return Container(
                  width: 75,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.transparent : surfaceColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: isSelected ? greenAccent : Colors.white.withValues(alpha: 0.05), width: 1.5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(index == 0 ? 'TODAY' : ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'][date.weekday - 1], 
                          style: TextStyle(color: isSelected ? greenAccent : Colors.white38, fontSize: 9, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 5),
                      Text(date.day.toString(), style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 2),
                      const Text('3', style: TextStyle(color: Colors.white24, fontSize: 9, fontWeight: FontWeight.bold)),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: greenAccent, shape: BoxShape.circle),
            child: const Icon(Icons.chevron_right, color: Colors.black, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _filters.map((f) {
                bool isSelected = _selectedFilter == f;
                return GestureDetector(
                  onTap: () => setState(() => _selectedFilter = f),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? greenAccent : surfaceColor,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: isSelected ? greenAccent : Colors.white10),
                    ),
                    child: Row(
                      children: [
                        if (f == 'ALL') ...[
                          Icon(Icons.grid_view_rounded, color: isSelected ? Colors.black : greenAccent, size: 14),
                          const SizedBox(width: 8),
                        ],
                        if (f == 'MIXED') ...[
                          Icon(Icons.transgender, color: isSelected ? Colors.black : Colors.purpleAccent, size: 14),
                          const SizedBox(width: 8),
                        ],
                        if (f == 'MEN') ...[
                          Icon(Icons.male, color: isSelected ? Colors.black : Colors.blueAccent, size: 14),
                          const SizedBox(width: 8),
                        ],
                        Text(f, style: TextStyle(color: isSelected ? Colors.black : Colors.white70, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeagueSection(String category, String title, String price, String fixtures, String img) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(category == 'MIXED' ? Icons.transgender : Icons.male, color: category == 'MIXED' ? Colors.purpleAccent : Colors.blueAccent, size: 16),
            const SizedBox(width: 10),
            Text(category, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1)),
            const SizedBox(width: 15),
            const Expanded(child: Divider(color: Colors.white10)),
          ],
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SocialLeagueDetailsPage(leagueName: title))),
          child: Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: AssetImage(img),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
                    ),
                  ),
                ),
                Positioned(
                  top: 15, left: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        Icon(category == 'MIXED' ? Icons.transgender : Icons.male, color: Colors.white, size: 10),
                        const SizedBox(width: 5),
                        Text(category, style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 15, right: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                    child: Text(price, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(color: greenAccent.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.calendar_today, color: greenAccent, size: 12),
                            const SizedBox(width: 8),
                            Text(fixtures, style: const TextStyle(color: greenAccent, fontSize: 10, fontWeight: FontWeight.w900)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20, right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), shape: BoxShape.circle),
                    child: const Icon(Icons.chevron_right, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
