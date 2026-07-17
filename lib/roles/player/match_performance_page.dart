import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);

class MatchPerformancePage extends StatelessWidget {
  final Map<String, dynamic> matchData;

  const MatchPerformancePage({super.key, required this.matchData});

  @override
  Widget build(BuildContext context) {
    bool isMVP = matchData['isMVP'];

    return Scaffold(
      backgroundColor: darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: darkBg,
            expandedHeight: 200,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      isMVP ? goldColor.withOpacity(0.2) : const Color(0xFF1E3A8A).withOpacity(0.2),
                      darkBg,
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Text(matchData['league'], 
                        style: const TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('CORE FC', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text('VS', style: TextStyle(color: Colors.white24, fontSize: 14, fontWeight: FontWeight.w900)),
                          ),
                          Text(matchData['opponent'].toString().split(' ').last.toUpperCase(), 
                            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(matchData['score'], 
                        style: const TextStyle(color: goldColor, fontSize: 32, fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          SliverPadding(
            padding: const EdgeInsets.all(25),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                if (isMVP) _buildMVPBadge(),
                const SizedBox(height: 30),
                const Text('MATCH PERFORMANCE', 
                  style: TextStyle(color: Colors.white24, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                const SizedBox(height: 20),
                _buildStatsGrid(),
                const SizedBox(height: 40),
                if (isMVP) ...[
                  const Text('WHY YOU WERE MVP', 
                    style: TextStyle(color: Colors.white24, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                  const SizedBox(height: 20),
                  _buildMVPReasons(),
                ],
                const SizedBox(height: 40),
                const Text('COACH\'S COMMENTS', 
                  style: TextStyle(color: Colors.white24, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                const SizedBox(height: 20),
                _buildCoachFeedback(),
                const SizedBox(height: 60),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMVPBadge() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: goldColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: goldColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: goldColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.emoji_events_rounded, color: goldColor, size: 30),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('MOST VALUABLE PLAYER', 
                  style: TextStyle(color: goldColor, fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                SizedBox(height: 4),
                Text('Incredible performance today!', 
                  style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.9,
      ),
      children: [
        _buildStatTile('2', 'GOALS', Icons.sports_soccer),
        _buildStatTile('1', 'ASSIST', Icons.assistant_navigation),
        _buildStatTile('8.9', 'RATING', Icons.star_rounded),
        _buildStatTile('92%', 'PASSING', Icons.sync_alt_rounded),
        _buildStatTile('4', 'SHOTS', Icons.ads_click_rounded),
        _buildStatTile('6km', 'DISTANCE', Icons.directions_run_rounded),
      ],
    );
  }

  Widget _buildStatTile(String val, String label, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white38, size: 20),
          const SizedBox(height: 10),
          Text(val, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
          Text(label, style: const TextStyle(color: Colors.white24, fontSize: 8, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildMVPReasons() {
    final List<String> reasons = [
      'Scored the winning goal in the 85th minute.',
      'Maintained a 92% pass accuracy throughout the match.',
      'Exceptional defensive contribution with 5 interceptions.',
      'High work rate covering 6km in 45 minutes.',
    ];

    return Column(
      children: reasons.map((reason) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: greenAccent, size: 18),
            const SizedBox(width: 15),
            Expanded(
              child: Text(reason, 
                style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildCoachFeedback() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: Color(0xFF1A1A1A),
                child: Icon(Icons.person, color: goldColor, size: 18),
              ),
              SizedBox(width: 10),
              Text('Coach Scaloni', 
                style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            '"Lionel was a constant threat on the left wing. His movement off the ball was top-class today. Deservedly the MVP for his late impact and leadership."',
            style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
