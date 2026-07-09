import 'package:flutter/material.dart';
import 'custom_painters.dart';
import 'profile_details/attendance_detail.dart';
import 'professional_pathway.dart';

import 'package:file_picker/file_picker.dart' as fp;

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class PlayerProfile extends StatefulWidget {
  final String? playerName;
  final String? playerPosition;
  final String? playerNumber;
  final Map<String, dynamic>? playerStats;

  const PlayerProfile({
    super.key,
    this.playerName,
    this.playerPosition,
    this.playerNumber,
    this.playerStats,
  });

  @override
  State<PlayerProfile> createState() => _PlayerProfileState();
}

class _PlayerProfileState extends State<PlayerProfile> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
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

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            expandedHeight: 320,
            pinned: false,
            toolbarHeight: 0,
            backgroundColor: const Color(0xFF0D0D0D),
            elevation: 0,
            automaticallyImplyLeading: false,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildHeaderPill(displaySub),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: goldColor.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                                border: Border.all(color: goldColor.withValues(alpha: 0.2)),
                              ),
                              child: const Icon(Icons.edit, color: goldColor, size: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text('CORE FC', style: TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isMobile = constraints.maxWidth < 600;
                  return TabBar(
                    controller: _tabController,
                    isScrollable: isMobile,
                    tabAlignment: isMobile ? TabAlignment.start : TabAlignment.fill,
                    indicatorColor: goldColor,
                    labelColor: goldColor,
                    unselectedLabelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 0.5),
                    unselectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.5),
                    tabs: const [
                      Tab(text: 'PROFILE'),
                      Tab(text: 'VIDEOS'),
                      Tab(text: 'PATHWAY'),
                      Tab(text: 'MATCHES'),
                      Tab(text: 'STATS'),
                      Tab(text: 'ATTENDANCE'),
                      Tab(text: 'FEEDBACK'),
                    ],
                  );
                }
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProfileTab(),
          _buildVideosTab(),
          const ProfessionalPathwayPage(),
          _buildMatchesTab(),
          _buildStatsTab(),
          _buildAttendanceTab(),
          _buildFeedbackTab(),
        ],
      ),
    );
  }

  Widget _buildVideosTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('HIGHLIGHT VIDEOS', 
                style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
              ElevatedButton.icon(
                onPressed: () async {
                  fp.FilePickerResult? result = await fp.FilePicker.platform.pickFiles(
                    type: fp.FileType.video,
                  );
                  if (result != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Uploading ${result.files.single.name}...'))
                    );
                  }
                },
                icon: const Icon(Icons.cloud_upload_outlined, size: 16, color: Colors.black),
                label: const Text('UPLOAD NEW', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: goldColor,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.2,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/match.png'),
                    fit: BoxFit.cover,
                    opacity: 0.5,
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.play_arrow, color: Colors.white, size: 30),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Text(
                        index == 0 ? 'Top Goals 2024' : 'Skill Highlight ${index + 1}',
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 50),
        ],
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
              _buildModernTile('170 cm', 'Height', Icons.height_rounded, Colors.blueAccent),
              _buildModernTile('12 Years', 'Age', Icons.calendar_month_rounded, Colors.orangeAccent),
              _buildModernTile('IND', 'Country', Icons.public_rounded, Colors.greenAccent, emoji: '🇮🇳'),
              _buildModernTile('11', 'Shirt #', Icons.format_list_numbered_rounded, goldColor),
              _buildModernTile('Right', 'Foot', Icons.directions_run_rounded, Colors.purpleAccent),
              _buildModernTile('#14', 'Rank', Icons.stars_rounded, goldColor, isGold: true),
            ],
          ),
          
          const SizedBox(height: 25),
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 15),
            child: Text('CONTACT & LOGISTICS', 
              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
          ),
          _buildInfoTileWide('parent@email.com', 'Parent/Guardian Email', Icons.family_restroom_rounded, Colors.lightBlueAccent),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _buildInfoTileWide('TOWN SQUARE', 'Location', Icons.location_on_rounded, Colors.redAccent)),
              const SizedBox(width: 10),
              Expanded(child: _buildInfoTileWide('6-7 PM', 'Session Time', Icons.access_time_filled_rounded, Colors.orangeAccent)),
            ],
          ),
          const SizedBox(height: 10),
          _buildInfoTileWide('TUESDAYS & THURSDAYS', 'Assigned Training Days', Icons.calendar_today_rounded, goldColor),

          const SizedBox(height: 25),
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 15),
            child: Text('FINANCIAL STATUS', 
              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1A1A1A), Color(0xFF0D0D0D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildWalletStat('525 AED', 'Total Wallet'),
                    Container(width: 1, height: 40, color: Colors.white10),
                    _buildWalletStat('65 AED', 'Remaining', isWarning: true),
                  ],
                ),
                const SizedBox(height: 25),
                const Divider(color: Colors.white10, height: 1),
                const SizedBox(height: 25),
                _buildModernTileValue('₹1.4B', 'Estimated Market Value', Icons.trending_up_rounded, Colors.greenAccent),
              ],
            ),
          ),
          
          const SizedBox(height: 25),
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 15),
            child: Text('CURRENT SEASON PERFORMANCE', 
              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [goldColor.withValues(alpha: 0.05), const Color(0xFF1A1A1A)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: goldColor.withValues(alpha: 0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.shield, color: goldColor, size: 16),
                    const SizedBox(width: 8),
                    const Text('Stats 2026', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
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
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2ECC71), 
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(color: const Color(0xFF2ECC71).withValues(alpha: 0.2), blurRadius: 10)],
                      ),
                      child: const Text('8.47', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 15)),
                    ),
                  ],
                ),
              ],
            ),
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

          const SizedBox(height: 25),
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 15),
            child: Text('POSITION', 
              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Primary', style: TextStyle(color: Color(0xFFE91E63), fontSize: 12, fontWeight: FontWeight.bold)),
                      Text(widget.playerPosition ?? 'Striker', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 25),
                      const Text('Others', style: TextStyle(color: Colors.white38, fontSize: 12, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text('Attacking Midfielder', style: TextStyle(color: Colors.white, fontSize: 14)),
                      const Text('Right Winger', style: TextStyle(color: Colors.white, fontSize: 14)),
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
          ),
          
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildModernTile(String val, String label, IconData icon, Color color, {String? emoji, bool isGold = false}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color.withValues(alpha: 0.5), size: 18),
          const SizedBox(height: 8),
          FittedBox(
            child: Row(
              children: [
                if (emoji != null) Padding(padding: const EdgeInsets.only(right: 4), child: Text(emoji, style: const TextStyle(fontSize: 12))),
                Text(val, style: TextStyle(color: isGold ? goldColor : Colors.white, fontWeight: FontWeight.w900, fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: Colors.white38, fontSize: 9, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildInfoTileWide(String val, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Colors.white38, fontSize: 9, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(val, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernTileValue(String val, String label, IconData icon, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(val, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22)),
            Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
          ],
        ),
      ],
    );
  }

  Widget _buildWalletStat(String val, String label, {bool isWarning = false}) {
    return Column(
      children: [
        Text(val, style: TextStyle(color: isWarning ? Colors.orangeAccent : Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10)),
        if (isWarning)
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text('LOW BALANCE!', style: TextStyle(color: Colors.redAccent, fontSize: 8, fontWeight: FontWeight.bold)),
          ),
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

  Widget _buildAttendanceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildAttendanceStat('100%', 'RATE', Colors.greenAccent)),
              const SizedBox(width: 8),
              Expanded(child: _buildAttendanceStat('45', 'PRESENT', Colors.blueAccent)),
              const SizedBox(width: 8),
              Expanded(child: _buildAttendanceStat('0', 'ABSENT', Colors.redAccent)),
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
          _buildAttendanceRecord('Training Session', '02 JUL 2024', 'PRESENT', Colors.greenAccent),
          _buildAttendanceRecord('League Match', '30 JUN 2024', 'PRESENT', Colors.greenAccent),
          _buildAttendanceRecord('Tactical Meeting', '28 JUN 2024', 'PRESENT', Colors.greenAccent),
          _buildAttendanceRecord('Gym Session', '25 JUN 2024', 'PRESENT', Colors.greenAccent),
          _buildAttendanceRecord('Friendly Game', '20 JUN 2024', 'PRESENT', Colors.greenAccent),
          _buildAttendanceRecord('Medical Check', '15 JUN 2024', 'PRESENT', Colors.greenAccent),
          _buildAttendanceRecord('Press Conference', '10 JUN 2024', 'PRESENT', Colors.greenAccent),
          _buildAttendanceRecord('Recovery Pool', '05 JUN 2024', 'PRESENT', Colors.greenAccent),
          _buildAttendanceRecord('Sponsor Event', '01 JUN 2024', 'PRESENT', Colors.greenAccent),
          _buildAttendanceRecord('Skill Drill', '28 MAY 2024', 'PRESENT', Colors.greenAccent),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildAttendanceRecord(String title, String date, String status, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(date, style: const TextStyle(color: Colors.white38, fontSize: 11)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(status, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackTab() {
    final List<Map<String, dynamic>> themeVariations = [
      {'heading': const Color(0xFFD4AF37), 'text': const Color(0xFFFFE59E)},
      {'heading': const Color(0xFF42A5F5), 'text': const Color(0xFFBBDEFB)},
      {'heading': const Color(0xFF66BB6A), 'text': const Color(0xFFC8E6C9)},
      {'heading': const Color(0xFFEC407A), 'text': const Color(0xFFF8BBD0)},
      {'heading': const Color(0xFFAB47BC), 'text': const Color(0xFFE1BEE7)},
      {'heading': const Color(0xFFFFA726), 'text': const Color(0xFFFFE0B2)},
    ];

    return Container(
      color: Colors.transparent,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('COACH FEEDBACK', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: goldColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                  child: const Text('NEW FEEDBACK', style: TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Column(
              children: List.generate(6, (index) {
                final theme = themeVariations[index % themeVariations.length];
                String noteText = index % 2 == 0 
                  ? 'Excellent work rate in the final third. Keep pressing the defenders. You have shown great improvement in your positioning during counter-attacks and your vision for long balls is exceptional.' 
                  : 'Focus on transition speed during counter-attacks. Try to be more clinical in front of the goal when you receive a cross from the right wing. Your stamina is good, but work on explosive sprints.';
                
                return GestureDetector(
                  onTap: () => _showFullFeedback(context, 'MATCH PERFORMANCE', noteText, theme['heading']!, theme['text']!, '3rd JULY 2026'),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: theme['heading']!.withValues(alpha: 0.1)),
                      boxShadow: [
                        BoxShadow(
                          color: theme['heading']!.withValues(alpha: 0.05),
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
                              style: TextStyle(color: theme['heading'], fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                            const Icon(Icons.push_pin_outlined, color: Colors.white12, size: 14),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          noteText, 
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: theme['text'], fontSize: 15, fontWeight: FontWeight.w500, height: 1.5)
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.access_time, color: Colors.white24, size: 10),
                            const SizedBox(width: 5),
                            const Text('3rd JULY 2026', style: TextStyle(color: Colors.white24, fontSize: 9, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 50),
          ],
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
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.edit_note_rounded, color: headingColor, size: 22),
                    label: Text('EDIT FEEDBACK', 
                      style: TextStyle(color: headingColor, fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 1.5)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: headingColor.withValues(alpha: 0.1),
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: headingColor.withValues(alpha: 0.2)),
                      ),
                      elevation: 0,
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

  Widget _buildAttendanceStat(String val, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Text(val, style: TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.w900)),
          Text(label, style: const TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.w900)),
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
