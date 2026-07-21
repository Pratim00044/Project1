import 'package:flutter/material.dart';
import 'custom_painters.dart';
import 'profile_details/identity_verification_page.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);

class PlayerProfile extends StatelessWidget {
  final String playerName;
  final String? playerNumber;
  final bool isReadOnly;
  final bool showBackButton;

  const PlayerProfile({
    super.key,
    this.playerName = 'Lionel Messi',
    this.playerNumber,
    this.isReadOnly = false,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return DetailedPlayerProfile(
      name: playerName,
      pos: 'Forward',
      club: 'Core FC',
      isMe: !isReadOnly,
      showBackButton: showBackButton,
    );
  }
}

class DetailedPlayerProfile extends StatelessWidget {
  final String name;
  final String pos;
  final String club;
  final bool isMe;
  final Map<String, String>? stats;
  final bool showBackButton;

  const DetailedPlayerProfile({
    super.key,
    required this.name,
    required this.pos,
    required this.club,
    this.isMe = false,
    this.stats,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final displayStats = stats ?? {
      'Goals': '12',
      'Assists': '7',
      'Clean sheets': '4',
      'Games played': '24',
      'Attendance': '87%',
      'Avg rating': '4.8',
    };

    return Scaffold(
      backgroundColor: darkBg,
      appBar: showBackButton ? AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ) : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Photo
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: goldColor, width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/images/sunil.png'),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(displayStats['Avg rating']!, style: const TextStyle(color: goldColor, fontSize: 28, fontWeight: FontWeight.w900)),
                    const Text('Avg rating', style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
            
            const SizedBox(height: 30),
            _buildSectionHeader('PERSONAL DETAILS'),
            const SizedBox(height: 15),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.95,
              children: [
                _buildModernTile('170 cm', 'Height', Icons.height_rounded, const Color(0xFF1E3A8A)),
                _buildModernTile('12 Years', 'Age', Icons.calendar_month_rounded, const Color(0xFF92400E)),
                _buildModernTile('UAE', 'Nationality', Icons.public_rounded, const Color(0xFF064E3B)),
                _buildModernTile('11', 'Shirt #', Icons.format_list_numbered_rounded, const Color(0xFF2E5B4F)),
                _buildModernTile('Right', 'Foot', Icons.directions_run_rounded, const Color(0xFF4C1D95)),
                _buildModernTile('#14', 'Rank', Icons.stars_rounded, const Color(0xFF831843)),
              ],
            ),

            const SizedBox(height: 35),
            _buildSectionHeader('IDENTITY VERIFICATION'),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const IdentityVerificationPage())),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: goldColor.withValues(alpha: 0.1)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: goldColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.badge_outlined, color: goldColor, size: 22),
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Photo & ID Documents', 
                            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                          SizedBox(height: 2),
                          Text('Verification required for league play', 
                            style: TextStyle(color: Colors.white38, fontSize: 11)),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white24, size: 14),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 35),
            _buildSectionHeader('SEASON STATS'),
            const SizedBox(height: 15),
            
            // Season Stats Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1,
              children: [
                _buildStatTile(displayStats['Goals']!, 'Goals'),
                _buildStatTile(displayStats['Assists']!, 'Assists'),
                _buildStatTile(displayStats['Clean sheets']!, 'Clean sheets'),
                _buildStatTile(displayStats['Games played']!, 'Games played'),
                _buildStatTile(displayStats['Attendance']!, 'Attendance'),
                _buildStatTile(displayStats['Avg rating']!, 'Avg rating'),
              ],
            ),

            const SizedBox(height: 35),
            _buildSectionHeader('PLAYER SKILL RADAR'),
            const SizedBox(height: 20),
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Skill Traits', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      Icon(Icons.analytics_rounded, color: goldColor, size: 20),
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
                          stats: const [0.98, 0.88, 0.92, 0.45, 0.85, 0.10],
                          labels: const [
                            'Shooting\n98%',
                            'Passing\n88%',
                            'Dribbling\n92%',
                            'Defending\n45%',
                            'Physical\n85%',
                            'Saving\n10%',
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
            _buildSectionHeader('POSITION'),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              ),
              child: Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Primary', style: TextStyle(color: Color(0xFFE91E63), fontSize: 12, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text('Striker', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                        SizedBox(height: 25),
                        Text('Others', style: TextStyle(color: Colors.white38, fontSize: 12, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('Attacking Midfielder', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                        SizedBox(height: 4),
                        Text('Right Winger', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 120,
                    height: 160,
                    child: CustomPaint(
                      painter: SoccerFieldPainter(
                        positions: const [
                          {'pos': 'ST', 'x': 0.5, 'y': 0.15, 'primary': true},
                          {'pos': 'AM', 'x': 0.5, 'y': 0.45, 'primary': false},
                          {'pos': 'RW', 'x': 0.85, 'y': 0.25, 'primary': false},
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title,
        style: const TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5));
  }

  Widget _buildStatTile(String val, String label) {
    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(val, style: const TextStyle(color: goldColor, fontSize: 20, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white38, fontSize: 9, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildModernTile(String val, String label, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 6),
          Text(val, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 13)),
          const SizedBox(height: 2),
          Text(label.toUpperCase(), style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 8, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
