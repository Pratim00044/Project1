import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'create_training_page.dart';
import 'create_game_page.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);
const Color cardLightColor = Color(0xFFC0C0C0);

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DateTime _selectedDate = DateTime.now();
  late VideoPlayerController _videoController;

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildSmallDataBox(Icons.history, '12 Years', 'Experience', 'assets/images/Age.png'),
                const SizedBox(width: 12),
                _buildSmallDataBox(Icons.groups_rounded, 'Under 8s', 'Primary Squad', 'assets/images/Forward.png'),
                const SizedBox(width: 12),
                _buildSmallDataBox(Icons.analytics_outlined, 'A+ UEFA', 'License', 'assets/images/Attack.png'),
              ],
            ),
          ),
        ),

        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 35, 20, 15),
            child: Text('UPCOMING SESSIONS',
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
                _buildSharpDataBox(Icons.timer_outlined, '18:00 PM', 'TODAY', 'assets/images/league_green.png'),
                const SizedBox(width: 12),
                _buildSharpDataBox(Icons.fitness_center_rounded, 'Tactical', 'Type', 'assets/images/league_blue.png'),
                const SizedBox(width: 12),
                _buildSharpDataBox(Icons.location_on_outlined, 'Pitch 4', 'Location', 'assets/images/league_red.png'),
              ],
            ),
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
                _buildSharpDataBox(Icons.emoji_events_rounded, '12', 'TROPHIES', 'assets/images/league_gold.png'),
                const SizedBox(width: 12),
                _buildSharpDataBox(Icons.trending_up_rounded, '85%', 'WIN RATE', 'assets/images/league_blue.png'),
                const SizedBox(width: 12),
                _buildSharpDataBox(Icons.assignment_ind_rounded, '150', 'MANAGED', 'assets/images/league_green.png'),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateTrainingPage()));
              },
              icon: const Icon(Icons.add, color: Colors.black),
              label: const Text('SCHEDULE BESPOKE SESSION', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: goldColor,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
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
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionTile(context, Icons.sports_rounded, 'CREATE\nGAME', Colors.blueAccent, () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateGamePage()));
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
              _buildSectionHeader('MATCH SCHEDULE'),
              const SizedBox(height: 15),
              _buildUpcomingMatchItem('Mohun Bagan vs Kerala Blasters', 'ISL League', '02 JUL', '19:30'),
              _buildUpcomingMatchItem('Mohun Bagan vs East Bengal', 'Derby Friendly', '08 JUL', '18:00'),
              const SizedBox(height: 35),
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

  Widget _buildSessionList() {
    final sessions = [
      {'time': '6-7pm', 'age': 'Under 8s', 'location': 'Town Square - Una Pitch', 'players': '12'},
      {'time': '7-8pm', 'age': 'Under 10s', 'location': 'Town Square - Una Pitch', 'players': '15'},
    ];

    return Column(
      children: sessions.map((s) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.02)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: greenAccent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
              child: Text(s['time']!, style: const TextStyle(color: greenAccent, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s['age']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: Colors.white24, size: 12),
                      const SizedBox(width: 4),
                      Text(s['location']!, style: const TextStyle(color: Colors.white38, fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const Icon(Icons.people_outline, color: goldColor, size: 16),
                Text(s['players']!, style: const TextStyle(color: goldColor, fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildUpcomingMatchItem(String teams, String league, String date, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.02)),
        image: const DecorationImage(
          image: AssetImage('assets/images/match.png'),
          fit: BoxFit.cover,
          opacity: 0.1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), shape: BoxShape.circle),
            child: const Icon(Icons.sports_soccer, color: goldColor, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(teams, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(league, style: const TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(date, style: const TextStyle(color: goldColor, fontWeight: FontWeight.bold, fontSize: 12)),
              Text(time, style: const TextStyle(color: Colors.white38, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRankingSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withValues(alpha: 0.02)),
        image: const DecorationImage(
          image: AssetImage('assets/images/league_gold.png'),
          fit: BoxFit.cover,
          opacity: 0.1,
        ),
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
                  const SizedBox(height: 4),
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: goldColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: const Text('2024', style: TextStyle(color: goldColor, fontSize: 9, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 25),
          _buildRankingItem('TOP GK', 'Gurpreet Singh', 'Under 8s', '98% Save Rate', Colors.greenAccent),
          _buildRankingItem('TOP DEFENDER', 'Sandesh Jhingan', 'Under 10s', '45 Tackles', Colors.blueAccent),
          _buildRankingItem('TOP MIDFIELDER', 'Sahal Abdul', 'Under 8s', '12 Assists', Colors.purpleAccent),
          _buildRankingItem('TOP STRIKER', 'Sunil Chhetri', 'Under 8s', '24 Goals', Colors.orangeAccent),
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

  Widget _buildRankingItem(String category, String name, String team, String stat, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            width: 4, height: 35,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1)),
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
    );
  }

  Widget _buildAcademyList() {
    final academies = [
      {'name': 'Premier Academy', 'location': 'Town Square', 'rating': '4.8'},
      {'name': 'SOFA', 'location': 'Dubai Sports City', 'rating': '4.9'},
      {'name': 'Football Clinic', 'location': 'Jumeirah', 'rating': '4.7'},
    ];

    return Column(
      children: academies.map((a) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
            image: AssetImage('assets/images/login_background.jpeg'),
            fit: BoxFit.cover,
            opacity: 0.1,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 40, width: 40,
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.school_outlined, color: goldColor, size: 20),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(a['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text(a['location']!, style: const TextStyle(color: Colors.white38, fontSize: 11)),
                ],
              ),
            ),
            Row(
              children: [
                const Icon(Icons.star_rounded, color: goldColor, size: 14),
                const SizedBox(width: 4),
                Text(a['rating']!, style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      )).toList(),
    );
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
        color: cardLightColor,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: cardLightColor.withValues(alpha: 0.2),
            blurRadius: 40,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Stack(
          children: [
            if (_videoController.value.isInitialized)
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _videoController.value.size.width,
                    height: _videoController.value.size.height,
                    child: VideoPlayer(_videoController),
                  ),
                ),
              )
            else
              Container(color: cardLightColor),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    cardLightColor.withValues(alpha: 0.8),
                    cardLightColor.withValues(alpha: 0.2),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black.withValues(alpha: 0.05), width: 4),
                      color: surfaceColor,
                    ),
                    child: const Icon(Icons.person, size: 50, color: Colors.black38),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Coach',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'James',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              height: 1.0,
                              letterSpacing: -1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'ELITE ACADEMY',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                            ),
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
    );
  }

  Widget _buildSmallDataBox(IconData icon, String val, String sub, String bgImage) {
    return Expanded(
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          image: DecorationImage(
            image: AssetImage(bgImage),
            fit: BoxFit.cover,
            opacity: 0.3,
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: Colors.white24, size: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(val,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ),
                Text(sub,
                    style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 8,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSharpDataBox(IconData icon, String val, String sub, String bgImage) {
    return Expanded(
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          image: DecorationImage(
            image: AssetImage(bgImage),
            fit: BoxFit.cover,
            opacity: 0.4,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: Colors.white24, size: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(val,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold)),
                ),
                Text(sub,
                    style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 10,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ],
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
          color: surfaceColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withValues(alpha: 0.2)),
          image: const DecorationImage(
            image: AssetImage('assets/images/match.png'),
            fit: BoxFit.cover,
            opacity: 0.1,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withValues(alpha: 0.1), Colors.transparent],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 30),
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

  Widget _buildDatePicker() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 14,
        itemBuilder: (context, index) {
          final date = DateTime.now().add(Duration(days: index));
          final isSelected = date.day == _selectedDate.day && date.month == _selectedDate.month;
          final isToday = date.day == DateTime.now().day && date.month == DateTime.now().month;

          return GestureDetector(
            onTap: () => setState(() => _selectedDate = date),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 70,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: isSelected ? goldColor.withValues(alpha: 0.1) : surfaceColor,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                    color: isSelected ? goldColor : Colors.white.withValues(alpha: 0.05),
                    width: 1.5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      isToday
                          ? 'TODAY'
                          : ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'][date.weekday - 1],
                      style: TextStyle(
                          color: isSelected ? goldColor : Colors.white38,
                          fontSize: 9,
                          fontWeight: FontWeight.w900)),
                  const SizedBox(height: 5),
                  Text(date.day.toString(),
                      style: TextStyle(
                          color: isSelected ? Colors.white : Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.w900)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
