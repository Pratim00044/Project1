import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'teammate_profile.dart';
import 'player_game_detail.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class PlayerGamesPage extends StatefulWidget {
  const PlayerGamesPage({super.key});

  @override
  State<PlayerGamesPage> createState() => _PlayerGamesPageState();
}

class _PlayerGamesPageState extends State<PlayerGamesPage> {
  late DateTime selectedDate;
  late List<DateTime> dates;
  final ScrollController _calendarController = ScrollController();

  final List<List<Color>> tileColors = [
    [const Color(0xFF007CFE), const Color(0xFF004A99)],
    [const Color(0xFF38EF7D), const Color(0xFF11998E)],
    [const Color(0xFFEE0979), const Color(0xFFF12711)],
    [const Color(0xFFFFB75E), const Color(0xFFED8F03)],
    [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)],
    [const Color(0xFF00D2FF), const Color(0xFF3A7BD5)],
  ];

  @override
  void initState() {
    super.initState();
    DateTime today = DateTime(2026, 7, 10);
    selectedDate = today;
    dates = List.generate(14, (index) => today.add(Duration(days: index)));
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isToday = selectedDate.day == 10;
    String matchOpponent = 'DUBAI CITY FC';
    String matchTime = isToday ? '78\'' : 'FINAL';

    final List<Map<String, dynamic>> allAvailableGames = [
      {'title': 'DUBAI CUP', 'day': 10, 'status': 'REGISTERED', 'colors': tileColors[0]},
      {'title': 'ALL STARS MATCH', 'day': 10, 'status': 'REGISTERED', 'colors': tileColors[1]},
      {'title': 'COMMUNITY SHIELD', 'day': 10, 'status': 'OPEN', 'colors': tileColors[2]},
      {'title': 'LEAGUE GAME A', 'day': 11, 'status': 'REGISTERED', 'colors': tileColors[3]},
      {'title': 'TRAINING MATCH', 'day': 11, 'status': 'OPEN', 'colors': tileColors[4]},
      {'title': 'FRIENDLY CUP', 'day': 12, 'status': 'OPEN', 'colors': tileColors[5]},
      {'title': 'YOUTH LEAGUE', 'day': 13, 'status': 'REGISTERED', 'colors': tileColors[0]},
    ];

    final gamesForSelectedDate = allAvailableGames.where((g) => g['day'] == selectedDate.day).toList();
    final registeredGames = gamesForSelectedDate.where((g) => g['status'] == 'REGISTERED').toList();

    return CustomScrollView(
      key: ValueKey(selectedDate.day),
      physics: const BouncingScrollPhysics(),
      slivers: [
        // 1. LAST GAME
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(25, 20, 25, 15),
            child: Text('LAST GAME', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
          ),
        ),
        SliverToBoxAdapter(
          child: GestureDetector(
            onTap: () => _showMatchDetails(context, 'CORE FC', matchOpponent, isLive: isToday),
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: const Color(0xFF8E2DE2),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8E2DE2).withValues(alpha: 0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: Column(
                children: [
                  const Text('DUBAI PREMIER LEAGUE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            _buildMatchTeam('CORE FC', true),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 5,
                              runSpacing: 5,
                              alignment: WrapAlignment.center,
                              children: [
                                _buildScorerTitle('L. Messi (45\')', Colors.white, true),
                                _buildScorerTitle('K. Mbappe (62\')', Colors.white, true),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          const Text('2 - 1', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900)),
                          Text(matchTime, style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w900)),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            _buildMatchTeam(matchOpponent, false),
                            const SizedBox(height: 12),
                            _buildScorerTitle('E. Haaland (30\')', Colors.white, false),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // 2. DATE WHEEL
        SliverToBoxAdapter(child: _buildCalendarHeader()),

        // 3. UPCOMING GAMES (Registered for selected date)
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(25, 25, 25, 15),
            child: Text('UPCOMING GAMES', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
          ),
        ),

        if (registeredGames.isEmpty)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Text('No registered games for this date', style: TextStyle(color: Colors.white24, fontSize: 12)),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final game = registeredGames[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: _buildUpcomingGameTile(context, game['title'], 'FEB ${game['day']}', game['status'], game['colors']),
                  );
                },
                childCount: registeredGames.length,
              ),
            ),
          ),

        // 4. ALL GAMES (Whole list for selected date)
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(25, 30, 25, 15),
            child: Text('ALL GAMES', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
          ),
        ),

        if (gamesForSelectedDate.isEmpty)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Text('No games scheduled for this date', style: TextStyle(color: Colors.white24, fontSize: 12)),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final game = gamesForSelectedDate[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: _buildUpcomingGameTile(context, game['title'], 'FEB ${game['day']}', game['status'], game['colors']),
                  );
                },
                childCount: gamesForSelectedDate.length,
              ),
            ),
          ),

        const SliverToBoxAdapter(child: SizedBox(height: 50)),
      ],
    );
  }

  Widget _buildCalendarHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(25, 20, 25, 15),
          child: Text('PICK A DATE',
              style: TextStyle(
                  color: Colors.white24,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2)),
        ),
        Container(
          height: 110,
          margin: const EdgeInsets.only(bottom: 5),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ListView.builder(
                controller: _calendarController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                itemCount: dates.length,
                itemBuilder: (context, index) {
                  DateTime date = dates[index];
                  bool isSelected = date.day == selectedDate.day && date.month == selectedDate.month;
                  bool isToday = date.day == 10; 

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 85,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D0D0D),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF2ECC71) : Colors.white.withValues(alpha: 0.05),
                          width: 2.0,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isToday ? 'TODAY' : DateFormat('EEE').format(date).toUpperCase(),
                            style: TextStyle(
                              color: isSelected ? const Color(0xFF2ECC71) : Colors.white24,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            date.day.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                left: 10,
                child: GestureDetector(
                  onTap: () {
                    _calendarController.animateTo(
                      _calendarController.offset - 200,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFF2ECC71),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.chevron_left, color: Colors.black, size: 20),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    _calendarController.animateTo(
                      _calendarController.offset + 200,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFF2ECC71),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.chevron_right, color: Colors.black, size: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingGameTile(BuildContext context, String title, String date, String status, List<Color> colors) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerGameDetail(
        title: title,
        date: date,
        time: '11:30 PM',
        location: 'Dubai Sports City',
        type: '7-a-side',
      ))),
      child: Container(
        height: 160,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: colors[0],
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: colors[0].withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date, style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1)),
                const SizedBox(height: 8),
                Text(
                  title.toUpperCase(), 
                  style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
                ),
                const Spacer(),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      _buildGameMeta(Icons.location_on, 'PITCH 4, DUBAI'),
                      const SizedBox(width: 15),
                      _buildGameMeta(Icons.people, '4 SPOTS LEFT'),
                      const SizedBox(width: 15),
                      _buildGameMeta(Icons.bolt, 'HIGH INTENSITY'),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  status, 
                  style: TextStyle(
                    color: colors[0],
                    fontSize: 9, 
                    fontWeight: FontWeight.w900, 
                    letterSpacing: 0.5
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameMeta(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 12),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w900)),
      ],
    );
  }

  Widget _buildMatchTeam(String name, bool isMe) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.shield, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900)),
      ],
    );
  }

  static Widget _buildScorerTitle(String text, Color color, bool isMe) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(text, 
        style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w900),
        textAlign: TextAlign.center,
      ),
    );
  }

  void _showMatchDetails(BuildContext context, String teamA, String teamB, {required bool isLive, Map<String, String>? gameData}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
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
  final Color teamAColor = const Color(0xFF007CFE);
  final Color teamBColor = const Color(0xFF38EF7D);

  final List<List<Color>> playerColors = [
    [const Color(0xFF007CFE), const Color(0xFF004A99)],
    [const Color(0xFF38EF7D), const Color(0xFF11998E)],
    [const Color(0xFFEE0979), const Color(0xFFF12711)],
    [const Color(0xFFFFB75E), const Color(0xFFED8F03)],
    [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)],
    [const Color(0xFF00D2FF), const Color(0xFF3A7BD5)],
  ];

  final Map<String, List<Map<String, dynamic>>> _teamLineups = {
    'CORE FC': [
      {'name': 'E. Martinez', 'no': '1', 'pos': 'GK'},
      {'name': 'T. Hernandez', 'no': '3', 'pos': 'LB'},
      {'name': 'V. van Dijk', 'no': '4', 'pos': 'CB'},
      {'name': 'Ruben Dias', 'no': '5', 'pos': 'CB'},
      {'name': 'K. Walker', 'no': '2', 'pos': 'RB'},
      {'name': 'K. De Bruyne', 'no': '17', 'pos': 'CM'},
      {'name': 'Rodri', 'no': '16', 'pos': 'CM'},
      {'name': 'J. Bellingham', 'no': '10', 'pos': 'AM'},
      {'name': 'M. Salah', 'no': '11', 'pos': 'RW'},
      {'name': 'K. Mbappe', 'no': '7', 'pos': 'LW'},
      {'name': 'L. Messi', 'no': '10', 'pos': 'ST'},
    ],
    'DUBAI CITY FC': [
      {'name': 'Ederson', 'no': '31', 'pos': 'GK'},
      {'name': 'Marquinhos', 'no': '5', 'pos': 'CB'},
      {'name': 'Ruben Dias', 'no': '3', 'pos': 'CB'},
      {'name': 'A. Hakimi', 'no': '2', 'pos': 'RB'},
      {'name': 'Joao Cancelo', 'no': '7', 'pos': 'LB'},
      {'name': 'D. Rice', 'no': '41', 'pos': 'CDM'},
      {'name': 'Phil Foden', 'no': '47', 'pos': 'CAM'},
      {'name': 'B. Silva', 'no': '20', 'pos': 'CM'},
      {'name': 'Vini Jr.', 'no': '7', 'pos': 'LW'},
      {'name': 'B. Saka', 'no': '7', 'pos': 'RW'},
      {'name': 'E. Haaland', 'no': '9', 'pos': 'ST'},
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
  void dispose() {
    _innerTab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      decoration: const BoxDecoration(
        color: Color(0xFF000000),
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
            indicatorColor: goldColor,
            labelColor: goldColor,
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
          _buildTeamInfo(widget.teamA, teamAColor),
          Column(
            children: [
              const Text('2 - 1', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(6)),
                child: const Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w900)),
              ),
            ],
          ),
          _buildTeamInfo(widget.teamB, teamBColor),
        ],
      ),
    );
  }

  Widget _buildTeamInfo(String name, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(Icons.shield, color: color, size: 30),
        ),
        const SizedBox(height: 10),
        Text(name, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900)),
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
              border: Border.all(color: color),
            ),
            child: Text(team, 
              style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 9, letterSpacing: 1),
              textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                final player = players[index];
                final colors = playerColors[index % playerColors.length];
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
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colors[0], width: 1.5),
                    ),
                    child: Row(
                      mainAxisAlignment: isHome ? MainAxisAlignment.start : MainAxisAlignment.end,
                      children: [
                        if (isHome) 
                          Container(
                            width: 30, height: 30,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/sunil.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        if (isHome)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(player['name'].toUpperCase(), 
                                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900),
                                  maxLines: 1, overflow: TextOverflow.ellipsis),
                                Text(player['pos'], style: TextStyle(color: colors[0], fontSize: 8, fontWeight: FontWeight.w900)),
                              ],
                            ),
                          ),
                        if (isHome) const SizedBox(width: 5),
                        if (isHome) _playerNoCircle(player['no'], colors[0]),

                        if (!isHome) _playerNoCircle(player['no'], colors[0]),
                        if (!isHome) const SizedBox(width: 5),
                        if (!isHome)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(player['name'].toUpperCase(), 
                                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900),
                                  maxLines: 1, overflow: TextOverflow.ellipsis),
                                Text(player['pos'], style: TextStyle(color: colors[0], fontSize: 8, fontWeight: FontWeight.w900)),
                              ],
                            ),
                          ),
                        if (!isHome) 
                          Container(
                            width: 30, height: 30,
                            margin: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/sunil.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
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
      child: Center(child: Text(no, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w900))),
    );
  }

  Widget _buildMatchHistoryView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          _buildEventItem('78\'', 'SUBSTITUTION: J. BELLINGHAM OUT, MUSIALA IN', Icons.swap_vert, playerColors[0][0]),
          _buildEventItem('62\'', 'GOAL! K. MBAPPE', Icons.sports_soccer, playerColors[1][0], sub: 'ASSIST: M. SALAH'),
          _buildEventItem('45\'', 'GOAL! L. MESSI', Icons.sports_soccer, playerColors[2][0], sub: 'PENALTY KICK'),
          _buildEventItem('30\'', 'GOAL! E. HAALAND', Icons.sports_soccer, playerColors[3][0], sub: 'HEADER'),
          _buildEventItem('15\'', 'YELLOW CARD: V. VAN DIJK', Icons.rectangle, playerColors[4][0]),
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
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle, border: Border.all(color: color.withValues(alpha: 0.3))),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900)),
                if (sub != null) Text(sub, style: const TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.w700)),
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
        _formationPlayer(0.5, 0.05, '1', 'Martinez', playerColors[0][0]),
        _formationPlayer(0.1, 0.16, '3', 'Hernandez', playerColors[1][0]),
        _formationPlayer(0.37, 0.16, '4', 'Van Dijk', playerColors[2][0]),
        _formationPlayer(0.63, 0.16, '5', 'Dias', playerColors[3][0]),
        _formationPlayer(0.9, 0.16, '2', 'Walker', playerColors[4][0]),
        _formationPlayer(0.25, 0.28, '17', 'Bruyne', playerColors[5][0]),
        _formationPlayer(0.5, 0.28, '16', 'Rodri', playerColors[0][0]),
        _formationPlayer(0.75, 0.28, '10', 'Bellingham', playerColors[1][0]),
        _formationPlayer(0.15, 0.40, '7', 'Mbappe', playerColors[2][0]),
        _formationPlayer(0.5, 0.40, '10', 'Messi', playerColors[3][0]),
        _formationPlayer(0.85, 0.40, '11', 'Salah', playerColors[4][0]),
        _formationPlayer(0.5, 0.95, '31', 'Ederson', playerColors[5][0]),
        _formationPlayer(0.1, 0.84, '7', 'Cancelo', playerColors[0][0]),
        _formationPlayer(0.37, 0.84, '5', 'Marquinhos', playerColors[1][0]),
        _formationPlayer(0.63, 0.84, '3', 'Dias', playerColors[2][0]),
        _formationPlayer(0.9, 0.84, '2', 'Hakimi', playerColors[3][0]),
        _formationPlayer(0.1, 0.72, '7', 'Vini Jr.', playerColors[4][0]),
        _formationPlayer(0.37, 0.72, '41', 'Rice', playerColors[5][0]),
        _formationPlayer(0.63, 0.72, '20', 'Silva', playerColors[0][0]),
        _formationPlayer(0.9, 0.72, '7', 'Saka', playerColors[1][0]),
        _formationPlayer(0.3, 0.60, '47', 'Foden', playerColors[2][0]),
        _formationPlayer(0.7, 0.60, '9', 'Haaland', playerColors[3][0]),
      ],
    );
  }

  Widget _formationPlayer(double x, double y, String no, String name, Color color) {
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
              border: Border.all(color: color, width: 2),
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

    final Paint pitchPaint = Paint()..color = const Color(0xFF121212);

    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), const Radius.circular(30)),
        pitchPaint);

    final Paint grassPaint = Paint()..color = Colors.white.withValues(alpha: 0.02);
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
