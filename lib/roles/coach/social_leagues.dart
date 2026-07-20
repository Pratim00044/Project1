import 'package:flutter/material.dart';
import 'social_league_details.dart';
import '../organization/league_builder_page.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);

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

class SocialLeaguesPage extends StatefulWidget {
  const SocialLeaguesPage({super.key});

  @override
  State<SocialLeaguesPage> createState() => _SocialLeaguesPageState();
}

class _SocialLeaguesPageState extends State<SocialLeaguesPage> {
  String _selectedFilter = 'ALL';
  DateTime _selectedDate = DateTime.parse('2024-06-10');
  final ScrollController _dateScrollController = ScrollController();

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
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LeagueBuilderPage(isCoach: true))),
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF2E5B4F), Color(0xFF3B2A50)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
                            child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
                          ),
                          const SizedBox(width: 20),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('CREATE LEAGUE', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1)),
                                Text('Start your own custom competition', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white38, size: 18),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text('PICK A DATE', style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
                  const SizedBox(height: 15),
                  _buildDatePicker(),
                  const SizedBox(height: 20),
                  _buildDateSummary(),
                  const SizedBox(height: 30),
                  const Divider(color: Colors.white10),
                  const SizedBox(height: 20),
                  const Text('FILTER BY', style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
                  const SizedBox(height: 15),
                  _buildFilterRow(),
                  const SizedBox(height: 30),
                  _buildLeagueSection('MIXED', 'Core FC', '45 AED', '7-A-SIDE • 1 FIXTURE', [Color(0xFF2E5B4F), Color(0xFF3B2A50)]),
                  const SizedBox(height: 30),
                  _buildLeagueSection('MEN', 'Dubai City Football Club', '55 AED', '5-A-SIDE • 2 FIXTURES', [Color(0xFF1E3A8A), Color(0xFF312E81)]),
                  const SizedBox(height: 30),
                  _buildLeagueSection('MIXED', 'United Football Club', '40 AED', '8-A-SIDE • 1 FIXTURE', [Color(0xFF064E3B), Color(0xFF14532D)]),
                  const SizedBox(height: 30),
                  _buildLeagueSection('MEN', 'Eagle FC', '65 AED', '9-A-SIDE • 3 FIXTURES', [Color(0xFF334155), Color(0xFF1E293B)]),
                  const SizedBox(height: 30),
                  _buildLeagueSection('MEN', 'Emirates Club', '69 AED', '11-A-SIDE • 1 FIXTURE', [Color(0xFF4C1D95), Color(0xFF2E1065)]),
                  const SizedBox(height: 30),
                  _buildLeagueSection('MEN', 'Gulf united FC', '75 AED', '11-A-SIDE • 2 FIXTURES', [Color(0xFF831843), Color(0xFF701A75)]),
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
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ListView.builder(
              controller: _dateScrollController,
              scrollDirection: Axis.horizontal,
              itemCount: 14,
              itemBuilder: (context, index) {
                DateTime date = DateTime.parse('2024-06-10').add(Duration(days: index));
                bool isSelected = date.day == _selectedDate.day;
                String label = index == 0 ? 'TODAY' : ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'][date.weekday - 1];
                
                return GestureDetector(
                  onTap: () => setState(() => _selectedDate = date),
                  child: Container(
                    width: 75,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.transparent : const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? greenAccent : Colors.transparent, 
                        width: 2
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(label,
                          style: TextStyle(
                            color: isSelected ? greenAccent : Colors.white24, 
                            fontSize: 9, 
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5
                          )),
                        const SizedBox(height: 5),
                        Text(date.day.toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 5),
                        Text(['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'][date.month - 1],
                          style: TextStyle(
                            color: isSelected ? greenAccent : Colors.white24, 
                            fontSize: 9, 
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5
                          )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            child: GestureDetector(
              onTap: () {
                _dateScrollController.animateTo(
                  (_dateScrollController.offset - 87).clamp(0, _dateScrollController.position.maxScrollExtent),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2E5B4F), Color(0xFF3B2A50)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                ),
                child: const Icon(Icons.chevron_left, color: Colors.white, size: 18),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: () {
                _dateScrollController.animateTo(
                  (_dateScrollController.offset + 87).clamp(0, _dateScrollController.position.maxScrollExtent),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2E5B4F), Color(0xFF3B2A50)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.chevron_right, color: Colors.white, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSummary() {
    String dayName = _selectedDate.day == 10 ? 'TODAY' : ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'][_selectedDate.weekday - 1];
    String monthName = ['JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'][_selectedDate.month - 1];
    
    return Row(
      children: [
        Text(dayName, style: const TextStyle(color: greenAccent, fontSize: 14, fontWeight: FontWeight.w900)),
        const SizedBox(width: 8),
        const Text('•', style: TextStyle(color: Colors.white12)),
        const SizedBox(width: 8),
        Text('$monthName ${_selectedDate.day}', style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w900)),
        const SizedBox(width: 8),
        const Text('•', style: TextStyle(color: Colors.white12)),
        const SizedBox(width: 8),
        const Text('3 games', style: TextStyle(color: Colors.white24, fontSize: 14, fontWeight: FontWeight.bold)),
      ],
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

  Widget _buildLeagueSection(String category, String title, String price, String fixtures, List<Color> gradient) {
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
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: gradient,
              ),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 8))
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -20,
                  top: -20,
                  child: Icon(Icons.emoji_events_rounded, size: 150, color: Colors.white.withValues(alpha: 0.1)),
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
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900, height: 1.1)),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.sports_soccer_rounded, color: Colors.white, size: 14),
                            const SizedBox(width: 8),
                            Text(fixtures, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 25, right: 25,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: Icon(Icons.arrow_forward_ios_rounded, color: gradient[0], size: 18),
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
