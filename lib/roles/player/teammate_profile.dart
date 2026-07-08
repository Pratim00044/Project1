import 'package:flutter/material.dart';
import 'custom_painters.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class TeammateProfile extends StatefulWidget {
  final String? playerName;
  final String? playerPosition;
  final String? playerNumber;
  final Map<String, dynamic>? playerStats;

  const TeammateProfile({
    super.key,
    this.playerName,
    this.playerPosition,
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
    final String displayName = widget.playerName ?? 'SUNIL CHHETRI';
    final String displaySub = widget.playerPosition != null && widget.playerNumber != null 
        ? '${widget.playerPosition} | #${widget.playerNumber}' 
        : 'FORWARD | #11';

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Core FC Theme .jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 320,
                pinned: true,
                backgroundColor: const Color(0xFF0D0D0D),
                elevation: 0,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset('assets/images/login_background.jpeg', fit: BoxFit.cover),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, darkBg.withValues(alpha: 0.6), darkBg],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: goldColor, width: 2),
                              boxShadow: [BoxShadow(color: goldColor.withValues(alpha: 0.2), blurRadius: 20)],
                            ),
                            child: const CircleAvatar(
                              radius: 55,
                              backgroundImage: AssetImage('assets/images/sunil.png'),
                            ),
                          ),
                          const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(displayName.toUpperCase(),
                              maxLines: 1,
                              style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900, letterSpacing: 1)),
                          ),
                        ),
                        const SizedBox(height: 8),
                          _buildHeaderPill(displaySub),
                          const SizedBox(height: 10),
                          const Text('UNDER 8s', style: TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.transparent,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: false,
                    tabAlignment: TabAlignment.fill,
                    indicatorColor: goldColor,
                    labelColor: goldColor,
                    unselectedLabelColor: Colors.white38,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 0.5),
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
          body: TabBarView(
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
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _buildFotMobInfo('170 cm', 'Height')),
                    Expanded(child: _buildFotMobInfo('39 years', '24 Jun 1987')),
                    Expanded(child: _buildFotMobInfo('ARG', 'Country', flag: true)),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _buildFotMobInfo('11', 'Shirt')),
                    Expanded(child: _buildFotMobInfo('Right', 'Preferred foot')),
                    Expanded(child: _buildFotMobInfo('#14', 'Global Rank', isGold: true)),
                  ],
                ),
                const SizedBox(height: 25),
                const Divider(color: Colors.white10),
                const SizedBox(height: 20),
                Center(
                  child: _buildFotMobInfo('₹1.4B', 'Estimated Market Value'),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 15),
          
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.shield, color: goldColor, size: 16),
                    const SizedBox(width: 8),
                    const Text('Major League 2024', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatCol('14', 'Matches'),
                    _buildStatCol('12', 'Goals'),
                    _buildStatCol('7', 'Assists'),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(color: const Color(0xFF2ECC71), borderRadius: BorderRadius.circular(8)),
                      child: const Text('8.47', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 13)),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Player traits', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    const Icon(Icons.help_outline, color: Colors.white24, size: 16),
                  ],
                ),
                const Text('Stats compared to other forwards', style: TextStyle(color: Colors.white38, fontSize: 11)),
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

          const SizedBox(height: 15),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Position', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Primary', style: TextStyle(color: const Color(0xFFE91E63), fontSize: 12, fontWeight: FontWeight.bold)),
                          Text(widget.playerPosition ?? 'Striker', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 25),
                          const Text('Others', style: TextStyle(color: Colors.white38, fontSize: 12, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          const Text('Attacking Midfielder', style: const TextStyle(color: Colors.white, fontSize: 14)),
                          const Text('Right Winger', style: const TextStyle(color: Colors.white, fontSize: 14)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 140,
                      height: 180,
                      child: CustomPaint(
                        painter: SoccerFieldPainter(positions: [
                          {'pos': 'ST', 'x': 0.5, 'y': 0.15, 'primary': true},
                          {'pos': 'AM', 'x': 0.5, 'y': 0.45, 'primary': false},
                          {'pos': 'RW', 'x': 0.8, 'y': 0.4, 'primary': false},
                        ]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildFotMobInfo(String val, String label, {bool flag = false, bool isGold = false}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (flag) const Icon(Icons.public, color: Colors.blueAccent, size: 14),
            if (flag) const SizedBox(width: 4),
            Text(val, style: TextStyle(color: isGold ? goldColor : Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 11)),
      ],
    );
  }

  Widget _buildStatCol(String val, String label) {
    return Column(
      children: [
        Text(val, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 11)),
      ],
    );
  }

  Widget _buildMatchesTab() {
    final matches = [
      {'date': 'Today', 'opp': 'Dubai City Football Club', 'score': '2 - 0', 'mins': '90\'', 'rating': '8.4', 'comp': 'PRO LEAGUE', 'logo': Icons.shield},
      {'date': 'Tue 30 Jun', 'opp': 'United Football Club', 'score': '1 - 1', 'mins': '120\'', 'rating': '7.2', 'comp': 'DUBAI CUP', 'logo': Icons.shield},
      {'date': 'Fri 26 Jun', 'opp': 'Eagle FC', 'score': '3 - 0', 'mins': '90\'', 'rating': '9.1', 'comp': 'PRO LEAGUE', 'logo': Icons.shield},
      {'date': 'Sat 20 Jun', 'opp': 'Emirates Club', 'score': '0 - 1', 'mins': '90\'', 'rating': '6.8', 'comp': 'FRIENDLY', 'logo': Icons.shield},
      {'date': 'Sat 13 Jun', 'opp': 'Gulf united FC', 'score': '4 - 1', 'mins': '90\'', 'rating': '8.7', 'comp': 'PRO LEAGUE', 'logo': Icons.shield},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];
        double rating = double.parse(match['rating'] as String);
        Color ratingColor = rating >= 8.0 ? const Color(0xFF2ECC71) : (rating >= 7.0 ? Colors.orangeAccent : Colors.redAccent);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index == 0) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.public, color: Colors.blueAccent, size: 14),
                    const SizedBox(width: 8),
                    const Text('UAE Pro League', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                  ],
                ),
              ),
              const SizedBox(height: 25),
            ],
            Row(
              children: [
                Text(match['date'] as String, style: const TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold)),
                const Spacer(),
                Text(match['comp'] as String, style: const TextStyle(color: Colors.white12, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1)),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.03),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(match['logo'] as IconData, color: goldColor.withValues(alpha: 0.5), size: 20),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(match['opp'] as String, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(match['score'] as String, style: const TextStyle(color: Colors.white38, fontSize: 13, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(match['mins'] as String, style: const TextStyle(color: Colors.white60, fontSize: 11, fontWeight: FontWeight.w900)),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 40,
                  height: 28,
                  decoration: BoxDecoration(
                    color: ratingColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [BoxShadow(color: ratingColor.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 2))],
                  ),
                  child: Center(
                    child: Text(match['rating'] as String, style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w900)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (index < matches.length - 1) 
              Divider(color: Colors.white.withValues(alpha: 0.05), height: 1, thickness: 1),
            const SizedBox(height: 20),
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
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildCompactSkillRow('SHOOTING', getVal('shooting'), Colors.orange),
          _buildCompactSkillRow('PASSING', getVal('passing'), Colors.blue),
          _buildCompactSkillRow('DRIBBLING', getVal('dribbling'), Colors.purple),
          _buildCompactSkillRow('DEFENDING', getVal('defending'), Colors.teal),
          _buildCompactSkillRow('PHYSICAL', getVal('physical'), Colors.red),
          _buildCompactSkillRow('SAVING', getVal('saving'), Colors.greenAccent),
        ],
      ),
    );
  }

  Widget _buildCompactSkillRow(String label, double progress, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1)),
              Text('${(progress * 100).toInt()}%', style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w900)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withValues(alpha: 0.03),
              valueColor: AlwaysStoppedAnimation(color),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}
