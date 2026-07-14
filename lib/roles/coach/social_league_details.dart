import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);

class SocialLeagueDetailsPage extends StatefulWidget {
  final String leagueName;
  const SocialLeagueDetailsPage({super.key, required this.leagueName});

  @override
  State<SocialLeagueDetailsPage> createState() => _SocialLeagueDetailsPageState();
}

class _SocialLeagueDetailsPageState extends State<SocialLeagueDetailsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.leagueName.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1)),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: greenAccent,
          labelColor: greenAccent,
          unselectedLabelColor: Colors.white38,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1),
          tabs: const [
            Tab(text: 'TABLE'),
            Tab(text: 'FIXTURES'),
            Tab(text: 'STATS'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTableTab(),
          _buildFixturesTab(),
          _buildStatsTab(),
        ],
      ),
    );
  }

  Widget _buildTableTab() {
    final teams = [
      {'pos': '1', 'name': 'Core FC', 'p': '8', 'w': '6', 'd': '0', 'l': '2', 'gd': '+9', 'pts': '18'},
      {'pos': '2', 'name': 'Dubai City Football Club', 'p': '7', 'w': '5', 'd': '1', 'l': '1', 'gd': '+13', 'pts': '16'},
      {'pos': '3', 'name': 'United Football Club', 'p': '8', 'w': '3', 'd': '2', 'l': '3', 'gd': '+1', 'pts': '11'},
      {'pos': '4', 'name': 'Eagle FC', 'p': '5', 'w': '3', 'd': '1', 'l': '1', 'gd': '+8', 'pts': '10'},
      {'pos': '5', 'name': 'Emirates Club', 'p': '6', 'w': '2', 'd': '3', 'l': '1', 'gd': '+6', 'pts': '9'},
      {'pos': '6', 'name': 'Gulf united FC', 'p': '5', 'w': '2', 'd': '1', 'l': '2', 'gd': '+1', 'pts': '7'},
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildTableHeader(),
        const Divider(color: Colors.white10),
        ...teams.map((t) => _buildTeamRow(t)).toList(),
      ],
    );
  }

  Widget _buildTableHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          SizedBox(width: 30, child: Text('POS', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold))),
          Expanded(child: Text('TEAM', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold))),
          SizedBox(width: 25, child: Text('P', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
          SizedBox(width: 25, child: Text('W', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
          SizedBox(width: 25, child: Text('D', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
          SizedBox(width: 25, child: Text('L', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
          SizedBox(width: 35, child: Text('GD', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
          SizedBox(width: 35, child: Text('PTS', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
        ],
      ),
    );
  }

  Widget _buildTeamRow(Map<String, String> t) {
    bool isSelected = t['pos'] == '3';
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: isSelected ? greenAccent.withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SizedBox(width: 30, child: Text(t['pos']!, style: TextStyle(color: isSelected ? greenAccent : Colors.white, fontWeight: FontWeight.bold))),
          Expanded(
            child: Row(
              children: [
                CircleAvatar(radius: 10, backgroundColor: Colors.white10, child: Text(t['name']![0], style: const TextStyle(fontSize: 8))),
                const SizedBox(width: 10),
                Expanded(child: Text(t['name']!, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),
          SizedBox(width: 25, child: Text(t['p']!, style: const TextStyle(color: Colors.white70, fontSize: 11), textAlign: TextAlign.center)),
          SizedBox(width: 25, child: Text(t['w']!, style: const TextStyle(color: Colors.white70, fontSize: 11), textAlign: TextAlign.center)),
          SizedBox(width: 25, child: Text(t['d']!, style: const TextStyle(color: Colors.white70, fontSize: 11), textAlign: TextAlign.center)),
          SizedBox(width: 25, child: Text(t['l']!, style: const TextStyle(color: Colors.white70, fontSize: 11), textAlign: TextAlign.center)),
          SizedBox(width: 35, child: Text(t['gd']!, style: TextStyle(color: t['gd']!.startsWith('+') ? Colors.blueAccent : Colors.redAccent, fontSize: 11, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
          SizedBox(width: 35, child: Text(t['pts']!, style: TextStyle(color: isSelected ? greenAccent : Colors.white, fontSize: 13, fontWeight: FontWeight.w900), textAlign: TextAlign.center)),
        ],
      ),
    );
  }

  Widget _buildFixturesTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle('UPCOMING FIXTURES'),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  _buildSmallToggle('WEEK', true),
                  _buildSmallToggle('DAY', false),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        _buildWeekSelector(),
        const SizedBox(height: 35),
        _buildSectionTitle('SAT Feb 1st'),
        const SizedBox(height: 15),
        _buildFixtureCard('United Football Club', 'Dubai City Football Club', 'Sat, Feb 1', '7:00 PM', 'Zayed Sports City', matchday: 'MATCHDAY 7'),
        _buildFixtureCard('Eagle FC', 'Core FC', 'Sat, Feb 1', '9:00 PM', 'Dubai Sports World', matchday: 'MATCHDAY 7'),
        const SizedBox(height: 40),
        _buildSectionTitle('RECENT RESULTS'),
        const SizedBox(height: 15),
        _buildSectionTitle('SAT Jan 18th'),
        const SizedBox(height: 15),
        _buildResultCard('Core FC', 'United Football Club', '3 - 1', 'SAT JAN 18th', matchday: 'MATCHDAY 6'),
      ],
    );
  }

  Widget _buildSmallToggle(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? greenAccent : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label, style: TextStyle(color: isActive ? Colors.black : Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildWeekSelector() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.chevron_left, color: Colors.white24),
          Column(
            children: [
              const Text('THIS WEEK', style: TextStyle(color: greenAccent, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
              const SizedBox(height: 5),
              const Text('Jan 27-Feb 2', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
              const SizedBox(height: 2),
              const Text('2 games • 1/6', style: TextStyle(color: Colors.white38, fontSize: 11)),
            ],
          ),
          Stack(
            children: [
              const Icon(Icons.chevron_right, color: Colors.white),
              Positioned(
                top: 0, right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: greenAccent, shape: BoxShape.circle),
                  child: const Text('2', style: TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(width: 3, height: 12, color: greenAccent),
        const SizedBox(width: 10),
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1)),
      ],
    );
  }

  Widget _buildFixtureCard(String t1, String t2, String date, String time, String venue, {String? matchday}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (matchday != null) Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, color: Colors.white24, size: 12),
                  const SizedBox(width: 8),
                  Text(matchday, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: greenAccent.withOpacity(0.1), borderRadius: BorderRadius.circular(5)),
                child: const Text('UPCOMING', style: TextStyle(color: greenAccent, fontSize: 8, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _buildTeamFixture(t1)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(8)),
                child: const Text('VS', style: TextStyle(color: greenAccent, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
              Expanded(child: _buildTeamFixture(t2, alignRight: true)),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFixtureMeta(Icons.calendar_today, date),
                _buildFixtureMeta(Icons.access_time, time),
                _buildFixtureMeta(Icons.location_on_outlined, venue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamFixture(String name, {bool alignRight = false}) {
    return Column(
      crossAxisAlignment: alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 20, backgroundColor: Colors.white.withOpacity(0.05), child: Text(name[0])),
        const SizedBox(height: 10),
        Text(name, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold), textAlign: alignRight ? TextAlign.right : TextAlign.left),
      ],
    );
  }

  Widget _buildFixtureMeta(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white24, size: 12),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildResultCard(String t1, String t2, String score, String date, {String? matchday}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (matchday != null) Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, color: Colors.white24, size: 12),
                  const SizedBox(width: 8),
                  Text(matchday, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
              const Text('FULL TIME', style: TextStyle(color: Colors.white38, fontSize: 8, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildTeamFixture(t1)),
              Text(score.split(' - ')[0], style: const TextStyle(color: greenAccent, fontSize: 24, fontWeight: FontWeight.w900)),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('-', style: TextStyle(color: Colors.white24, fontSize: 24)),
              ),
              Text(score.split(' - ')[1], style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
              Expanded(child: _buildTeamFixture(t2, alignRight: true)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsTab() {
    final stats = [
      {'rank': '1', 'name': 'Sunil Chhetri', 'team': 'Core FC', 'val': '8', 'color': goldColor},
      {'rank': '2', 'name': 'Sahal Abdul Samad', 'team': 'Dubai City Football Club', 'val': '7', 'color': const Color(0xFFC0C0C0)},
      {'rank': '3', 'name': 'L. Chhangte', 'team': 'United Football Club', 'val': '6', 'color': Colors.orangeAccent},
      {'rank': '4', 'name': 'Sandesh Jhingan', 'team': 'Eagle FC', 'val': '5', 'color': Colors.white10},
      {'rank': '5', 'name': 'Liston Colaco', 'team': 'Emirates Club', 'val': '5', 'color': Colors.white10},
      {'rank': '6', 'name': 'Anirudh Thapa', 'team': 'Gulf united FC', 'val': '4', 'color': Colors.white10},
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildStatsFilter(),
        const SizedBox(height: 25),
        _buildTableHeaderStats(),
        const Divider(color: Colors.white10),
        ...stats.map((s) => _buildStatRow(s)).toList(),
      ],
    );
  }

  Widget _buildStatsFilter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStatTypeBtn(Icons.sports_soccer, 'GOALS', true),
        const SizedBox(width: 15),
        _buildStatTypeBtn(Icons.square, 'YELLOWS', false),
        const SizedBox(width: 15),
        _buildStatTypeBtn(Icons.square, 'REDS', false, color: Colors.redAccent),
      ],
    );
  }

  Widget _buildStatTypeBtn(IconData icon, String label, bool isActive, {Color color = Colors.yellowAccent}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? greenAccent : surfaceColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: isActive ? Colors.black : color.withValues(alpha: 0.5), size: 14),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: isActive ? Colors.black : Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTableHeaderStats() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Expanded(child: Text('PLAYER', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold))),
          Text('GOALS', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildStatRow(Map<String, dynamic> s) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: CircleAvatar(radius: 10, backgroundColor: s['color'], child: Text(s['rank']!, style: const TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.bold))),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s['name']!, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                Text(s['team']!, style: const TextStyle(color: Colors.white24, fontSize: 11)),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(Icons.sports_soccer, color: Colors.white24, size: 12),
              const SizedBox(width: 8),
              Text(s['val']!, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900)),
            ],
          ),
        ],
      ),
    );
  }
}
