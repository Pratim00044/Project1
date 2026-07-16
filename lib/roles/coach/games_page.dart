import 'package:flutter/material.dart';
import 'create_training_page.dart';
import 'create_game_page.dart';
import 'player_detail_page.dart';
import '../organization/social_leagues_page.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

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

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> with SingleTickerProviderStateMixin {
  late TabController _tab;
  DateTime _selectedDate = DateTime.parse('2024-07-12');
  final ScrollController _dateScrollController = ScrollController();

  final Map<String, Map<String, List<Map<String, dynamic>>>> _scheduleData = {
    '2024-07-12': {
      'sessions': [
        {'title': 'Under 8s Training', 'time': '09:00 AM', 'pitch': 'Pitch 1', 'status': 'Open', 'type': 'SESSION'},
        {'title': 'Under 12s Training', 'time': '11:00 AM', 'pitch': 'Pitch 3', 'status': 'Open', 'type': 'SESSION'},
      ],
      'matches': [
        {'teams': 'CORE FC vs EAGLES', 'time': '04:00 PM', 'venue': 'Main Pitch', 'league': 'League Match', 'type': 'MATCH'},
      ]
    },
    '2024-07-13': {
      'sessions': [
        {'title': 'Under 10s Skills', 'time': '04:00 PM', 'pitch': 'Pitch 2', 'status': 'Open', 'type': 'SESSION'},
      ],
      'matches': []
    },
  };

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    _dateScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: const Text('MANAGEMENT',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2)),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              TabBar(
                controller: _tab,
                indicatorColor: goldColor,
                labelColor: goldColor,
                unselectedLabelColor: Colors.white24,
                indicatorSize: TabBarIndicatorSize.label,
                dividerColor: Colors.transparent,
                tabs: const [Tab(text: 'GAMES'), Tab(text: 'LEAGUES')],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tab,
          children: [
            _buildGamesTab(),
            _buildLeaguesTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildGamesTab() {
    String dateKey = "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";
    var dailySchedule = _scheduleData[dateKey] ?? {'sessions': [], 'matches': []};
    List sessions = dailySchedule['sessions']!;
    List matches = dailySchedule['matches']!;

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      children: [
        _buildSectionTitle('PAST GAMES / MATCHES'),
        const SizedBox(height: 15),
        _buildPastGameItem('Under 12s vs City FC', 'Jul 10 • 2 - 1 Win', 0),
        _buildPastGameItem('Shooting Session', 'Jul 08 • Completed', 1),
        
        const SizedBox(height: 30),
        _buildCreateNewButton(),
        
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _buildDateWheels(),
        ),
        
        const SizedBox(height: 20),
        _buildSectionTitle("DETAILS — JUL ${_selectedDate.day}"),
        const SizedBox(height: 10),
        
        if (sessions.isEmpty && matches.isEmpty)
          const Padding(
            padding: EdgeInsets.all(40),
            child: Center(
              child: Text('NO ACTIVITIES FOR THIS DATE', 
                style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ),

        ...sessions.map((s) => _buildActivityTile(s, Colors.greenAccent)),
        ...matches.map((m) => _buildActivityTile(m, const Color(0xFF007CFE))),
        
        const SizedBox(height: 50),
      ],
    );
  }

  Widget _buildLeaguesTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SocialLeaguesPage())),
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
        const SizedBox(height: 35),
        _buildSectionTitle('ACTIVE LEAGUES'),
        const SizedBox(height: 15),
        _buildLeagueItem('Champions League', 'Europe • 32 Teams', 'IN PROGRESS', 2),
        _buildLeagueItem('Premier League', 'England • 20 Teams', 'OPEN', 3),
        _buildLeagueItem('La Liga', 'Spain • 20 Teams', 'UPCOMING', 4),
      ],
    );
  }

  Widget _buildSectionTitle(String t) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Text(t,
        style: const TextStyle(
            color: Colors.white38,
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 2)),
  );

  Widget _buildCreateNewButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () => _showCreateOptions(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2E5B4F), Color(0xFF3B2A50)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: const Color(0xFF2E5B4F).withOpacity(0.2), blurRadius: 15, offset: const Offset(0, 8))],
          ),
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_circle_outline_rounded, color: Colors.white, size: 20),
                SizedBox(width: 10),
                Text('CREATE NEW', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 15, letterSpacing: 1)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCreateOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0D0D0D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('WHAT DO YOU WANT TO CREATE?', style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
            const SizedBox(height: 25),
            _buildOptionItem(Icons.fitness_center_rounded, 'Schedule Session', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateTrainingPage()));
            }),
            _buildOptionItem(Icons.sports_soccer_rounded, 'Create Match', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateGamePage()));
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

  Widget _buildPastGameItem(String title, String subtitle, int index) {
    final List<List<Color>> pastGradients = [
      [Color(0xFF1E3A8A), Color(0xFF312E81)],
      [Color(0xFF064E3B), Color(0xFF14532D)],
      [Color(0xFF334155), Color(0xFF1E293B)],
    ];
    final gradient = pastGradients[index % pastGradients.length];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.black.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.history, color: Colors.white, size: 20)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
              Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 11)),
            ]),
          ),
          const Icon(Icons.chevron_right, color: Colors.white54, size: 20),
        ],
      ),
    );
  }

  Widget _buildLeagueItem(String title, String subtitle, String status, int index) {
    final List<List<Color>> leagueGradients = [
      [Color(0xFF1E3A8A), Color(0xFF312E81)],
      [Color(0xFF064E3B), Color(0xFF14532D)],
      [Color(0xFF334155), Color(0xFF1E293B)],
      [Color(0xFF4C1D95), Color(0xFF2E1065)],
    ];
    final gradient = leagueGradients[index % leagueGradients.length];

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(status, style: const TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1)),
              const SizedBox(height: 4),
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 11)),
            ]),
          ),
          const Icon(Icons.emoji_events_outlined, color: Colors.white24, size: 24),
        ],
      ),
    );
  }

  Widget _buildActivityTile(Map<String, dynamic> data, Color color) {
    bool isMatch = data['type'] == 'MATCH';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E5B4F), Color(0xFF3B2A50)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(isMatch ? Icons.sports_soccer_rounded : Icons.fitness_center_rounded, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(isMatch ? data['teams'] : data['title'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
              Text('${data['time']} • ${isMatch ? data['venue'] : data['pitch']}', style: const TextStyle(color: Colors.white70, fontSize: 11)),
            ]),
          ),
          Row(
            children: [
              _buildIconButton(Icons.edit_outlined, Colors.white, () {}),
              _buildIconButton(Icons.delete_outline_rounded, Colors.white70, () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, Color color, VoidCallback onTap) {
    return IconButton(
      icon: Icon(icon, color: color.withOpacity(0.7), size: 18),
      onPressed: onTap,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 35, minHeight: 35),
    );
  }

  Widget _buildDateWheels() {
    return Row(
      children: [
        _buildCircleArrow(Icons.chevron_left, () {
          _dateScrollController.animateTo((_dateScrollController.offset - 85).clamp(0, _dateScrollController.position.maxScrollExtent), duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
        }),
        const SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            height: 100,
            child: ListView.builder(
              controller: _dateScrollController,
              scrollDirection: Axis.horizontal,
              itemCount: 14,
              itemBuilder: (context, index) {
                DateTime date = DateTime.parse('2024-07-12').add(Duration(days: index));
                bool isSelected = date.day == _selectedDate.day;
                String label = index == 0 ? 'TODAY' : ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'][date.weekday - 1];
                return GestureDetector(
                  onTap: () => setState(() => _selectedDate = date),
                  child: Container(
                    width: 75,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.transparent : surfaceColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: isSelected ? goldColor : Colors.white.withOpacity(0.05), width: 1.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(label, style: TextStyle(color: isSelected ? goldColor : Colors.white24, fontSize: 9, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 5),
                        Text(date.day.toString(), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 5),
                        Text(['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'][date.month - 1],
                          style: TextStyle(
                            color: isSelected ? goldColor : Colors.white24, 
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
        ),
        const SizedBox(width: 10),
        _buildCircleArrow(Icons.chevron_right, () {
          _dateScrollController.animateTo((_dateScrollController.offset + 85).clamp(0, _dateScrollController.position.maxScrollExtent), duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
        }),
      ],
    );
  }

  Widget _buildCircleArrow(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
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
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);
  final TabBar _tabBar;
  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Colors.black, child: _tabBar);
  }
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}
