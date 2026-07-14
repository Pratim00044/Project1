import 'package:flutter/material.dart';
import 'session_attendance_page.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DateTime _selectedDate = DateTime.parse('2024-07-12');
  final ScrollController _dateScrollController = ScrollController();

  final Map<String, Map<String, List<Map<String, dynamic>>>> _scheduleData = {
    '2024-07-12': {
      'sessions': [
        {'title': 'Under 8s Training', 'time': '09:00 AM', 'pitch': 'Pitch 1', 'attending': 8, 'pending': 2, 'max': 10, 'status': 'Open', 'color': Color(0xFF1E3A8A)},
        {'title': 'Under 12s Training', 'time': '11:00 AM', 'pitch': 'Pitch 3', 'attending': 12, 'pending': 3, 'max': 16, 'status': 'Open', 'color': Color(0xFF3730A3)},
        {'title': 'Under 16s Training', 'time': '02:00 PM', 'pitch': 'Main Pitch', 'attending': 9, 'pending': 5, 'max': 14, 'status': 'Later', 'color': Color(0xFF5B21B6)},
      ]
    },
    '2024-07-13': {
      'sessions': [
        {'title': 'Under 10s Skills', 'time': '04:00 PM', 'pitch': 'Pitch 2', 'attending': 10, 'pending': 4, 'max': 15, 'status': 'Open', 'color': Color(0xFF7C3AED)},
      ]
    },
  };

  @override
  void dispose() {
    _dateScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String dateKey = "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";
    var dailySchedule = _scheduleData[dateKey] ?? {'sessions': []};
    List sessions = dailySchedule['sessions']!;

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
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: _buildDateWheels(),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
            child: Text("TODAY'S SESSIONS — JUL ${_selectedDate.day}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5)),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final s = sessions[index];
              return _buildSessionCard(
                s['title'],
                s['time'],
                s['pitch'],
                s['status'],
                s['attending'],
                s['pending'],
                s['max'],
                s['color'],
              );
            },
            childCount: sessions.length,
          ),
        ),

        if (sessions.isEmpty)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: Center(
                child: Text('NO SCHEDULED SESSIONS', 
                  style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
              ),
            ),
          ),

        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeaderNormal('WORLD LEAGUES'),
              _buildForeignLeaguesSection(),
            ],
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildSectionHeader('ACADEMY RANKINGS'),
              const SizedBox(height: 15),
              _buildRankingSection(),
            ]),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 50)),
      ],
    );
  }

  Widget _buildCoachHeroCard() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFF007CFE),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF007CFE).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/coach.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text('LIONEL SCALONI',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 1)),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionCard(String title, String time, String pitch, String status, int attending, int pending, int max, Color bgColor) {
    double progress = attending / max;
    Color statusColor = status == 'Open' ? greenAccent : goldColor;

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SessionAttendancePage(
          sessionTitle: title,
          time: time,
          pitch: pitch,
          date: 'Jul ${_selectedDate.day}',
        )));
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(status, style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.white70, size: 14),
                      const SizedBox(width: 5),
                      Text(time, style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      const Text('•', style: TextStyle(color: Colors.white24)),
                      const SizedBox(width: 10),
                      const Icon(Icons.location_on_outlined, color: Colors.white70, size: 14),
                      const SizedBox(width: 5),
                      Text(pitch, style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMiniStat(attending.toString(), 'Attending', Colors.white),
                      _buildMiniStat(pending.toString(), 'Pending', Colors.white60),
                      _buildMiniStat(max.toString(), 'Max', Colors.white),
                    ],
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Container(height: 3, width: double.infinity, color: Colors.black.withOpacity(0.1)),
                FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(height: 3, decoration: BoxDecoration(color: goldColor, borderRadius: BorderRadius.circular(2))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniStat(String val, String label, Color color) {
    return Column(
      children: [
        Text(val, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w900)),
        Text(label, style: const TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildDateWheels() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('PICK A DATE',
            style: TextStyle(
                color: Colors.white38,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5)),
        const SizedBox(height: 20),
        Row(
          children: [
            _buildCircleArrow(Icons.chevron_left, () {
              _dateScrollController.animateTo(
                (_dateScrollController.offset - 85).clamp(0, _dateScrollController.position.maxScrollExtent),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut
              );
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
                    
                    int dots = index == 0 ? 2 : 1;

                    return GestureDetector(
                      onTap: () => setState(() => _selectedDate = date),
                      child: Container(
                        width: 80,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.transparent : surfaceColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? goldColor : Colors.white.withOpacity(0.05), 
                            width: 1.5
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(label,
                              style: TextStyle(
                                color: isSelected ? goldColor : Colors.white24, 
                                fontSize: 9, 
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5
                              )),
                            const SizedBox(height: 5),
                            Text(date.day.toString(),
                              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(dots, (i) => Container(
                                margin: const EdgeInsets.symmetric(horizontal: 2),
                                width: 4, height: 4,
                                decoration: const BoxDecoration(color: goldColor, shape: BoxShape.circle),
                              )),
                            ),
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
              _dateScrollController.animateTo(
                (_dateScrollController.offset + 85).clamp(0, _dateScrollController.position.maxScrollExtent),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildCircleArrow(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(color: goldColor, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.black, size: 20),
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
      {'name': 'SAUDI PRO LEAGUE', 'match': 'Al-Hilal vs Al-Ittihad', 'time': '20:30', 'color': const Color(0xFF007CFE)},
      {'name': 'UEFA CHAMPIONS LEAGUE', 'match': 'Core FC vs Dortmund', 'time': '18:00', 'color': const Color(0xFF38EF7D)},
    ];

    return Column(
      children: leagues.map((l) {
        final Color color = l['color'] as Color;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              const Icon(Icons.emoji_events_outlined, color: Colors.white, size: 20),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l['name'].toString(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900)),
                    Text(l['match'].toString(), style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Text(l['time'].toString(), style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 2)),
        const Icon(Icons.arrow_forward, color: goldColor, size: 16),
      ],
    );
  }

  Widget _buildRankingSection() {
    return Column(
      children: [
        _buildRankingItem('TOP GK', 'MANUEL NEUER', '98% Save Rate', const Color(0xFF38EF7D)),
        _buildRankingItem('TOP DEFENDER', 'SERGIO RAMOS', '45 Tackles', const Color(0xFF007CFE)),
      ],
    );
  }

  Widget _buildRankingItem(String category, String name, String stat, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 35, height: 35,
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.person, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category, style: const TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.bold)),
                Text(name, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Text(stat, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
