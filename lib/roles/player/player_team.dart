import 'package:flutter/material.dart';
import 'player_home.dart';
import 'teammate_profile.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class MyTeamsPage extends StatelessWidget {
  const MyTeamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<List<Color>> tileColors = [
      [const Color(0xFF2E5B4F), const Color(0xFF3B2A50)],
      [const Color(0xFF1E3A8A), const Color(0xFF312E81)],
      [const Color(0xFF064E3B), const Color(0xFF14532D)],
      [const Color(0xFF334155), const Color(0xFF1E293B)],
      [const Color(0xFF4C1D95), const Color(0xFF2E1065)],
      [const Color(0xFF831843), const Color(0xFF701A75)],
    ];

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1A1A1A), Color(0xFF0D0D0D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: goldColor.withValues(alpha: 0.2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    Container(
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: goldColor, width: 2),
                      ),
                      child: const Icon(Icons.shield, color: goldColor, size: 35),
                    ),
                    const SizedBox(width: 20),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CORE FC', 
                          style: TextStyle(
                            color: Colors.white, 
                            fontSize: 22, 
                            fontWeight: FontWeight.w900, 
                            letterSpacing: 2
                          )
                        ),
                        const SizedBox(height: 4),
                        Text('Dubai | Pro League',
                          style: TextStyle(
                            color: goldColor, 
                            fontSize: 12, 
                            fontWeight: FontWeight.w700
                          )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Text('TEAMMATES', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 3)),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final teammates = [
                    {'name': 'E. Martinez', 'no': '1', 'shooting': '15', 'passing': '82', 'dribbling': '45', 'defending': '90', 'physical': '95', 'saving': '98', 'speed': '65', 'stamina': '88'},
                    {'name': 'Ruben Dias', 'no': '5', 'shooting': '40', 'passing': '75', 'dribbling': '55', 'defending': '95', 'physical': '98', 'saving': '10', 'speed': '72', 'stamina': '92'},
                    {'name': 'Lionel Messi', 'no': '10', 'shooting': '98', 'passing': '88', 'dribbling': '92', 'defending': '45', 'physical': '85', 'saving': '10', 'speed': '88', 'stamina': '94'},
                    {'name': 'K. Mbappe', 'no': '7', 'shooting': '85', 'passing': '80', 'dribbling': '96', 'defending': '40', 'physical': '78', 'saving': '10', 'speed': '95', 'stamina': '90'},
                    {'name': 'J. Bellingham', 'no': '10', 'shooting': '82', 'passing': '95', 'dribbling': '94', 'defending': '65', 'physical': '75', 'saving': '10', 'speed': '82', 'stamina': '88'},
                    {'name': 'Kevin De Bruyne', 'no': '17', 'shooting': '78', 'passing': '92', 'dribbling': '85', 'defending': '75', 'physical': '82', 'saving': '10', 'speed': '80', 'stamina': '95'},
                    {'name': 'T. Hernandez', 'no': '3', 'shooting': '45', 'passing': '78', 'dribbling': '65', 'defending': '88', 'physical': '90', 'saving': '10', 'speed': '78', 'stamina': '92'},
                  ];
                  final member = teammates[index];
                  bool isMe = member['name'] == 'Lionel Messi';
                  final colors = tileColors[index % tileColors.length];

                  return GestureDetector(
                    onTap: () {
                      if (isMe) {
                        final homeState = context.findAncestorStateOfType<PlayerHomeState>();
                        if (homeState != null) {
                          homeState.changeTab(3);
                        }
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TeammateProfile(
                              playerName: member['name']!,
                              playerNumber: member['no'],
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: colors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: colors[0].withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.5), 
                                  width: 2.5
                                ),
                              ),
                              child: const CircleAvatar(
                                radius: 26,
                                backgroundImage: AssetImage('assets/images/sunil.png'),
                              ),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    member['name']!.toUpperCase(), 
                                    style: const TextStyle(
                                      color: Colors.white, 
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16,
                                      letterSpacing: 0.5,
                                    ), 
                                    overflow: TextOverflow.ellipsis
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        "#${member['no']!}", 
                                        style: const TextStyle(
                                          color: Colors.white, 
                                          fontSize: 12,
                                          fontWeight: FontWeight.w900
                                        )
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (isMe)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                child: Text('ME', style: TextStyle(color: colors[0], fontSize: 10, fontWeight: FontWeight.w900)),
                              )
                            else
                              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 14),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: 7,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 50)),
        ],
      );
  }
}
