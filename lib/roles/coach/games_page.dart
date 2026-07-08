import 'package:flutter/material.dart';
import 'create_training_page.dart';
import 'social_leagues.dart';

const Color goldColor = Color(0xFFD4AF37);

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> with SingleTickerProviderStateMixin {
  late TabController _tab;
  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('GAMES',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2)),
              _buildCreateButton(context),
            ],
          ),
        ),
          TabBar(
              controller: _tab,
              indicatorColor: goldColor,
              labelColor: goldColor,
              unselectedLabelColor: Colors.white24,
              indicatorSize: TabBarIndicatorSize.label,
              dividerColor: Colors.transparent,
              tabs: const [Tab(text: 'MATCHES'), Tab(text: 'LEAGUES'), Tab(text: 'TRAINING')]),
          Expanded(
            child: TabBarView(
              controller: _tab,
              children: [
                _buildMatchTab(context),
                _buildLeagueTab(context),
                _buildTrainingTab(context),
              ],
            ),
          ),
        ],
      );
  }

  Widget _buildCreateButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [goldColor, goldColor.withOpacity(0.7)]),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: goldColor.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () => _showCreateGameForm(context),
        icon: const Icon(Icons.add, size: 18, color: Colors.black),
        label: const Text('CREATE',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildMatchTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildSectionTitle('LIVE MATCHES'),
        const SizedBox(height: 15),
        _buildLiveCard(context, 'MOHUN BAGAN', 'KERALA BLASTERS', '2', '1', '78\'',
            'Hero Indian Super League'),
        const SizedBox(height: 30),
        _buildSectionTitle('UPCOMING FIXTURES'),
        const SizedBox(height: 15),
        LayoutBuilder(builder: (context, constraints) {
          double aspectRatio = constraints.maxWidth < 600 ? 1.4 : 1.8;
          return GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: aspectRatio,
            ),
            children: [
              _buildUpcomingBoxCard(context, 'MOHUN BAGAN vs EAST BENGAL', 'JUL 02', '19:30',
                  'League Match', 'Salt Lake Stadium'),
              _buildUpcomingBoxCard(context, 'MOHUN BAGAN vs MUMBAI CITY', 'JUL 08', '20:00',
                  'Friendly', 'Mumbai Football Arena'),
              _buildUpcomingBoxCard(context, 'MOHUN BAGAN vs FC GOA', 'JUL 15', '19:30',
                  'Durand Cup', 'Fatorda Stadium'),
              _buildUpcomingBoxCard(context, 'MOHUN BAGAN vs BENGALURU FC', 'JUL 22', '18:00',
                  'League Match', 'Kanteerava Stadium'),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildLeagueTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SocialLeaguesPage())),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF2ECC71).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFF2ECC71).withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(color: Color(0xFF2ECC71), shape: BoxShape.circle),
                  child: const Icon(Icons.public_rounded, color: Colors.black, size: 24),
                ),
                const SizedBox(width: 20),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('EXPLORE SOCIAL LEAGUES', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Manage 5, 7, 8, 9 & 11 a-side games', style: TextStyle(color: Colors.white60, fontSize: 13)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF2ECC71), size: 18),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        _buildSectionTitle('ACTIVE LEAGUES'),
        const SizedBox(height: 15),
        LayoutBuilder(builder: (context, constraints) {
          double aspectRatio = constraints.maxWidth < 600 ? 1.5 : 2.0;
          return GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: aspectRatio,
            ),
            children: [
              _buildLeagueBoxCard('Super Cup', 'Bhubaneswar', '16 Teams', 'IN PROGRESS', Icons.emoji_events),
              _buildLeagueBoxCard('Santosh Trophy', 'Multiple', '32 Teams', 'REGISTRATION OPEN', Icons.emoji_events, isGold: true),
              _buildLeagueBoxCard('I-League 2', 'Pan-India', '12 Teams', 'UPCOMING', Icons.emoji_events),
              _buildLeagueBoxCard('Durand Cup', 'Kolkata', '24 Teams', 'REGISTRATION OPEN', Icons.emoji_events, isGold: true),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildTrainingTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle('UPCOMING TRAINING'),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateTrainingPage())),
              child: const Text('SCHEDULE NEW', style: TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 15),
        _buildTrainingCard(context, 'TACTICAL DRILLS', 'JUL 01', '08:00', 'Core Academy Pitch', isUpcoming: true),
        const SizedBox(height: 15),
        _buildTrainingCard(context, 'FITNESS TEST', 'JUL 03', '07:30', 'Main Stadium Gym', isUpcoming: true),
        
        const SizedBox(height: 35),
        _buildSectionTitle('PAST SESSIONS'),
        const SizedBox(height: 15),
        _buildTrainingCard(context, 'DEFENSIVE POSITIONING', 'JUN 28', '09:00', 'Pitch B', isUpcoming: false),
        const SizedBox(height: 15),
        _buildTrainingCard(context, 'SHOOTING PRACTICE', 'JUN 25', '16:00', 'Pitch A', isUpcoming: false),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget _buildTrainingCard(BuildContext context, String title, String date, String time, String venue, {required bool isUpcoming}) {
    return GestureDetector(
      onTap: () => _showTrainingDetails(context, title, date, time, venue, isUpcoming),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isUpcoming 
              ? [const Color(0xFF1A1A1A), const Color(0xFF0D0D0D)]
              : [const Color(0xFF121212), const Color(0xFF080808)],
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (isUpcoming ? goldColor : Colors.white10).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    isUpcoming ? Icons.event_available : Icons.history,
                    color: isUpcoming ? goldColor : Colors.white38,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, 
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 10, color: goldColor.withOpacity(0.5)),
                          const SizedBox(width: 4),
                          Text(date, style: const TextStyle(color: Colors.white38, fontSize: 11)),
                          const SizedBox(width: 12),
                          Icon(Icons.access_time, size: 10, color: goldColor.withOpacity(0.5)),
                          const SizedBox(width: 4),
                          Text(time, style: const TextStyle(color: Colors.white38, fontSize: 11)),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: goldColor.withOpacity(0.3), size: 20),
              ],
            ),
            if (isUpcoming) ...[
              const SizedBox(height: 15),
              const Divider(color: Colors.white10, height: 1),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(venue, style: const TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: goldColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('UPCOMING', style: TextStyle(color: goldColor, fontSize: 9, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showTrainingDetails(BuildContext context, String title, String date, String time, String venue, bool isUpcoming) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF080808),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => _TrainingDetailView(title: title, date: date, time: time, venue: venue, isUpcoming: isUpcoming),
    );
  }

  Widget _buildSectionTitle(String t) => Text(t,
      style: const TextStyle(
          color: Colors.white38,
          fontSize: 11,
          fontWeight: FontWeight.w900,
          letterSpacing: 2));

  Widget _buildLiveCard(BuildContext context, String t1, String t2, String s1, String s2,
      String time, String l) {
    return GestureDetector(
      onTap: () => _showMatchDetails(context, t1, t2),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.redAccent.withOpacity(0.3)),
          image: const DecorationImage(
            image: AssetImage('assets/images/match.png'),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A1A), Color(0xFF080808)],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.redAccent, borderRadius: BorderRadius.circular(8)),
                  child: Text(time,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTeamLogoInfo(t1, goldColor),
                Text('$s1 - $s2',
                    style: const TextStyle(
                        color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900)),
                _buildTeamLogoInfo(t2, Colors.white24),
              ],
            ),
            const SizedBox(height: 10),
            const Text('Tap to view Lineups',
                style: TextStyle(color: goldColor, fontSize: 10, letterSpacing: 1)),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamLogoInfo(String name, Color color) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                shape: BoxShape.circle,
                border: Border.all(color: color.withOpacity(0.2))),
            child: Icon(Icons.shield, color: color, size: 40),
          ),
          const SizedBox(height: 10),
          Text(name,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _buildUpcomingBoxCard(
      BuildContext context, String t, String d, String time, String type, String v) {
    return GestureDetector(
      onTap: () => _showMatchDetails(context, t.split('vs')[0].trim(), t.split('vs')[1].trim()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          double baseWidth = 250.0;
          double scale = (constraints.maxWidth / baseWidth).clamp(0.7, 1.2);
          
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(d, style: TextStyle(color: goldColor, fontSize: 9 * scale, fontWeight: FontWeight.bold)),
                  Text(time, style: TextStyle(color: Colors.white38, fontSize: 9 * scale)),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Divider(color: Colors.white10, thickness: 0.5),
              ),
              Text(type.toUpperCase(), style: TextStyle(color: goldColor, fontSize: 8 * scale, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(t, 
                    style: TextStyle(color: Colors.white, fontSize: 13 * scale, fontWeight: FontWeight.bold)),
              ),
              Text(v, 
                  style: TextStyle(color: Colors.white24, fontSize: 10 * scale), 
                  maxLines: 1, 
                  overflow: TextOverflow.ellipsis),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildLeagueBoxCard(String n, String l, String t, String s, IconData icon, {bool isGold = false}) {
    return GestureDetector(
      onTap: () => _showLeagueDetails(n, s),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isGold ? goldColor.withOpacity(0.05) : const Color(0xFF121212),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isGold ? goldColor.withOpacity(0.3) : Colors.white.withOpacity(0.03)),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          double baseWidth = 200.0;
          double scale = (constraints.maxWidth / baseWidth).clamp(0.8, 1.2);
          
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(n, 
                      style: TextStyle(color: Colors.white, fontSize: 13 * scale, fontWeight: FontWeight.bold), 
                      maxLines: 1, 
                      overflow: TextOverflow.ellipsis),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: s.contains('OPEN') ? Colors.green.withOpacity(0.1) : Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(s.contains('OPEN') ? 'OPEN' : s, 
                        style: TextStyle(color: s.contains('OPEN') ? Colors.greenAccent : Colors.white38, fontSize: 7 * scale, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(l, style: TextStyle(color: Colors.white38, fontSize: 9 * scale)),
              const SizedBox(height: 4),
              Text(t, style: TextStyle(color: goldColor, fontSize: 9 * scale, fontWeight: FontWeight.w500)),
            ],
          );
        }),
      ),
    );
  }

  void _showLeagueDetails(String name, String status) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF080808),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(name.toUpperCase(), style: const TextStyle(color: goldColor, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Text('Tournament Details for $name will be displayed here.', style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 30),
            if (status.contains('OPEN'))
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: goldColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text('REGISTER NOW', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showMatchDetails(BuildContext context, String teamA, String teamB) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF080808),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => _MatchDetailView(teamA: teamA, teamB: teamB),
    );
  }

  void _showCreateGameForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF080808),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => const _CreateGameForm(),
    );
  }
}

class _MatchDetailView extends StatefulWidget {
  final String teamA;
  final String teamB;
  const _MatchDetailView({required this.teamA, required this.teamB});

  @override
  State<_MatchDetailView> createState() => _MatchDetailViewState();
}

class _MatchDetailViewState extends State<_MatchDetailView> with SingleTickerProviderStateMixin {
  late TabController _innerTab;

  final Map<String, List<String>> _teamLineups = {
    'MOHUN BAGAN': [
      'Vishal Kaith', 'Subhasish Bose', 'Alberto Rodriguez', 'Tom Aldred', 'Asish Rai',
      'Anirudh Thapa', 'Lalengmawia', 'Sahal Abdul Samad', 'Liston Colaco', 'Manvir Singh', 'Jason Cummings'
    ],
    'KERALA BLASTERS': [
      'Som Kumar', 'Milos Drincic', 'Pritam Kotal', 'Sandeep Singh', 'Aibanhah Dohling',
      'Vibin Mohanan', 'Jeakson Singh', 'Luna', 'Rahul KP', 'Daisuke Sakai', 'Kwame Peprah'
    ],
    'EAST BENGAL': [
      'Prabhsukhan Gill', 'Hijazi Maher', 'Anwar Ali', 'Mohammad Rakip', 'Mark Zothanpuia',
      'Jeakson Singh', 'Madih Talal', 'Saul Crespo', 'Naorem Mahesh', 'Nandhakumar Sekar', 'Dimitrios Diamantakos'
    ],
    'BENGALURU FC': [
      'Gurpreet Singh', 'Rahul Bheke', 'Aleksandar Jovanovic', 'Nikhil Poojary', 'Roshan Singh',
      'Suresh Wangjam', 'Lalremzuala Fanai', 'Ryan Williams', 'Sunil Chhetri', 'Jorge Pereyra Diaz', 'Edgar Mendez'
    ],
  };

  List<String> _getPlayers(String team) {
    String key = team.toUpperCase();
    return _teamLineups[key] ?? List.generate(11, (i) => 'Player ${i + 1}');
  }

  @override
  void initState() {
    super.initState();
    _innerTab = TabController(length: 2, vsync: this);
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
            tabs: const [Tab(text: 'LINEUPS'), Tab(text: 'FORMATION')],
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
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green.withOpacity(0.3)),
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
        decoration: BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 4)]),
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
              textAlign: TextAlign.center),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) => Container(
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
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CreateGameForm extends StatefulWidget {
  const _CreateGameForm();

  @override
  State<_CreateGameForm> createState() => _CreateGameFormState();
}

class _TrainingDetailView extends StatefulWidget {
  final String title;
  final String date;
  final String time;
  final String venue;
  final bool isUpcoming;

  const _TrainingDetailView({
    required this.title,
    required this.date,
    required this.time,
    required this.venue,
    required this.isUpcoming,
  });

  @override
  State<_TrainingDetailView> createState() => _TrainingDetailViewState();
}

class _TrainingDetailViewState extends State<_TrainingDetailView> {
  final List<Map<String, dynamic>> _players = [
    {'name': 'Sunil Chhetri', 'attended': true, 'rating': 4.5},
    {'name': 'Sahal Abdul', 'attended': true, 'rating': 4.0},
    {'name': 'Anirudh Thapa', 'attended': false, 'rating': 0.0},
    {'name': 'Sandesh Jhingan', 'attended': true, 'rating': 3.5},
    {'name': 'Gurpreet Singh', 'attended': true, 'rating': 5.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: const TextStyle(color: goldColor, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  const SizedBox(height: 5),
                  Text('${widget.date} at ${widget.time} | ${widget.venue}', style: const TextStyle(color: Colors.white38, fontSize: 12)),
                ],
              ),
              if (widget.isUpcoming)
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Session marked as completed!')));
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 12)),
                  child: const Text('COMPLETE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
            ],
          ),
          const SizedBox(height: 30),
          Text(widget.isUpcoming ? 'INVITED PLAYERS' : 'ATTENDANCE & RATINGS', 
            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: _players.length,
              itemBuilder: (context, index) {
                final player = _players[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF121212),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(radius: 20, backgroundColor: Color(0xFF1A1A1A), child: Icon(Icons.person, color: goldColor, size: 20)),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(player['name'], style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                            if (!widget.isUpcoming)
                              Row(
                                children: [
                                  Icon(Icons.star, color: goldColor, size: 12),
                                  const SizedBox(width: 4),
                                  Text('${player['rating']}', style: const TextStyle(color: Colors.white38, fontSize: 11)),
                                ],
                              ),
                          ],
                        ),
                      ),
                      if (!widget.isUpcoming) ...[
                        Text(player['attended'] ? 'PRESENT' : 'ABSENT', 
                          style: TextStyle(color: player['attended'] ? Colors.greenAccent : Colors.redAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 10),
                        Switch(
                          value: player['attended'], 
                          activeColor: Colors.greenAccent,
                          onChanged: (val) => setState(() => player['attended'] = val),
                        ),
                      ] else 
                        const Icon(Icons.check_circle_outline, color: Colors.white10),
                    ],
                  ),
                );
              },
            ),
          ),
          if (!widget.isUpcoming)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: goldColor,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('SAVE EVALUATIONS', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
        ],
      ),
    );
  }
}

class _CreateGameFormState extends State<_CreateGameForm> {
  String? _selectedTeam = 'CORE FC';
  String? _selectedOpponent;
  int _playerLimit = 11;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final List<String> _invitedPlayers = [];
  final List<String> _mySquadPlayers = [
    'Sunil Chhetri', 'Gurpreet Singh', 'Sandesh Jhingan', 'Ashique K', 
    'Sahal Abdul', 'Anirudh Thapa', 'Pritam Kotal', 'Subhasish Bose',
    'L. Chhangte', 'Apuia Ralte', 'Naorem Mahesh'
  ];
  final List<String> _allSearchablePlayers = ['Liston Colaco', 'Manvir Singh', 'Vishal Kaith', 'Hugo Boumous'];
  final TextEditingController _inviteIdController = TextEditingController();

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFD4AF37),
              onPrimary: Colors.black,
              surface: Color(0xFF1A1A1A),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFD4AF37),
              onPrimary: Colors.black,
              surface: Color(0xFF1A1A1A),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0D0D0D),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 24, right: 24, top: 24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 20),
            const Text('ORGANIZE NEW MATCH',
                style: TextStyle(color: goldColor, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: 1)),
            const SizedBox(height: 25),
            
            _buildBeautifulDropdown('YOUR TEAM', ['CORE FC', 'Bengal Warriors', 'Goa Giants'], _selectedTeam, (v) => setState(() => _selectedTeam = v)),
            const SizedBox(height: 16),
            _buildBeautifulDropdown('SELECT OPPONENT', ['Mohun Bagan', 'East Bengal', 'Mumbai City'], _selectedOpponent, (v) => setState(() => _selectedOpponent = v)),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: _buildDateTimePicker(
                    'DATE', 
                    _selectedDate == null ? 'Select Date' : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}', 
                    Icons.calendar_today, 
                    _pickDate
                  )
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDateTimePicker(
                    'TIME', 
                    _selectedTime == null ? 'Select Time' : _selectedTime!.format(context), 
                    Icons.access_time, 
                    _pickTime
                  )
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(child: _buildBeautifulDropdown('SQUAD LIMIT (11-25)', 
                  List.generate(15, (index) => (index + 11).toString()), 
                  _playerLimit.toString(), (v) => setState(() => _playerLimit = int.parse(v!)))),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('SELECTED', style: TextStyle(color: Colors.white38, fontSize: 10)),
                        Text('${_invitedPlayers.length}/$_playerLimit', style: const TextStyle(color: goldColor, fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 25),
            const Text('SELECT FROM YOUR SQUAD', style: TextStyle(color: Colors.white60, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
            const SizedBox(height: 10),
            Container(
              height: 200,
              decoration: BoxDecoration(color: const Color(0xFF121212), borderRadius: BorderRadius.circular(15)),
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _mySquadPlayers.length,
                itemBuilder: (context, index) {
                  final p = _mySquadPlayers[index];
                  final isSelected = _invitedPlayers.contains(p);
                  return CheckboxListTile(
                    title: Text(p, style: const TextStyle(color: Colors.white, fontSize: 13)),
                    value: isSelected,
                    activeColor: goldColor,
                    checkColor: Colors.black,
                    dense: true,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true && _invitedPlayers.length < _playerLimit) {
                          _invitedPlayers.add(p);
                        } else if (value == false) {
                          _invitedPlayers.remove(p);
                        }
                      });
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 25),
            const Text('SEARCH EXTRA PLAYERS', style: TextStyle(color: Colors.white60, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
            const SizedBox(height: 10),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '' || _invitedPlayers.length >= _playerLimit) return const Iterable<String>.empty();
                return _allSearchablePlayers.where((String option) => option.toLowerCase().contains(textEditingValue.text.toLowerCase()));
              },
              onSelected: (String selection) {
                if (!_invitedPlayers.contains(selection)) setState(() => _invitedPlayers.add(selection));
              },
              fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                return TextField(
                  controller: controller, focusNode: focusNode,
                  enabled: _invitedPlayers.length < _playerLimit,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search player name...',
                    hintStyle: const TextStyle(color: Colors.white24),
                    prefixIcon: const Icon(Icons.search, color: goldColor),
                    filled: true, fillColor: const Color(0xFF1A1A1A),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                  ),
                );
              },
            ),

            const SizedBox(height: 25),
            const Text('INVITE BY USER ID', style: TextStyle(color: Colors.white60, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _inviteIdController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter User ID...',
                      hintStyle: const TextStyle(color: Colors.white24),
                      filled: true, fillColor: const Color(0xFF1A1A1A),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    if (_inviteIdController.text.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invite sent to ${_inviteIdController.text}')));
                      _inviteIdController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: goldColor, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16)),
                  child: const Text('INVITE', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ],
            ),

            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _invitedPlayers.map((p) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10), border: Border.all(color: goldColor.withOpacity(0.3))),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(p, style: const TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 6),
                    GestureDetector(onTap: () => setState(() => _invitedPlayers.remove(p)), child: const Icon(Icons.close, size: 14, color: goldColor)),
                  ],
                ),
              )).toList(),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                backgroundColor: goldColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                elevation: 10, shadowColor: goldColor.withOpacity(0.3),
              ),
              child: const Text('SCHEDULE MATCH', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimePicker(String label, String value, IconData icon, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Icon(icon, color: goldColor, size: 16),
                const SizedBox(width: 10),
                Text(value, style: const TextStyle(color: Colors.white, fontSize: 14)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBeautifulDropdown(String label, List<String> items, String? val, Function(String?)? onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: val,
              isExpanded: true,
              dropdownColor: const Color(0xFF1A1A1A),
              style: const TextStyle(color: Colors.white, fontSize: 14),
              items: items.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
