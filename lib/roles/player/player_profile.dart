import 'package:flutter/material.dart';
import 'custom_painters.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class PlayerProfile extends StatefulWidget {
  final String? playerName;
  final String? playerPosition;
  final String? playerNumber;
  final Map<String, dynamic>? playerStats;
  final bool isReadOnly;

  const PlayerProfile({
    super.key,
    this.playerName,
    this.playerPosition,
    this.playerNumber,
    this.playerStats,
    this.isReadOnly = false,
  });

  @override
  State<PlayerProfile> createState() => _PlayerProfileState();
}

class _PlayerProfileState extends State<PlayerProfile> {
  @override
  Widget build(BuildContext context) {
    final String displayName = widget.playerName ?? 'LIONEL MESSI';
    final String displaySub = widget.playerPosition != null && widget.playerNumber != null 
        ? '${widget.playerPosition} | #${widget.playerNumber}' 
        : 'FORWARD | #11';

    return Scaffold(
      backgroundColor: darkBg,
      body: CustomScrollView(
        slivers: [
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
                  Image.asset('assets/images/img1.jpeg',
                    fit: BoxFit.cover,
                    opacity: const AlwaysStoppedAnimation(0.4),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          darkBg.withValues(alpha: 0.1), 
                          darkBg.withValues(alpha: 0.2), 
                          darkBg
                        ],
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
                          const SizedBox(width: 32),
                          Column(
                            children: [
                              _buildHeaderPill(displaySub),
                              const SizedBox(height: 8),
                              Text('CLUB PLAYER', style: TextStyle(color: goldColor.withValues(alpha: 0.8), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                              const SizedBox(height: 5),
                              const Text('CORE FC', style: TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
                            ],
                          ),
                          const SizedBox(width: 10),
                          if (!widget.isReadOnly)
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
                      const SizedBox(height: 15),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _buildProfileContent(),
          ),
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

  Widget _buildProfileContent() {
    final stats = widget.playerStats ?? {
      'shooting': '98',
      'passing': '88',
      'dribbling': '92',
      'defending': '45',
      'physical': '85',
      'saving': '10',
    };

    double getVal(String key) => (double.tryParse(stats[key]?.toString() ?? '0') ?? 0) / 100;

    return Padding(
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
            child: Text('FINANCIAL STATUS', 
              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
          ),
          Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/img3.jpeg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.2),
                  ],
                ),
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

  Widget _buildModernTile(int index, String val, String label, IconData icon, List<Color> colors, {String? emoji}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage('assets/images/img${(index % 4) + 1}.jpeg'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: colors[0].withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.1),
              Colors.black.withValues(alpha: 0.2),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white.withValues(alpha: 0.7), size: 16),
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
            Text(label.toUpperCase(), style: const TextStyle(color: Colors.white70, fontSize: 8, fontWeight: FontWeight.bold)),
          ],
        ),
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
}
