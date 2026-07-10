import 'package:flutter/material.dart';
import 'create_training_page.dart';
import 'social_leagues.dart';
import 'create_game_page.dart';

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

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> with SingleTickerProviderStateMixin {
  late TabController _tab;
  DateTime _selectedDate = DateTime.parse('2024-06-10');
  final ScrollController _dateScrollController = ScrollController();

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
    String dayName = _selectedDate.day == 10 ? 'TODAY' : ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'][_selectedDate.weekday - 1];
    String monthName = ['JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'][_selectedDate.month - 1];

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: const Text('GAMES',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2)),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('PICK A DATE',
                    style: TextStyle(
                        color: Colors.white38,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5)),
                const SizedBox(height: 15),
                SizedBox(
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
                                    color: isSelected ? const Color(0xFF2ECC71) : Colors.transparent, 
                                    width: 2
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(label,
                                      style: TextStyle(
                                        color: isSelected ? const Color(0xFF2ECC71) : Colors.white24, 
                                        fontSize: 9, 
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 0.5
                                      )),
                                    const SizedBox(height: 5),
                                    Text(date.day.toString(),
                                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
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
                              color: const Color(0xFF1A1A1A),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                            ),
                            child: const Icon(Icons.chevron_left, color: Colors.white38, size: 18),
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
                              color: Color(0xFF2ECC71),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.chevron_right, color: Colors.black, size: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(dayName, style: const TextStyle(color: Color(0xFF2ECC71), fontSize: 14, fontWeight: FontWeight.w900)),
                    const SizedBox(width: 8),
                    const Text('•', style: TextStyle(color: Colors.white12)),
                    const SizedBox(width: 8),
                    Text('$monthName ${_selectedDate.day}', style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w900)),
                  ],
                ),
              ],
            ),
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
              tabs: const [Tab(text: 'MATCHES'), Tab(text: 'LEAGUES'), Tab(text: 'TRAINING')],
            ),
          ),
        ),
      ],
      body: TabBarView(
        controller: _tab,
        children: [
          _buildMatchTab(context),
          _buildLeagueTab(context),
          _buildTrainingTab(context),
        ],
      ),
    );
  }

  Widget _buildCreateButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [goldColor, goldColor.withValues(alpha: 0.7)]),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: goldColor.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 4))
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateTrainingPage())),
        icon: const Icon(Icons.add, size: 18, color: Colors.black),
        label: const Text('SCHEDULE',
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
        _buildLiveCard(context, 'REAL MADRID', 'BARCELONA', '2', '1', '78\'',
            'LA LIGA', cardColors[0]),
        const SizedBox(height: 30),
        _buildSectionTitle('UPCOMING FIXTURES'),
        const SizedBox(height: 15),
        LayoutBuilder(builder: (context, constraints) {
          double aspectRatio = constraints.maxWidth < 600 ? 1.1 : 1.5;
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
              _buildUpcomingBoxCard(context, 'CORE FC vs ARSENAL', 'JUL 02', '19:30',
                  'Premier League', 'Emirates Stadium', cardColors[1]),
              _buildUpcomingBoxCard(context, 'MAN CITY vs CORE FC', 'JUL 08', '20:00',
                  'Champions League', 'Etihad Stadium', cardColors[2]),
              _buildUpcomingBoxCard(context, 'CORE FC vs LIVERPOOL', 'JUL 15', '19:30',
                  'Premier League', 'Anfield', cardColors[3]),
              _buildUpcomingBoxCard(context, 'BAYERN MUNICH vs CORE FC', 'JUL 22', '18:00',
                  'Champions League', 'Allianz Arena', cardColors[4]),
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
          double aspectRatio = constraints.maxWidth < 600 ? 1.1 : 1.5;
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
              _buildLeagueBoxCard('Champions League', 'Europe', '32 Teams', 'IN PROGRESS', Icons.emoji_events, color: cardColors[5]),
              _buildLeagueBoxCard('Premier League', 'England', '20 Teams', 'REGISTRATION OPEN', Icons.emoji_events, isGold: true, color: cardColors[6]),
              _buildLeagueBoxCard('La Liga', 'Spain', '20 Teams', 'UPCOMING', Icons.emoji_events, color: cardColors[7]),
              _buildLeagueBoxCard('Saudi Pro League', 'Saudi Arabia', '18 Teams', 'REGISTRATION OPEN', Icons.emoji_events, isGold: true, color: cardColors[0]),
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
        _buildTrainingCard(context, 'TACTICAL DRILLS', 'JUL 01', '08:00', 'Core Academy Pitch', isUpcoming: true, color: cardColors[1]),
        const SizedBox(height: 15),
        _buildTrainingCard(context, 'FITNESS TEST', 'JUL 03', '07:30', 'Main Stadium Gym', isUpcoming: true, color: cardColors[2]),
        
        const SizedBox(height: 35),
        _buildSectionTitle('PAST SESSIONS'),
        const SizedBox(height: 15),
        _buildTrainingCard(context, 'DEFENSIVE POSITIONING', 'JUN 28', '09:00', 'Pitch B', isUpcoming: false, color: cardColors[3]),
        const SizedBox(height: 15),
        _buildTrainingCard(context, 'SHOOTING PRACTICE', 'JUN 25', '16:00', 'Pitch A', isUpcoming: false, color: cardColors[4]),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget _buildTrainingCard(BuildContext context, String title, String date, String time, String venue, {required bool isUpcoming, required Color color}) {
    return GestureDetector(
      onTap: () => _showTrainingDetails(context, title, date, time, venue, isUpcoming),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withOpacity(0.2)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withOpacity(0.2), color.withOpacity(0.05)],
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
      String time, String l, Color color) {
    return GestureDetector(
      onTap: () => _showMatchDetails(context, t1, t2),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color, color.withOpacity(0.7)],
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
      BuildContext context, String t, String d, String time, String type, String v, Color color) {
    return GestureDetector(
      onTap: () => _showMatchDetails(context, t.split('vs')[0].trim(), t.split('vs')[1].trim()),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.2)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withOpacity(0.2), color.withOpacity(0.05)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 30, height: 30,
                  decoration: BoxDecoration(
                    color: goldColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.sports_soccer_rounded, color: goldColor, size: 16),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(d, style: const TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.bold)),
                    Text(time, style: const TextStyle(color: Colors.white38, fontSize: 10)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type.toUpperCase(), style: const TextStyle(color: goldColor, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                const SizedBox(height: 4),
                Text(t, 
                    style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Text(v, 
                    style: const TextStyle(color: Colors.white24, fontSize: 11), 
                    maxLines: 1, 
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeagueBoxCard(String n, String l, String t, String s, IconData icon, {bool isGold = false, required Color color}) {
    Color statusColor = s.contains('OPEN') ? Colors.greenAccent : (s.contains('PROGRESS') ? goldColor : Colors.white38);
    
    return GestureDetector(
      onTap: () => _showLeagueDetails(n, s),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isGold ? goldColor.withOpacity(0.3) : color.withOpacity(0.2)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(
                    color: (isGold ? goldColor : Colors.white10).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: isGold ? goldColor : Colors.white38, size: 16),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(s.contains('OPEN') ? 'OPEN' : s, 
                      style: TextStyle(color: statusColor, fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(n, 
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold), 
                    maxLines: 1, 
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(l, style: const TextStyle(color: Colors.white38, fontSize: 11)),
                const SizedBox(height: 2),
                Text(t, style: const TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
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
    return Container(
      color: Colors.black,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
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
    'REAL MADRID': [
      'Thibaut Courtois', 'Dani Carvajal', 'Eder Militao', 'Antonio Rudiger', 'Ferland Mendy',
      'Federico Valverde', 'Aurelien Tchouameni', 'Jude Bellingham', 'Rodrygo', 'Kylian Mbappe', 'Vinicius Jr'
    ],
    'BARCELONA': [
      'Marc-Andre ter Stegen', 'Jules Kounde', 'Pau Cubarsi', 'Inigo Martinez', 'Alejandro Balde',
      'Marc Casado', 'Pedri', 'Dani Olmo', 'Lamine Yamal', 'Robert Lewandowski', 'Raphinha'
    ],
    'CORE FC': [
      'Alisson Becker', 'Kyle Walker', 'Ruben Dias', 'Virgil van Dijk', 'Theo Hernandez',
      'Kevin De Bruyne', 'Rodri', 'Luka Modric', 'Mohamed Salah', 'Erling Haaland', 'Phil Foden'
    ],
    'ARSENAL': [
      'David Raya', 'Ben White', 'William Saliba', 'Gabriel Magalhaes', 'Riccardo Calafiori',
      'Declan Rice', 'Thomas Partey', 'Martin Odegaard', 'Bukayo Saka', 'Kai Havertz', 'Gabriel Martinelli'
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
    {'name': 'Cristiano Ronaldo', 'attended': true, 'rating': 4.5},
    {'name': 'Luka Modric', 'attended': true, 'rating': 4.0},
    {'name': 'Kevin De Bruyne', 'attended': false, 'rating': 0.0},
    {'name': 'Virgil van Dijk', 'attended': true, 'rating': 3.5},
    {'name': 'Alisson Becker', 'attended': true, 'rating': 5.0},
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
                    color: cardColors[index % cardColors.length].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: cardColors[index % cardColors.length].withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20, 
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage('assets/images/sunil.png'),
                      ),
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

