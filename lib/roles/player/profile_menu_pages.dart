import 'package:flutter/material.dart';
import 'player_home.dart';
import 'professional_pathway.dart';
import 'profile_details/attendance_detail.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class ProfessionalPathwayScreen extends StatelessWidget {
  const ProfessionalPathwayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('PROFESSIONAL PATHWAY', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 2)),
        foregroundColor: goldColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const ProfessionalPathwayPage(),
    );
  }
}

class PlayerMatchesScreen extends StatelessWidget {
  const PlayerMatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final matches = [
      {'date': 'TODAY', 'opp': 'Dubai City Football Club', 'score': '2 - 0', 'mins': '90\'', 'rating': '8.4', 'comp': 'PRO LEAGUE', 'logo': Icons.shield},
      {'date': 'TUE 30 JUN', 'opp': 'United Football Club', 'score': '1 - 1', 'mins': '120\'', 'rating': '7.2', 'comp': 'DUBAI CUP', 'logo': Icons.shield},
      {'date': 'FRI 26 JUN', 'opp': 'Eagle FC', 'score': '3 - 0', 'mins': '90\'', 'rating': '9.1', 'comp': 'PRO LEAGUE', 'logo': Icons.shield},
      {'date': 'SAT 20 JUN', 'opp': 'Emirates Club', 'score': '0 - 1', 'mins': '90\'', 'rating': '6.8', 'comp': 'FRIENDLY', 'logo': Icons.shield},
      {'date': 'SAT 13 JUN', 'opp': 'Gulf united FC', 'score': '4 - 1', 'mins': '90\'', 'rating': '8.7', 'comp': 'PRO LEAGUE', 'logo': Icons.shield},
    ];

    final List<List<Color>> colors = [
      [const Color(0xFF007CFE), const Color(0xFF004A99)],
      [const Color(0xFF38EF7D), const Color(0xFF11998E)],
      [const Color(0xFFEE0979), const Color(0xFFF12711)],
      [const Color(0xFFFFB75E), const Color(0xFFED8F03)],
      [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)],
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('MATCH HISTORY', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 2)),
        foregroundColor: goldColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final match = matches[index];
          final gradientColors = colors[index % colors.length];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 8),
                    child: Text(match['date'] as String, style: const TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 8),
                    child: Text(match['comp'] as String, style: const TextStyle(color: goldColor, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 25),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: gradientColors[0],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: gradientColors[0].withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      height: 40, width: 40,
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                      child: Icon(match['logo'] as IconData, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(match['opp'] as String, 
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900)),
                          const SizedBox(height: 2),
                          Text(match['score'] as String, style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(match['mins'] as String, style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(match['rating'] as String, style: TextStyle(color: gradientColors[1], fontSize: 12, fontWeight: FontWeight.w900)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PlayerStatsScreen extends StatelessWidget {
  final Map<String, dynamic>? playerStats;
  const PlayerStatsScreen({super.key, this.playerStats});

  @override
  Widget build(BuildContext context) {
    final stats = playerStats ?? {
      'shooting': '98',
      'passing': '88',
      'dribbling': '92',
      'defending': '45',
      'physical': '85',
      'saving': '10',
    };

    double getVal(String key) => (double.tryParse(stats[key]?.toString() ?? '0') ?? 0) / 100;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('PERFORMANCE STATS', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 2)),
        foregroundColor: goldColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Column(
          children: [
            _buildStarSkillRow(0, 'SHOOTING', getVal('shooting'), [const Color(0xFFFFB75E), const Color(0xFFED8F03)]),
            _buildStarSkillRow(1, 'PASSING', getVal('passing'), [const Color(0xFF007CFE), const Color(0xFF004A99)]),
            _buildStarSkillRow(2, 'DRIBBLING', getVal('dribbling'), [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)]),
            _buildStarSkillRow(3, 'DEFENDING', getVal('defending'), [const Color(0xFF38EF7D), const Color(0xFF11998E)]),
            _buildStarSkillRow(4, 'PHYSICAL', getVal('physical'), [const Color(0xFFEE0979), const Color(0xFFF12711)]),
            _buildStarSkillRow(5, 'SAVING', getVal('saving'), [const Color(0xFF00D2FF), const Color(0xFF3A7BD5)]),
          ],
        ),
      ),
    );
  }

  Widget _buildStarSkillRow(int index, String label, double progress, List<Color> colors) {
    int starCount = (progress * 5).round();
    final List<String> tileImages = [
      'assets/images/img1.jpeg',
      'assets/images/img2.jpeg',
      'assets/images/img3.jpeg',
      'assets/images/img4.jpeg',
    ];
    String currentImage = tileImages[index % tileImages.length];

    return Container(
      margin: const EdgeInsets.only(bottom: 12, left: 15, right: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: colors[0],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colors[0].withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('${(progress * 100).toInt()}% Proficiency', 
                    style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w900)),
                ),
              ],
            ),
          ),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < starCount ? Icons.star_rounded : Icons.star_outline_rounded,
                color: index < starCount ? goldColor : Colors.white.withValues(alpha: 0.3),
                size: 20,
              );
            }),
          ),
        ],
      ),
    );
  }
}

class PlayerFeedbackScreen extends StatelessWidget {
  const PlayerFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> themeVariations = [
      {'colors': [const Color(0xFF007CFE), const Color(0xFF004A99)]},
      {'colors': [const Color(0xFF38EF7D), const Color(0xFF11998E)]},
      {'colors': [const Color(0xFFEE0979), const Color(0xFFF12711)]},
      {'colors': [const Color(0xFFFFB75E), const Color(0xFFED8F03)]},
      {'colors': [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)]},
      {'colors': [const Color(0xFF00D2FF), const Color(0xFF3A7BD5)]},
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('COACH FEEDBACK', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 2)),
        foregroundColor: goldColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: List.generate(6, (index) {
            final theme = themeVariations[index % themeVariations.length];
            final gradientColors = theme['colors'] as List<Color>;
            String noteText = index % 2 == 0 
              ? 'Excellent work rate in the final third. Keep pressing the defenders. You have shown great improvement in your positioning during counter-attacks and your vision for long balls is exceptional.' 
              : 'Focus on transition speed during counter-attacks. Try to be more clinical in front of the goal when you receive a cross from the right wing. Your stamina is good, but work on explosive sprints.';
            
            return GestureDetector(
              onTap: () => _showFullFeedback(context, 'MATCH PERFORMANCE', noteText, gradientColors[0], Colors.white, '3rd JULY 2026'),
              child: Container(
                margin: const EdgeInsets.only(bottom: 15),
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: gradientColors[0],
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: gradientColors[0].withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('MATCH PERFORMANCE', 
                          style: const TextStyle(
                            color: Colors.white, 
                            fontSize: 14, 
                            fontWeight: FontWeight.w900, 
                            letterSpacing: 1.5,
                          )
                        ),
                        const Icon(Icons.push_pin_outlined, color: Colors.white24, size: 14),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      noteText, 
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white, 
                        fontSize: 13, 
                        fontWeight: FontWeight.w500, 
                        height: 1.5,
                      )
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.white54, size: 10),
                        SizedBox(width: 5),
                        Text('3rd JULY 2026', 
                          style: TextStyle(
                            color: Colors.white54, 
                            fontSize: 9, 
                            fontWeight: FontWeight.bold,
                          )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  void _showFullFeedback(BuildContext context, String title, String content, Color headingColor, Color bodyColor, String date) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: const Color(0xFF161616),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(35)),
          border: Border.all(color: headingColor.withValues(alpha: 0.2), width: 1.5),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0, right: 0,
              child: Opacity(
                opacity: 0.05,
                child: Icon(Icons.format_quote, size: 200, color: headingColor),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Center(child: Container(width: 45, height: 5, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10)))),
                const SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: headingColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(title, style: TextStyle(color: headingColor, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
                          ),
                          Text(date, style: const TextStyle(color: Colors.white24, fontSize: 11, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 25),
                      const Divider(color: Colors.white10, height: 1),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(30),
                    child: Text(
                      content,
                      style: TextStyle(
                        color: bodyColor, 
                        fontSize: 19, 
                        height: 1.8, 
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.3
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PlayerAttendanceScreen extends StatelessWidget {
  const PlayerAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<List<Color>> colors = [
      [const Color(0xFF38EF7D), const Color(0xFF11998E)],
      [const Color(0xFF007CFE), const Color(0xFF004A99)],
      [const Color(0xFFEE0979), const Color(0xFFF12711)],
      [const Color(0xFFFFB75E), const Color(0xFFED8F03)],
      [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)],
      [const Color(0xFF00D2FF), const Color(0xFF3A7BD5)],
    ];

    final attendance = [
      {'title': 'Training Session', 'date': '02 JUL 2024'},
      {'title': 'League Match', 'date': '30 JUN 2024'},
      {'title': 'Tactical Meeting', 'date': '28 JUN 2024'},
      {'title': 'Gym Session', 'date': '25 JUN 2024'},
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('ATTENDANCE HISTORY', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 2)),
        foregroundColor: goldColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildAttendanceStat('100%', 'RATE', colors[0])),
                const SizedBox(width: 8),
                Expanded(child: _buildAttendanceStat('45', 'PRESENT', colors[1])),
                const SizedBox(width: 8),
                Expanded(child: _buildAttendanceStat('0', 'ABSENT', colors[2])),
              ],
            ),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('RECENT ATTENDANCE', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AttendanceDetail())),
                  child: const Text('VIEW ALL', style: TextStyle(color: goldColor, fontSize: 11)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...List.generate(attendance.length, (index) {
              final record = attendance[index];
              return _buildAttendanceRecord(
                index,
                record['title']!, 
                record['date']!, 
                'PRESENT', 
                colors[(index + 3) % colors.length]
              );
            }),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceStat(String val, String label, List<Color> colors) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(val, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }

  Widget _buildAttendanceRecord(int index, String title, String date, String status, List<Color> colors) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors[0],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900)),
              const SizedBox(height: 4),
              Text(date, style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(status, style: TextStyle(color: colors[1], fontSize: 10, fontWeight: FontWeight.w900)),
          ),
        ],
      ),
    );
  }
}
