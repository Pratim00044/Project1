import 'package:flutter/material.dart';
import 'create_training_page.dart';
import 'social_leagues.dart';
import 'create_game_page.dart';
import 'player_detail_page.dart';

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
        _buildSectionTitle('LAST MATCHES'),
        const SizedBox(height: 15),
        _buildLiveCard(context, 'REAL MADRID', 'BARCELONA', '2', '1', '78\'',
            'LA LIGA', cardColors[0], 'assets/images/img1.jpeg'),
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
                  'Premier League', 'Emirates Stadium', cardColors[1], 'assets/images/img2.jpeg'),
              _buildUpcomingBoxCard(context, 'MAN CITY vs CORE FC', 'JUL 08', '20:00',
                  'Champions League', 'Etihad Stadium', cardColors[2], 'assets/images/img3.jpeg'),
              _buildUpcomingBoxCard(context, 'CORE FC vs LIVERPOOL', 'JUL 15', '19:30',
                  'Premier League', 'Anfield', cardColors[3], 'assets/images/img4.jpeg'),
              _buildUpcomingBoxCard(context, 'BAYERN MUNICH vs CORE FC', 'JUL 22', '18:00',
                  'Champions League', 'Allianz Arena', cardColors[4], 'assets/images/img1.jpeg'),
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
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFF2ECC71).withValues(alpha: 0.2)),
              image: const DecorationImage(
                image: AssetImage('assets/images/img2.jpeg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
              ),
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
              _buildLeagueBoxCard('Champions League', 'Europe', '32 Teams', 'IN PROGRESS', Icons.emoji_events, color: cardColors[5], imagePath: 'assets/images/img3.jpeg'),
              _buildLeagueBoxCard('Premier League', 'England', '20 Teams', 'REGISTRATION OPEN', Icons.emoji_events, isGold: true, color: cardColors[6], imagePath: 'assets/images/img4.jpeg'),
              _buildLeagueBoxCard('La Liga', 'Spain', '20 Teams', 'UPCOMING', Icons.emoji_events, color: cardColors[7], imagePath: 'assets/images/img1.jpeg'),
              _buildLeagueBoxCard('Saudi Pro League', 'Saudi Arabia', '18 Teams', 'REGISTRATION OPEN', Icons.emoji_events, isGold: true, color: cardColors[0], imagePath: 'assets/images/img2.jpeg'),
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
        _buildTrainingCard(context, 'TACTICAL DRILLS', 'JUL 01', '08:00', 'Core Academy Pitch', isUpcoming: true, color: cardColors[1], imagePath: 'assets/images/img3.jpeg'),
        const SizedBox(height: 15),
        _buildTrainingCard(context, 'FITNESS TEST', 'JUL 03', '07:30', 'Main Stadium Gym', isUpcoming: true, color: cardColors[2], imagePath: 'assets/images/img4.jpeg'),
        
        const SizedBox(height: 35),
        _buildSectionTitle('PAST SESSIONS'),
        const SizedBox(height: 15),
        _buildTrainingCard(context, 'DEFENSIVE POSITIONING', 'JUN 28', '09:00', 'Pitch B', isUpcoming: false, color: cardColors[3], imagePath: 'assets/images/img1.jpeg'),
        const SizedBox(height: 15),
        _buildTrainingCard(context, 'SHOOTING PRACTICE', 'JUN 25', '16:00', 'Pitch A', isUpcoming: false, color: cardColors[4], imagePath: 'assets/images/img2.jpeg'),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget _buildTrainingCard(BuildContext context, String title, String date, String time, String venue, {required bool isUpcoming, required Color color, required String imagePath}) {
    return GestureDetector(
      onTap: () => _showTrainingDetails(context, title, date, time, venue, isUpcoming),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withOpacity(0.2)),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
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
      String time, String l, Color color, String imagePath) {
    return GestureDetector(
      onTap: () => _showMatchDetails(context, t1, t2),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(color.withOpacity(0.3), BlendMode.darken),
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
      BuildContext context, String t, String d, String time, String type, String v, Color color, String imagePath) {
    return GestureDetector(
      onTap: () => _showMatchDetails(context, t.split('vs')[0].trim(), t.split('vs')[1].trim()),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.2)),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
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

  Widget _buildLeagueBoxCard(String n, String l, String t, String s, IconData icon, {bool isGold = false, required Color color, required String imagePath}) {
    Color statusColor = s.contains('OPEN') ? Colors.greenAccent : (s.contains('PROGRESS') ? goldColor : Colors.white38);
    
    return GestureDetector(
      onTap: () => _showLeagueDetails(n, s),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isGold ? goldColor.withOpacity(0.3) : color.withOpacity(0.2)),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
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
    'BARCELONA': [
      {'name': 'Marc-Andre ter Stegen', 'no': '1', 'pos': 'GK'},
      {'name': 'Jules Kounde', 'no': '2', 'pos': 'RB'},
      {'name': 'Pau Cubarsi', 'no': '3', 'pos': 'CB'},
      {'name': 'Inigo Martinez', 'no': '4', 'pos': 'CB'},
      {'name': 'Alejandro Balde', 'no': '5', 'pos': 'LB'},
      {'name': 'Marc Casado', 'no': '6', 'pos': 'CM'},
      {'name': 'Pedri', 'no': '7', 'pos': 'CM'},
      {'name': 'Dani Olmo', 'no': '8', 'pos': 'AM'},
      {'name': 'Lamine Yamal', 'no': '9', 'pos': 'RW'},
      {'name': 'Raphinha', 'no': '10', 'pos': 'LW'},
      {'name': 'R. Lewandowski', 'no': '11', 'pos': 'ST'},
    ],
    'REAL MADRID': [
      {'name': 'T. Courtois', 'no': '1', 'pos': 'GK'},
      {'name': 'Dani Carvajal', 'no': '2', 'pos': 'RB'},
      {'name': 'Eder Militao', 'no': '3', 'pos': 'CB'},
      {'name': 'A. Rudiger', 'no': '4', 'pos': 'CB'},
      {'name': 'Ferland Mendy', 'no': '5', 'pos': 'LB'},
      {'name': 'F. Valverde', 'no': '6', 'pos': 'CM'},
      {'name': 'A. Tchouameni', 'no': '7', 'pos': 'CM'},
      {'name': 'J. Bellingham', 'no': '8', 'pos': 'AM'},
      {'name': 'Rodrygo', 'no': '9', 'pos': 'RW'},
      {'name': 'K. Mbappe', 'no': '10', 'pos': 'LW'},
      {'name': 'Vinicius Jr', 'no': '11', 'pos': 'ST'},
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
            width: double.infinity,
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
                        builder: (context) => PlayerDetailPage(
                          playerName: player['name'],
                          position: player['pos'],
                          playerNumber: player['no'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF121212),
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

