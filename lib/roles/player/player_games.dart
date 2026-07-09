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
              padding: EdgeInsets.fromLTRB(25, 30, 25, 15),
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
              onTap: () => _showMatchDetails(context, 'CORE FC', 'DUBAI CITY FC', isLive: true),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.redAccent.withValues(alpha: 0.2)),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/match.png'),
                    fit: BoxFit.cover,
                    opacity: 0.2,
                  ),
                ),
                child: Column(
                  children: [
                    const Text('PREMIER LEAGUE', style: TextStyle(color: Colors.white24, fontSize: 9, fontWeight: FontWeight.bold)),
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
                        _buildMatchTeam('DUBAI CITY FC', false),
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
                    const Text('Dubai City FC: Cleiton Silva (30\')', style: TextStyle(color: Colors.white38, fontSize: 10)),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(25, 40, 25, 15),
              child: Text('UPCOMING GAMES', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
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
              child: Text('DISCOVER MATCHES', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
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
              child: Text('PAST MATCHES', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final games = [
                    {'opp': 'United Football Club', 'score': '3 - 0', 'date': 'JAN 28', 'result': 'WIN', 'goals': 'Chhetri (12\', 40\'), Thapa (88\')'},
                    {'opp': 'Eagle FC', 'score': '1 - 1', 'date': 'JAN 21', 'result': 'DRAW', 'goals': 'Chhangte (55\')'},
                    {'opp': 'Emirates Club', 'score': '2 - 0', 'date': 'JAN 14', 'result': 'WIN', 'goals': 'Chhetri (45+2\'), Apuia (70\')'},
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
              child: Text('LEAGUE STANDINGS', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
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
                  _buildTableRow('2', 'GULF UNITED FC', '12', '25', false),
                  _buildTableRow('3', 'UNITED FC', '11', '22', false),
                  _buildTableRow('4', 'EMIRATES CLUB', '12', '20', false),
                  _buildTableRow('5', 'EAGLE FC', '12', '18', false),
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
  final Color teamAColor = const Color(0xFFFFD700);
  final Color teamBColor = const Color(0xFF00E5FF);

  final Map<String, List<Map<String, dynamic>>> _teamLineups = {
    'CORE FC': [
      {'name': 'G. Sandhu', 'no': '1', 'pos': 'GK'},
      {'name': 'S. Bose', 'no': '3', 'pos': 'LB'},
      {'name': 'S. Jhingan', 'no': '5', 'pos': 'CB'},
      {'name': 'Anwar Ali', 'no': '4', 'pos': 'CB'},
      {'name': 'P. Kotal', 'no': '2', 'pos': 'RB'},
      {'name': 'A. Thapa', 'no': '7', 'pos': 'CM'},
      {'name': 'Apuia Ralte', 'no': '8', 'pos': 'CM'},
      {'name': 'S. Samad', 'no': '10', 'pos': 'AM'},
      {'name': 'L. Chhangte', 'no': '17', 'pos': 'RW'},
      {'name': 'Manvir Singh', 'no': '9', 'pos': 'LW'},
      {'name': 'Sunil Chhetri', 'no': '11', 'pos': 'ST'},
    ],
    'DUBAI CITY FC': [
      {'name': 'P. Gill', 'no': '1', 'pos': 'GK'},
      {'name': 'H. Maher', 'no': '4', 'pos': 'CB'},
      {'name': 'Anwar Ali', 'no': '3', 'pos': 'CB'},
      {'name': 'M. Rakip', 'no': '12', 'pos': 'RB'},
      {'name': 'M. Zothanpuia', 'no': '5', 'pos': 'LB'},
      {'name': 'J. Singh', 'no': '8', 'pos': 'CDM'},
      {'name': 'M. Talal', 'no': '10', 'pos': 'CAM'},
      {'name': 'S. Crespo', 'no': '21', 'pos': 'CM'},
      {'name': 'N. Mahesh', 'no': '11', 'pos': 'LW'},
      {'name': 'Nandhakumar', 'no': '22', 'pos': 'RW'},
      {'name': 'Cleiton Silva', 'no': '9', 'pos': 'ST'},
    ],
  };

  List<Map<String, dynamic>> _getPlayers(String team) {
    String key = team.toUpperCase();
    return _teamLineups[key] ?? List.generate(11, (i) => {'name': 'Player ${i + 1}', 'no': '${i + 1}', 'pos': 'POS'});
  }

  @override
  void initState() {
    super.initState();
    _innerTab = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      decoration: const BoxDecoration(
        color: Color(0xFF020202),
        borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 50, height: 5,
            decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10)),
          ),
          const SizedBox(height: 20),
          _buildScoreHeader(),
          const SizedBox(height: 20),
          TabBar(
            controller: _innerTab,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 3.0, color: teamAColor),
              insets: const EdgeInsets.symmetric(horizontal: 40.0),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white24,
            labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5),
            dividerColor: Colors.transparent,
            tabs: const [Tab(text: 'LINEUPS'), Tab(text: 'FORMATION'), Tab(text: 'HISTORY')],
          ),
          Expanded(
            child: TabBarView(
              controller: _innerTab,
              children: [
                _buildLineupView(),
                _buildFormationView(),
                _buildMatchHistoryView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTeamInfo(widget.teamA, teamAColor, true),
          Column(
            children: [
              Text(widget.isLive ? 'LIVE' : 'FINISHED', style: TextStyle(color: widget.isLive ? Colors.redAccent : Colors.white38, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
              const SizedBox(height: 5),
              const Text('2 - 1', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900)),
            ],
          ),
          _buildTeamInfo(widget.teamB, teamBColor, false),
        ],
      ),
    );
  }

  Widget _buildTeamInfo(String name, Color color, bool isHome) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color.withValues(alpha: 0.2), width: 2),
          ),
          child: Icon(Icons.shield, color: color, size: 30),
        ),
        const SizedBox(height: 10),
        Text(name, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900)),
      ],
    );
  }

  Widget _buildLineupView() {
    var playersA = _getPlayers(widget.teamA);
    var playersB = _getPlayers(widget.teamB);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Row(
        children: [
          _buildLineupColumn(widget.teamA, teamAColor, playersA, true),
          const SizedBox(width: 10),
          _buildLineupColumn(widget.teamB, teamBColor, playersB, false),
        ],
      ),
    );
  }

  Widget _buildLineupColumn(String team, Color color, List<Map<String, dynamic>> players, bool isHome) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color.withValues(alpha: 0.2)),
            ),
            child: Text(team, 
              style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 10, letterSpacing: 1),
              textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                final player = players[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TeammateProfile(
                          playerName: player['name'],
                          playerPosition: player['pos'],
                          playerNumber: player['no'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF111111),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: color.withValues(alpha: 0.05)),
                      gradient: LinearGradient(
                        begin: isHome ? Alignment.centerLeft : Alignment.centerRight,
                        end: isHome ? Alignment.centerRight : Alignment.centerLeft,
                        colors: [color.withValues(alpha: 0.05), Colors.transparent],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: isHome ? MainAxisAlignment.start : MainAxisAlignment.end,
                      children: [
                        if (isHome) _playerNoCircle(player['no'], color),
                        if (isHome) const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: isHome ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                            children: [
                              Text(player['name'], 
                                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                maxLines: 1, overflow: TextOverflow.ellipsis),
                              Text(player['pos'], style: TextStyle(color: color.withValues(alpha: 0.5), fontSize: 8, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        if (!isHome) const SizedBox(width: 10),
                        if (!isHome) _playerNoCircle(player['no'], color),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _playerNoCircle(String no, Color color) {
    return Container(
      width: 22, height: 22,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
      child: Center(child: Text(no, style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w900))),
    );
  }

  Widget _buildMatchHistoryView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          _buildEventItem('78\'', 'Substitution: Sahal OUT, Thapa IN', Icons.swap_vert, teamAColor),
          _buildEventItem('62\'', 'GOAL! Manvir Singh', Icons.sports_soccer, teamAColor, sub: 'Assist: Chhangte'),
          _buildEventItem('45\'', 'GOAL! Sunil Chhetri', Icons.sports_soccer, teamAColor, sub: 'Penalty Kick'),
          _buildEventItem('30\'', 'GOAL! Cleiton Silva', Icons.sports_soccer, teamBColor, sub: 'Header'),
          _buildEventItem('15\'', 'Yellow Card: Sandesh Jhingan', Icons.rectangle, teamAColor),
        ],
      ),
    );
  }

  Widget _buildEventItem(String time, String event, IconData icon, Color color, {String? sub}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            child: Text(time, style: const TextStyle(color: Colors.white24, fontSize: 13, fontWeight: FontWeight.w900)),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                if (sub != null) Text(sub, style: const TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormationView() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 30),
        child: Container(
          height: 1000,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(
              children: [
                CustomPaint(
                  size: const Size(double.infinity, 1000),
                  painter: GoogleStylePitchPainter(),
                ),
                _buildFormationPlayers(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormationPlayers() {
    return Stack(
      children: [
        _formationPlayer(0.5, 0.05, '1', 'G. Sandhu', teamAColor, isTop: true),
        
        _formationPlayer(0.1, 0.16, '3', 'S. Bose', teamAColor, isTop: true),
        _formationPlayer(0.37, 0.16, '5', 'S. Jhingan', teamAColor, isTop: true),
        _formationPlayer(0.63, 0.16, '4', 'Anwar', teamAColor, isTop: true),
        _formationPlayer(0.9, 0.16, '2', 'P. Kotal', teamAColor, isTop: true),
        
        _formationPlayer(0.25, 0.28, '7', 'Thapa', teamAColor, isTop: true),
        _formationPlayer(0.5, 0.28, '8', 'Apuia', teamAColor, isTop: true),
        _formationPlayer(0.75, 0.28, '10', 'Samad', teamAColor, isTop: true),
        
        _formationPlayer(0.15, 0.40, '9', 'Manvir', teamAColor, isTop: true),
        _formationPlayer(0.5, 0.40, '11', 'Chhetri', teamAColor, isTop: true),
        _formationPlayer(0.85, 0.40, '17', 'Chhangte', teamAColor, isTop: true),

        _formationPlayer(0.5, 0.95, '1', 'P. Gill', teamBColor, isTop: false),
        
        _formationPlayer(0.1, 0.84, '5', 'Zothan', teamBColor, isTop: false),
        _formationPlayer(0.37, 0.84, '4', 'Maher', teamBColor, isTop: false),
        _formationPlayer(0.63, 0.84, '3', 'Anwar', teamBColor, isTop: false),
        _formationPlayer(0.9, 0.84, '12', 'Rakip', teamBColor, isTop: false),
        
        _formationPlayer(0.1, 0.72, '11', 'Mahesh', teamBColor, isTop: false),
        _formationPlayer(0.37, 0.72, '8', 'Jeakson', teamBColor, isTop: false),
        _formationPlayer(0.63, 0.72, '21', 'Crespo', teamBColor, isTop: false),
        _formationPlayer(0.9, 0.72, '22', 'Nandha', teamBColor, isTop: false),
        
        _formationPlayer(0.3, 0.60, '10', 'Talal', teamBColor, isTop: false),
        _formationPlayer(0.7, 0.60, '9', 'Cleiton', teamBColor, isTop: false),
      ],
    );
  }

  Widget _formationPlayer(double x, double y, String no, String name, Color color, {required bool isTop}) {
    return Align(
      alignment: FractionalOffset(x, y),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
              image: const DecorationImage(
                image: AssetImage('assets/images/sunil.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "$no ${name.toUpperCase()}",
            style: const TextStyle(
              color: Colors.white, 
              fontSize: 9, 
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
              shadows: [Shadow(color: Colors.black, blurRadius: 4)],
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}

class GoogleStylePitchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final Paint pitchPaint = Paint()..color = const Color(0xFF58B36E);

    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), const Radius.circular(30)),
        pitchPaint);

    final Paint grassPaint = Paint()..color = Colors.black.withValues(alpha: 0.05);
    int stripes = 12;
    for (int i = 0; i < stripes; i++) {
      if (i % 2 == 0) {
        canvas.drawRect(Rect.fromLTWH(0, (size.height / stripes) * i, size.width, size.height / stripes), grassPaint);
      }
    }

    canvas.drawRect(Rect.fromLTWH(10, 10, size.width - 20, size.height - 20), linePaint);
    canvas.drawLine(Offset(10, size.height / 2), Offset(size.width - 10, size.height / 2), linePaint);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 50, linePaint);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 3, linePaint..style = PaintingStyle.fill);
    linePaint.style = PaintingStyle.stroke;

    double boxWidth = size.width * 0.65;
    double boxHeight = size.height * 0.14;
    
    canvas.drawRect(Rect.fromLTWH((size.width - boxWidth) / 2, 10, boxWidth, boxHeight), linePaint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.35, 10, size.width * 0.3, boxHeight * 0.3), linePaint);

    canvas.drawRect(Rect.fromLTWH((size.width - boxWidth) / 2, size.height - boxHeight - 10, boxWidth, boxHeight), linePaint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.35, size.height - (boxHeight * 0.3) - 10, size.width * 0.3, boxHeight * 0.3), linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
