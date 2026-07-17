import 'package:flutter/material.dart';
import 'match_performance_page.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class MatchHistoryPage extends StatelessWidget {
  const MatchHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for match history
    final List<Map<String, dynamic>> matches = [
      {
        'date': 'JUL 12, 2024',
        'league': 'STATIXA ELITE LEAGUE',
        'opponent': 'DUBAI CITY FC',
        'score': '3 - 1',
        'isMVP': true,
        'location': 'Al Hamra Stadium',
      },
      {
        'date': 'JUL 05, 2024',
        'league': 'THURSDAY SOCIAL 7s',
        'opponent': 'SHARJAH UNITED',
        'score': '2 - 2',
        'isMVP': false,
        'location': 'Dubai Sports City',
      },
      {
        'date': 'JUN 28, 2024',
        'league': 'STATIXA ELITE LEAGUE',
        'opponent': 'ABU DHABI STARS',
        'score': '1 - 0',
        'isMVP': true,
        'location': 'Zayed Sports City',
      },
      {
        'date': 'JUN 21, 2024',
        'league': 'FRIENDLY MATCH',
        'opponent': 'AJMAN CLUB',
        'score': '4 - 0',
        'isMVP': false,
        'location': 'Ajman Stadium',
      },
    ];

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('MATCH HISTORY', 
          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 2)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final match = matches[index];
          return _buildMatchCard(context, match);
        },
      ),
    );
  }

  Widget _buildMatchCard(BuildContext context, Map<String, dynamic> match) {
    bool isMVP = match['isMVP'];

    return GestureDetector(
      onTap: () => Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => MatchPerformancePage(matchData: match))
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isMVP ? goldColor.withOpacity(0.3) : Colors.white.withOpacity(0.05),
            width: 1,
          ),
          boxShadow: isMVP ? [
            BoxShadow(
              color: goldColor.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ] : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(match['date'], 
                    style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  if (isMVP)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: goldColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: goldColor.withOpacity(0.3)),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.star_rounded, color: goldColor, size: 12),
                          SizedBox(width: 4),
                          Text('MVP', style: TextStyle(color: goldColor, fontSize: 9, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(match['league'], 
                style: const TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('CORE FC', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 4),
                        Text('vs ${match['opponent']}', 
                          style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  Text(match['score'], 
                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                ],
              ),
              const SizedBox(height: 15),
              const Divider(color: Colors.white10, height: 1),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, color: Colors.white38, size: 14),
                  const SizedBox(width: 6),
                  Text(match['location'], 
                    style: const TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white24, size: 12),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
