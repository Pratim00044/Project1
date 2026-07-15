import 'package:flutter/material.dart';
import 'player_home.dart';
import 'custom_painters.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF000000);
const Color surfaceColor = Color(0xFF121212);

class TeammateProfile extends StatefulWidget {
  final String? playerName;
  final String? playerNumber;
  final Map<String, dynamic>? playerStats;

  const TeammateProfile({
    super.key,
    this.playerName,
    this.playerNumber,
    this.playerStats,
  });

  @override
  State<TeammateProfile> createState() => _TeammateProfileState();
}

class _TeammateProfileState extends State<TeammateProfile> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String displayName = widget.playerName ?? 'LIONEL MESSI';
    final String displaySub = widget.playerNumber != null 
        ? '#${widget.playerNumber}' 
        : '#11';

    return Scaffold(
      backgroundColor: darkBg,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 320,
              pinned: false,
              toolbarHeight: 0,
              backgroundColor: darkBg,
              elevation: 0,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(color: darkBg),
                    Positioned(
                      top: 40,
                      left: 15,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: goldColor, width: 2),
                            boxShadow: [BoxShadow(color: goldColor.withValues(alpha: 0.2), blurRadius: 20)],
                          ),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/images/sunil.png'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(displayName.toUpperCase(),
                              maxLines: 1,
                              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: 1)),
                          ),
                        ),
                        const SizedBox(height: 6),
                        _buildHeaderPill(displaySub),
                        const SizedBox(height: 6),
                        Text('CLUB PLAYER', style: TextStyle(color: goldColor.withValues(alpha: 0.8), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: darkBg,
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: goldColor,
                  labelColor: goldColor,
                  unselectedLabelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 0.5),
                  unselectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.5),
                  tabs: const [
                    Tab(text: 'PROFILE'),
                    Tab(text: 'MATCHES'),
                    Tab(text: 'STATS'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Container(
          color: darkBg,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildProfileTab(),
              _buildMatchesTab(),
              _buildStatsTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderPill(String text, {bool isGold = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: isGold ? goldColor.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isGold ? goldColor.withValues(alpha: 0.3) : Colors.white10),
      ),
      child: Text(text, 
        style: TextStyle(color: isGold ? goldColor : Colors.white70, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
    );
  }

  Widget _buildProfileTab() {
    final stats = widget.playerStats ?? {
      'shooting': '98',
      'passing': '88',
      'dribbling': '92',
      'defending': '45',
      'physical': '85',
      'saving': '10',
    };

    double getVal(String key) => (double.tryParse(stats[key]?.toString() ?? '0') ?? 0) / 100;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 15),
            child: Text('PERSONAL DETAILS', 
              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
          ),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.9,
            children: [
              _buildModernTile(0, '170 cm', 'Height', Icons.height_rounded, [const Color(0xFF007CFE), const Color(0xFF004A99)]),
              _buildModernTile(1, '12 Years', 'Age', Icons.calendar_month_rounded, [const Color(0xFFFFB75E), const Color(0xFFED8F03)]),
              _buildModernTile(2, 'UAE', 'Nationality', Icons.public_rounded, [const Color(0xFF38EF7D), const Color(0xFF11998E)], emoji: '🇦🇪'),
              _buildModernTile(3, '11', 'Shirt #', Icons.format_list_numbered_rounded, [const Color(0xFF00D2FF), const Color(0xFF3A7BD5)]),
              _buildModernTile(4, 'Right', 'Foot', Icons.directions_run_rounded, [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)]),
              _buildModernTile(5, '#14', 'Rank', Icons.stars_rounded, [const Color(0xFFEE0979), const Color(0xFFF12711)]),
            ],
          ),
          
          const SizedBox(height: 25),
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 15),
            child: Text('PLAYER SKILL RADAR', 
              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Skill Traits', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    const Icon(Icons.analytics_rounded, color: goldColor, size: 20),
                  ],
                ),
                const Text('Comparing stats to regional averages', style: TextStyle(color: Colors.white38, fontSize: 11)),
                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    width: 240,
                    height: 240,
                    child: CustomPaint(
                      painter: RadarChartPainter(
                        stats: [
                          getVal('shooting'),
                          getVal('passing'),
                          getVal('dribbling'),
                          getVal('defending'),
                          getVal('physical'),
                          getVal('saving'),
                        ],
                        labels: [
                          'Shooting\n${(getVal('shooting') * 100).toInt()}%',
                          'Passing\n${(getVal('passing') * 100).toInt()}%',
                          'Dribbling\n${(getVal('dribbling') * 100).toInt()}%',
                          'Defending\n${(getVal('defending') * 100).toInt()}%',
                          'Physical\n${(getVal('physical') * 100).toInt()}%',
                          'Saving\n${(getVal('saving') * 100).toInt()}%',
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
          _buildPositionSection(),

          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildPositionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 15),
          child: Text('POSITION', 
            style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
        ),
        Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Primary', style: TextStyle(color: Color(0xFFE91E63), fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    const Text('Striker', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 25),
                    const Text('Others', style: TextStyle(color: Colors.white38, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('Attacking Midfielder', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    const Text('Right Winger', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 140,
                height: 180,
                child: CustomPaint(
                  painter: SoccerFieldPainter(
                    positions: [
                      {'pos': 'ST', 'x': 0.7, 'y': 0.15, 'primary': true},
                      {'pos': 'AM', 'x': 0.65, 'y': 0.45, 'primary': false},
                      {'pos': 'RW', 'x': 0.85, 'y': 0.35, 'primary': false},
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModernTile(int index, String val, String label, IconData icon, List<Color> colors, {String? emoji}) {
    final bgColor = colors[0];
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: bgColor.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 16),
            const SizedBox(height: 6),
            FittedBox(
              child: Row(
                children: [
                  if (emoji != null) Padding(padding: const EdgeInsets.only(right: 4), child: Text(emoji, style: const TextStyle(fontSize: 10))),
                  Text(val, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Text(label.toUpperCase(), style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 8, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchesTab() {
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

    return ListView.builder(
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
    );
  }

  Widget _buildStatsTab() {
    final stats = widget.playerStats ?? {
      'shooting': '98',
      'passing': '88',
      'dribbling': '92',
      'defending': '45',
      'physical': '85',
      'saving': '10',
    };

    double getVal(String key) => (double.tryParse(stats[key]?.toString() ?? '0') ?? 0) / 100;

    return SingleChildScrollView(
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
                  color: index < starCount ? Colors.white : Colors.white.withValues(alpha: 0.3),
                  size: 20,
                );
              }),
            ),
          ],
        ),
    );
  }
}
