import 'package:flutter/material.dart';
import 'teammate_profile.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class PlayerGamesPage extends StatelessWidget {
  const PlayerGamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(25, 20, 25, 15),
              child: Row(
                children: [
                  Icon(Icons.history, color: goldColor, size: 14),
                  SizedBox(width: 8),
                  Text('LAST GAME', style: TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () => _showMatchDetails(context, 'CORE FC', 'EAST BENGAL', isLive: true),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.redAccent.withValues(alpha: 0.2)),
                ),
                child: Column(
                  children: [
                    const Text('ISL - WEEK 12', style: TextStyle(color: Colors.white24, fontSize: 9, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMatchTeam('CORE FC', true),
                        const Column(
                          children: [
                            Text('2 - 1', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                            Text('78\'', style: TextStyle(color: Colors.redAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        _buildMatchTeam('EAST BENGAL', false),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.sports_soccer, color: goldColor, size: 12),
                        SizedBox(width: 6),
                        Text('Sunil Chhetri (45\'), Manvir Singh (62\')', style: TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text('East Bengal: Cleiton Silva (30\')', style: TextStyle(color: Colors.white38, fontSize: 10)),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(25, 40, 25, 15),
              child: Text('UPCOMING GAMES', style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildUpcomingGameTile(context, 'DUBAI CUP', 'FEB 15', 'REGISTERED', 'assets/images/login_background.jpeg'),
                const SizedBox(height: 12),
                _buildUpcomingGameTile(context, 'ALL STARS MATCH', 'FEB 20', 'OPEN', 'assets/images/login_background.jpeg'),
              ]),
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(25, 40, 25, 15),
              child: Text('DISCOVER MATCHES', style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildUpcomingGameTile(context, 'COMMUNITY SHIELD', 'MAR 05', 'NOT INTERESTED', 'assets/images/login_background.jpeg', isGray: true),
              ]),
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(25, 40, 25, 15),
              child: Text('PAST MATCHES', style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final games = [
                    {'opp': 'Mohun Bagan', 'score': '3 - 0', 'date': 'JAN 28', 'result': 'WIN', 'goals': 'Chhetri (12\', 40\'), Thapa (88\')'},
                    {'opp': 'Mumbai City', 'score': '1 - 1', 'date': 'JAN 21', 'result': 'DRAW', 'goals': 'Chhangte (55\')'},
                    {'opp': 'Bengaluru FC', 'score': '2 - 0', 'date': 'JAN 14', 'result': 'WIN', 'goals': 'Chhetri (45+2\'), Apuia (70\')'},
                  ];
                  final game = games[index];
                  bool isWin = game['result'] == 'WIN';

                  return GestureDetector(
                    onTap: () => _showMatchDetails(context, 'CORE FC', game['opp']!, isLive: false, gameData: game),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: surfaceColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(game['date']!, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(game['opp']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const Spacer(),
                          Text(game['score']!, style: const TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w900)),
                          const SizedBox(width: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: isWin ? Colors.green.withValues(alpha: 0.1) : Colors.white10,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(game['result']!, style: TextStyle(color: isWin ? Colors.greenAccent : Colors.white38, fontSize: 9, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: 3,
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(25, 40, 25, 15),
              child: Text('LEAGUE STANDINGS', style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
              ),
              child: Column(
                children: [
                  _buildTableHead(),
                  const Divider(color: Colors.white10),
                  _buildTableRow('1', 'CORE FC', '12', '28', true),
                  _buildTableRow('2', 'MOHUN BAGAN', '12', '25', false),
                  _buildTableRow('3', 'MUMBAI CITY', '11', '22', false),
                  _buildTableRow('4', 'BENGALURU FC', '12', '20', false),
                  _buildTableRow('5', 'EAST BENGAL', '12', '18', false),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 50)),
        ],
      );
  }

  Widget _buildUpcomingGameTile(BuildContext context, String title, String date, String status, String img, {bool isGray = false}) {
    return Container(
      height: 150,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          image: AssetImage(img),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: isGray ? 0.85 : 0.65),
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date, style: TextStyle(color: isGray ? Colors.white24 : goldColor, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
                const SizedBox(height: 4),
                Expanded(
                  child: Text(
                    title, 
                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildGameMeta(Icons.location_on_outlined, 'Pitch 4, Dubai'),
                      const SizedBox(width: 15),
                      _buildGameMeta(Icons.groups_outlined, '4 Spots Left'),
                      const SizedBox(width: 15),
                      _buildGameMeta(Icons.bolt, 'High Intensity'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isGray ? Colors.white.withValues(alpha: 0.1) : goldColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isGray ? Colors.white.withValues(alpha: 0.1) : goldColor.withValues(alpha: 0.3)),
              ),
              child: Text(
                status, 
                style: TextStyle(color: isGray ? Colors.white38 : goldColor, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameMeta(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white60, size: 12),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildTableHead() {
    return const Row(
      children: [
        SizedBox(width: 30, child: Text('POS', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold))),
        Expanded(child: Text('TEAM', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold))),
        SizedBox(width: 30, child: Text('P', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold))),
        SizedBox(width: 30, child: Text('PTS', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold))),
      ],
    );
  }

  Widget _buildTableRow(String pos, String team, String p, String pts, bool isMe) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          SizedBox(width: 30, child: Text(pos, style: TextStyle(color: isMe ? goldColor : Colors.white, fontWeight: FontWeight.bold))),
          Expanded(child: Text(team, style: TextStyle(color: isMe ? goldColor : Colors.white, fontWeight: FontWeight.bold))),
          SizedBox(width: 30, child: Text(p, style: TextStyle(color: isMe ? goldColor : Colors.white70))),
          SizedBox(width: 30, child: Text(pts, style: TextStyle(color: isMe ? goldColor : Colors.white, fontWeight: FontWeight.w900))),
        ],
      ),
    );
  }

  Widget _buildMatchTeam(String name, bool isMe) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isMe ? goldColor.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.05),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.shield, color: isMe ? goldColor : Colors.white24, size: 24),
        ),
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
      ],
    );
  }

  void _showMatchDetails(BuildContext context, String teamA, String teamB, {required bool isLive, Map<String, String>? gameData}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF080808),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => _PlayerMatchDetailView(teamA: teamA, teamB: teamB, isLive: isLive, gameData: gameData),
    );
  }
}

class _PlayerMatchDetailView extends StatefulWidget {
  final String teamA;
  final String teamB;
  final bool isLive;
  final Map<String, String>? gameData;
  const _PlayerMatchDetailView({required this.teamA, required this.teamB, required this.isLive, this.gameData});

  @override
  State<_PlayerMatchDetailView> createState() => _PlayerMatchDetailViewState();
}

class _PlayerMatchDetailViewState extends State<_PlayerMatchDetailView> with SingleTickerProviderStateMixin {
  late TabController _innerTab;

  final Map<String, List<String>> _teamLineups = {
    'CORE FC': [
      'Gurpreet Singh Sandhu', 'Subhasish Bose', 'Sandesh Jhingan', 'Anwar Ali', 'Pritam Kotal',
      'Anirudh Thapa', 'Apuia Ralte', 'Sahal Abdul Samad', 'L. Chhangte', 'Manvir Singh', 'Sunil Chhetri'
    ],
    'EAST BENGAL': [
      'Prabhsukhan Gill', 'Hijazi Maher', 'Anwar Ali', 'Mohammad Rakip', 'Mark Zothanpuia',
      'Jeakson Singh', 'Madih Talal', 'Saul Crespo', 'Naorem Mahesh', 'Nandhakumar Sekar', 'Cleiton Silva'
    ],
    'MOHUN BAGAN': [
      'Vishal Kaith', 'Subhasish Bose', 'Alberto Rodriguez', 'Tom Aldred', 'Asish Rai',
      'Anirudh Thapa', 'Lalengmawia', 'Sahal Abdul Samad', 'Liston Colaco', 'Manvir Singh', 'Jason Cummings'
    ],
    'MUMBAI CITY': [
      'Phurba Lachenpa', 'Mehtab Singh', 'Tiri', 'Akash Mishra', 'Rahul Bheke',
      'Yoell van Nieff', 'Apuia Ralte', 'Lallianzuala Chhangte', 'Bipin Singh', 'Jorge Pereyra Diaz', 'Vikram Partap Singh'
    ],
  };

  List<String> _getPlayers(String team) {
    String key = team.toUpperCase();
    return _teamLineups[key] ?? List.generate(11, (i) => 'Indian Player ${i + 1}');
  }

  @override
  void initState() {
    super.initState();
    _innerTab = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Container(
            width: 40, height: 4,
            decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(height: 20),
          TabBar(
            controller: _innerTab,
            indicatorColor: goldColor,
            labelColor: goldColor,
            unselectedLabelColor: Colors.white24,
            labelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
            tabs: const [Tab(text: 'LINEUPS'), Tab(text: 'FORMATION'), Tab(text: 'HISTORY')],
          ),
          Expanded(
            child: TabBarView(
              controller: _innerTab,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    children: [
                      _buildLineupColumn(widget.teamA, goldColor, _getPlayers(widget.teamA)),
                      const VerticalDivider(color: Colors.white10, width: 2),
                      _buildLineupColumn(widget.teamB, Colors.white60, _getPlayers(widget.teamB)),
                    ],
                  ),
                ),
                _buildFormationView(),
                _buildMatchHistoryView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchHistoryView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.isLive ? 'LIVE INCIDENTS' : 'MATCH EVENTS', style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
          const SizedBox(height: 30),
          if (widget.isLive) ...[
            _buildEventItem('78\'', 'Substitution: Sahal OUT, Thapa IN', Icons.swap_vert, Colors.blue),
            _buildEventItem('62\'', 'GOAL! Manvir Singh', Icons.sports_soccer, goldColor, sub: 'Assist: Chhangte'),
            _buildEventItem('45\'', 'GOAL! Sunil Chhetri', Icons.sports_soccer, goldColor, sub: 'Penalty Kick'),
            _buildEventItem('30\'', 'GOAL! Cleiton Silva', Icons.sports_soccer, Colors.white60, sub: 'Header'),
            _buildEventItem('15\'', 'Yellow Card: Sandesh Jhingan', Icons.rectangle, Colors.yellow),
          ] else ...[
            if (widget.gameData != null && widget.gameData!['goals'] != null)
              _buildEventItem('Final', widget.gameData!['goals']!, Icons.sports_soccer, goldColor)
            else
              const Text('No event data available', style: TextStyle(color: Colors.white24)),
          ],
        ],
      ),
    );
  }

  Widget _buildEventItem(String time, String event, IconData icon, Color color, {String? sub}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(time, style: const TextStyle(color: Colors.white24, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(width: 20),
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                if (sub != null) Text(sub, style: const TextStyle(color: Colors.white38, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormationView() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFormationHeader(widget.teamA, '4-3-3', goldColor),
              const Text('VS', style: TextStyle(color: Colors.white10, fontWeight: FontWeight.bold)),
              _buildFormationHeader(widget.teamB, '4-4-2', Colors.white60),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
              ),
              child: Stack(
                children: [
                  Center(child: Container(width: double.infinity, height: 1, color: Colors.white10)),
                  Center(child: Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white10)))),
                  
                  _playerIcon(0.5, 0.05, goldColor),
                  _playerIcon(0.2, 0.15, goldColor), _playerIcon(0.4, 0.15, goldColor), _playerIcon(0.6, 0.15, goldColor), _playerIcon(0.8, 0.15, goldColor),
                  _playerIcon(0.3, 0.3, goldColor), _playerIcon(0.5, 0.3, goldColor), _playerIcon(0.7, 0.3, goldColor),
                  _playerIcon(0.2, 0.42, goldColor), _playerIcon(0.5, 0.42, goldColor), _playerIcon(0.8, 0.42, goldColor),

                  _playerIcon(0.5, 0.95, Colors.white60),
                  _playerIcon(0.2, 0.85, Colors.white60), _playerIcon(0.4, 0.85, Colors.white60), _playerIcon(0.6, 0.85, Colors.white60), _playerIcon(0.8, 0.85, Colors.white60),
                  _playerIcon(0.15, 0.7, Colors.white60), _playerIcon(0.4, 0.7, Colors.white60), _playerIcon(0.6, 0.7, Colors.white60), _playerIcon(0.85, 0.7, Colors.white60),
                  _playerIcon(0.35, 0.58, Colors.white60), _playerIcon(0.65, 0.58, Colors.white60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormationHeader(String team, String formation, Color color) {
    return Column(
      children: [
        Text(team, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
        Text(formation, style: const TextStyle(color: Colors.white38, fontSize: 12, letterSpacing: 1)),
      ],
    );
  }

  Widget _playerIcon(double x, double y, Color color) {
    return Align(
      alignment: FractionalOffset(x, y),
      child: Container(
        width: 20, height: 20,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 4)]),
        child: const Center(child: Icon(Icons.person, size: 12, color: Colors.black)),
      ),
    );
  }

  Widget _buildLineupColumn(String team, Color color, List<String> players) {
    return Expanded(
      child: Column(
        children: [
          Text(team,
              style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14),
              textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeammateProfile(
                        playerName: players[index],
                        playerPosition: 'Player',
                        playerNumber: (index + 1).toString(),
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF121212),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text('${index + 1}', style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 12),
                      Expanded(child: Text(players[index],
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
