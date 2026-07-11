import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'create_training_page.dart';
import 'create_game_page.dart';
import 'coach_notifications_page.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);
const Color cardLightColor = Color(0xFFC0C0C0);

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

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DateTime _selectedDate = DateTime.parse('2024-06-10');
  late VideoPlayerController _videoController;
  final ScrollController _dateScrollController = ScrollController();

  final Map<String, Map<String, List<Map<String, String>>>> _scheduleData = {
    '2024-06-10': {
      'matches': [
        {'teams': 'CORE FC vs REAL MADRID', 'league': 'CHAMPIONS LEAGUE', 'time': '06:00 PM'},
      ],
      'sessions': [
        {'title': 'TACTICAL DRILLS', 'category': 'TRAINING', 'time': '04:00 PM'},
        {'title': 'YOUTH DEVELOPMENT', 'category': 'ACADEMY', 'time': '05:30 PM'},
      ]
    },
    '2024-06-11': {
      'matches': [
        {'teams': 'BAYERN MUNICH vs CORE FC', 'league': 'EUROPA LEAGUE', 'time': '08:30 PM'},
      ],
      'sessions': [
        {'title': 'FITNESS & AGILITY', 'category': 'TRAINING', 'time': '08:00 AM'},
      ]
    },
    '2024-06-12': {
      'matches': [],
      'sessions': [
        {'title': 'GOALKEEPER TRAINING', 'category': 'TRAINING', 'time': '09:00 AM'},
        {'title': 'U12 TECHNICAL SKILLS', 'category': 'ACADEMY', 'time': '04:30 PM'},
      ]
    },
  };

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/Video/Banner.mp4')
      ..initialize().then((_) {
        setState(() {});
        _videoController.setLooping(true);
        _videoController.setVolume(0);
        _videoController.play();
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String dateKey = "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";
    var dailySchedule = _scheduleData[dateKey] ?? {'matches': [], 'sessions': []};

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: _buildCoachHeroCard(),
          ),
        ),

        SliverToBoxAdapter(
          child: _buildNotificationBanner(context),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildGradientStatTile(0, Icons.history, '12 Years', 'Experience', [const Color(0xFF007CFE), const Color(0xFF004A99)]),
                const SizedBox(width: 12),
                _buildGradientStatTile(1, Icons.groups_rounded, 'Under 8s', 'Primary Squad', [const Color(0xFF38EF7D), const Color(0xFF11998E)]),
                const SizedBox(width: 12),
                _buildGradientStatTile(2, Icons.analytics_outlined, 'A+ UEFA', 'License', [const Color(0xFFEE0979), const Color(0xFFF12711)]),
              ],
            ),
          ),
        ),

        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 35, 20, 10),
            child: Text('GAME',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2)),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: _buildDateWheels(),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: _buildCreateMatchSectionCoach(context),
          ),
        ),

        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        if (dailySchedule['matches']!.isNotEmpty) ...[
          _buildSectionHeaderNormal('UPCOMING MATCHES'),
          ...dailySchedule['matches']!.asMap().entries.map((entry) => _buildUpcomingMatchItem(entry.value['teams']!, entry.value['league']!, '${_selectedDate.day}/${_selectedDate.month}', entry.value['time']!, cardColors[entry.key % cardColors.length])),
        ],
        
        if (dailySchedule['sessions']!.isNotEmpty) ...[
          _buildSectionHeaderNormal('UPCOMING SESSIONS'),
          ...dailySchedule['sessions']!.asMap().entries.map((entry) => _buildUpcomingSessionItem(entry.value['title']!, entry.value['category']!, '${_selectedDate.day}/${_selectedDate.month}', entry.value['time']!, cardColors[(entry.key + 2) % cardColors.length])),
        ],

              if (dailySchedule['matches']!.isEmpty && dailySchedule['sessions']!.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(40),
                  child: Center(
                    child: Text('NO SCHEDULED ACTIVITIES FOR THIS DAY', 
                      style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  ),
                ),
              
              _buildSectionHeaderNormal('MATCH SECTION'),
              _buildForeignLeaguesSection(),
            ],
          ),
        ),

        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 35, 20, 15),
            child: Text('PAST PERFORMANCE',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2)),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildGradientStatTile(3, Icons.emoji_events_rounded, '12', 'TROPHIES', [const Color(0xFFFFB75E), const Color(0xFFED8F03)]),
                const SizedBox(width: 12),
                _buildGradientStatTile(4, Icons.trending_up_rounded, '85%', 'WIN RATE', [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)]),
                const SizedBox(width: 12),
                _buildGradientStatTile(5, Icons.assignment_ind_rounded, '150', 'MANAGED', [const Color(0xFF00D2FF), const Color(0xFF3A7BD5)]),
              ],
            ),
          ),
        ),


        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 15),
            child: Text('QUICK ACTIONS',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2)),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: _buildActionTile(context, Icons.add_task_rounded, 'CREATE\nSESSION', goldColor, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateTrainingPage()));
                  }),
                ),
              ],
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildSectionHeader('ACADEMY RANKINGS'),
              const SizedBox(height: 15),
              _buildRankingSection(),
              const SizedBox(height: 35),
              _buildSectionHeader('ACADEMY DIRECTORY'),
              const SizedBox(height: 15),
              _buildAcademyList(),
            ]),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 50)),
      ],
    );
  }

  Widget _buildCreateMatchSectionCoach(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateGamePage())),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: goldColor.withValues(alpha: 0.3)),
          image: const DecorationImage(
            image: AssetImage('assets/images/img1.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.sports_soccer_rounded, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 20),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CREATE NEW MATCH', 
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1)),
                  SizedBox(height: 4),
                  Text('Schedule custom games & manage squads', 
                    style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeaderNormal(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
      child: Text(title,
          style: const TextStyle(
              color: Colors.white38,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5)),
    );
  }

  Widget _buildForeignLeaguesSection() {
    final leagues = [
      {'name': 'SAUDI PRO LEAGUE', 'match': 'Al-Hilal vs Al-Ittihad', 'time': '20:30'},
      {'name': 'UEFA CHAMPIONS LEAGUE', 'match': 'Core FC vs Dortmund', 'time': '18:00'},
      {'name': 'LA LIGA', 'match': 'Real Madrid vs Barcelona', 'time': '22:00'},
      {'name': 'PREMIER LEAGUE', 'match': 'Man City vs Arsenal', 'time': '19:30'},
    ];

    return Column(
      children: leagues.asMap().entries.map((entry) {
        final int index = entry.key;
        final Map<String, String> l = entry.value;
        final Color color = cardColors[index % cardColors.length];
        
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: color.withOpacity(0.2)),
            image: DecorationImage(
              image: AssetImage('assets/images/img${(index % 4) + 1}.jpeg'),
              fit: BoxFit.cover,
              colorFilter: const ColorFilter.mode(Colors.black38, BlendMode.darken),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 32, height: 32,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Icon(Icons.emoji_events_outlined, color: color, size: 16),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l['name']!.toUpperCase(), style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
                    const SizedBox(height: 4),
                    Text(l['match']!, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Text(l['time']!, style: const TextStyle(color: Colors.white38, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUpcomingMatchItem(String teams, String league, String date, String time, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.2)),
        image: const DecorationImage(
          image: AssetImage('assets/images/img1.jpeg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.sports_soccer_rounded, color: color, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(teams, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(league, style: const TextStyle(color: Colors.white38, fontSize: 10)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(date, style: const TextStyle(color: goldColor, fontWeight: FontWeight.bold, fontSize: 11)),
              Text(time, style: const TextStyle(color: Colors.white38, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingSessionItem(String title, String category, String date, String time, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.2)),
        image: const DecorationImage(
          image: AssetImage('assets/images/img2.jpeg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
            child: Icon(category == 'TRAINING' ? Icons.fitness_center_rounded : Icons.school_outlined, color: color, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(category, style: const TextStyle(color: Colors.white38, fontSize: 10)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(date, style: const TextStyle(color: greenAccent, fontWeight: FontWeight.bold, fontSize: 11)),
              Text(time, style: const TextStyle(color: Colors.white38, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateWheels() {
    String dayName = _selectedDate.day == 10 ? 'TODAY' : ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'][_selectedDate.weekday - 1];
    String monthName = ['JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'][_selectedDate.month - 1];
    
    return Column(
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
                      color: greenAccent,
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
        ),
      ],
    );
  }

  Widget _buildRankingSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('ACADEMY RANKINGS', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildAwardTypePill('WEEK'),
                      const SizedBox(width: 8),
                      _buildAwardTypePill('MONTH'),
                      const SizedBox(width: 8),
                      _buildAwardTypePill('TERM', isActive: true),
                      const SizedBox(width: 8),
                      _buildAwardTypePill('SEASON'),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: goldColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: const Text('2024', style: TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 25),
          _buildRankingItem('TOP GK', 'MANUEL NEUER', 'Under 8s', '98% Save Rate', [const Color(0xFF38EF7D), const Color(0xFF11998E)], 0),
          _buildRankingItem('TOP DEFENDER', 'SERGIO RAMOS', 'Under 10s', '45 Tackles', [const Color(0xFF007CFE), const Color(0xFF004A99)], 1),
          _buildRankingItem('TOP MIDFIELDER', 'LUKA MODRIC', 'Under 8s', '12 Assists', [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)], 2),
          _buildRankingItem('TOP STRIKER', 'CRISTIANO RONALDO', 'Under 8s', '24 Goals', [const Color(0xFFEE0979), const Color(0xFFF12711)], 3),
        ],
      ),
    );
  }

  Widget _buildAwardTypePill(String label, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isActive ? goldColor : Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: TextStyle(color: isActive ? Colors.black : Colors.white38, fontSize: 7, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildRankingItem(String category, String name, String team, String stat, List<Color> colors, int index) {
    IconData icon;
    switch (category) {
      case 'TOP GK': icon = Icons.security_rounded; break;
      case 'TOP DEFENDER': icon = Icons.shield_rounded; break;
      case 'TOP MIDFIELDER': icon = Icons.settings_input_component_rounded; break;
      case 'TOP STRIKER': icon = Icons.ads_click_rounded; break;
      default: icon = Icons.person_rounded;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          image: DecorationImage(
            image: AssetImage('assets/images/img${(index % 4) + 1}.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 35, height: 35,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category, style: TextStyle(color: colors[0], fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  Text(name, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(team, style: const TextStyle(color: Colors.white38, fontSize: 10)),
                Text(stat, style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAcademyList() {
    final academies = [
      {'name': 'Premier Academy', 'location': 'Town Square', 'rating': '4.8'},
      {'name': 'SOFA', 'location': 'Dubai Sports City', 'rating': '4.9'},
      {'name': 'Football Clinic', 'location': 'Jumeirah', 'rating': '4.7'},
    ];

    return Column(
      children: academies.asMap().entries.map((entry) {
        final int index = entry.key;
        final Map<String, String> a = entry.value;
        final List<Color> cardColors = _getVibrantGradients(index);
        
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: cardColors.first.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 4))
            ],
            image: DecorationImage(
              image: AssetImage('assets/images/img${(index % 4) + 1}.jpeg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
            ),
          ),
          child: Row(
            children: [
              Container(
                height: 35, width: 35,
                decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.school_outlined, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(a['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text(a['location']!, style: const TextStyle(color: Colors.white70, fontSize: 11)),
                  ],
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star_rounded, color: Colors.white, size: 14),
                  const SizedBox(width: 4),
                  Text(a['rating']!, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNotificationBanner(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CoachNotificationsPage())),
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: goldColor.withValues(alpha: 0.1), width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: goldColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.notifications_active_rounded, color: goldColor, size: 22),
            ),
            const SizedBox(width: 15),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('NEW MATCH CREATED', 
                    style: TextStyle(color: goldColor, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1)),
                  SizedBox(height: 4),
                  Text('Lionel Scaloni has scheduled a new league match.',
                    style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: goldColor, size: 14),
          ],
        ),
      ),
    );
  }

  List<Color> _getVibrantGradients(int index) {
    const gradients = [
      [Color(0xFF007CFE), Color(0xFF004A99)],
      [Color(0xFF38EF7D), Color(0xFF11998E)],
      [Color(0xFFEE0979), Color(0xFFF12711)],
      [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
      [Color(0xFFF093FB), Color(0xFFF5576C)],
      [Color(0xFFFFB75E), Color(0xFFED8F03)],
      [Color(0xFF00C6FF), Color(0xFF0072FF)],
      [Color(0xFF56CCF2), Color(0xFF2F80ED)],
      [Color(0xFFF2994A), Color(0xFFF2C94C)],
      [Color(0xFFB3FFAB), Color(0xFF12FFF7)],
    ];
    return gradients[index % gradients.length];
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 2)),
        const Icon(Icons.arrow_forward, color: Color(0xFFD4AF37), size: 16),
      ],
    );
  }

  Widget _buildCoachHeroCard() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: const DecorationImage(
          image: AssetImage('assets/images/img2.jpeg'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black.withValues(alpha: 0.1),
                  Colors.black.withValues(alpha: 0.8),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 2.5),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/coach.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome back,',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          shadows: [
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.5),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                      ),
                      Text(
                        'LIONEL SCALONI',
                        style: TextStyle(
                          color: goldColor,
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          height: 1.0,
                          letterSpacing: -0.5,
                          shadows: [
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.5),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'ACADEMY COACH',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                          shadows: [
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.5),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: goldColor.withValues(alpha: 0.2)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.shield, size: 12, color: goldColor),
                            const SizedBox(width: 6),
                            const Text(
                              'CORE FC - U8',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientStatTile(int index, IconData icon, String val, String label, List<Color> colors) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.8,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage('assets/images/img${(index % 4) + 1}.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.1),
                  Colors.black.withValues(alpha: 0.6),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 24),
                const SizedBox(height: 6),
                FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      val,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        shadows: [Shadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 4)],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionTile(BuildContext context, IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withValues(alpha: 0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(height: 12),
            Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1)),
          ],
        ),
      ),
    );
  }
}
