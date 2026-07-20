import 'package:flutter/material.dart';
import 'dart:ui' as ui;

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);

class PitchRatingView extends StatefulWidget {
  final String title;
  final String date;
  final String time;
  final bool isCoach;

  const PitchRatingView({
    super.key,
    required this.title,
    this.date = 'Jul 12',
    this.time = '11:30 PM',
    this.isCoach = false,
  });

  @override
  State<PitchRatingView> createState() => _PitchRatingViewState();
}

class _PitchRatingViewState extends State<PitchRatingView> {
  final List<Map<String, dynamic>> _players = [
    {'name': 'Lena', 'initials': 'LS', 'pos': 'ST', 'x': 0.5, 'y': 0.08, 'rated': true, 'absent': false, 'image': 'assets/images/sunil.png'},
    {'name': 'James', 'initials': 'JD', 'pos': 'LM', 'x': 0.15, 'y': 0.32, 'rated': true, 'absent': false, 'image': 'assets/images/sunil.png'},
    {'name': 'Marcus', 'initials': 'MR', 'pos': 'RM', 'x': 0.85, 'y': 0.32, 'rated': true, 'absent': false, 'image': 'assets/images/sunil.png'},
    {'name': 'Sam', 'initials': 'SK', 'pos': 'CM', 'x': 0.5, 'y': 0.54, 'rated': false, 'absent': false, 'image': 'assets/images/sunil.png'},
    {'name': 'Omar', 'initials': 'OP', 'pos': 'LB', 'x': 0.22, 'y': 0.82, 'rated': false, 'absent': true, 'image': 'assets/images/sunil.png'},
    {'name': 'Ivan', 'initials': 'IV', 'pos': 'RB', 'x': 0.78, 'y': 0.82, 'rated': false, 'absent': true, 'image': 'assets/images/sunil.png'},
  ];

  int get _ratedCount => _players.where((p) => p['rated'] && !p['absent']).length;
  int get _attendedCount => _players.where((p) => !p['absent']).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white70),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Rate players', style: TextStyle(color: goldColor, fontSize: 14, fontWeight: FontWeight.bold)),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text('$_ratedCount/$_attendedCount rated', 
                style: const TextStyle(color: greenAccent, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildStatusBadge('Live', Colors.redAccent),
                    const SizedBox(width: 8),
                    _buildStatusBadge('7-a-side', goldColor.withValues(alpha: 0.1), textColor: goldColor),
                  ],
                ),
                const SizedBox(height: 10),
                Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                Text('${widget.date} • ${widget.time}', style: const TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 5), // Reduced from 20 to give more space to the pitch
          _buildScoreBoard(),
          const SizedBox(height: 5), // Reduced from 20 to give more space to the pitch
          Expanded(
            flex: 6, // Increased from 3 to make ground height significantly longer
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/ground.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    // Draw absent players first so they are in the background
                    ..._players.where((p) => p['absent']).map((p) => _buildPitchPlayer(p)),
                    // Draw active players
                    ..._players.where((p) => !p['absent']).map((p) => _buildPitchPlayer(p)),
                  ],
                ),
              ),
            ),
          ),
          _buildBottomStats(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D1409), // Darker than pitch for contrast
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: const BorderSide(color: greenAccent, width: 1.0)),
              ),
              child: const Text('Save all ratings', style: TextStyle(color: greenAccent, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String label, Color bg, {Color textColor = Colors.white}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: TextStyle(color: textColor, fontSize: 9, fontWeight: FontWeight.w900)),
    );
  }

  Widget _buildScoreBoard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTeamScore('3', 'Core FC'),
          const Text('Final score', style: TextStyle(color: Colors.white24, fontSize: 12)),
          _buildTeamScore('2', 'Opponents'),
        ],
      ),
    );
  }

  Widget _buildTeamScore(String score, String team) {
    return Column(
      children: [
        Text(score, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
        Text(team, style: const TextStyle(color: Colors.white38, fontSize: 10)),
      ],
    );
  }

  Widget _buildPitchPlayer(Map<String, dynamic> p) {
    bool isRated = p['rated'];
    bool isAbsent = p['absent'];

    return Align(
      alignment: FractionalOffset(p['x'], p['y']),
      child: GestureDetector(
        onTap: isAbsent ? null : () => _showRatingSheet(p),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52, // Slightly smaller to create more visual gap
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isAbsent ? Colors.transparent : Colors.black26,
                border: Border.all(
                  color: isAbsent ? Colors.white24 : goldColor, 
                  width: 2.0
                ),
              ),
              child: ClipOval(
                child: Stack(
                  children: [
                    if (!isAbsent)
                      Image.asset(
                        p['image'],
                        fit: BoxFit.cover,
                        width: 52,
                        height: 52,
                      ),
                    // Apply blur to absent players or darken unrated ones
                    if (isAbsent)
                      Positioned.fill(
                        child: ImageFiltered(
                          imageFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.4), BlendMode.darken),
                          child: Image.asset(p['image'], fit: BoxFit.cover, width: 52, height: 52),
                        ),
                      ),
                    if (isAbsent)
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withValues(alpha: 0.1),
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Stronger blur
                            child: Container(color: Colors.transparent),
                          ),
                        ),
                      ),
                    if (isAbsent)
                      Center(
                        child: Text(p['initials'], 
                          style: const TextStyle(color: Colors.white24, fontWeight: FontWeight.bold, fontSize: 14)
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6), // More space between circle and name
            Text(p['name'], style: TextStyle(
              color: isAbsent ? Colors.white30 : Colors.white, 
              fontSize: 10.5, 
              fontWeight: FontWeight.w900,
              shadows: const [Shadow(color: Colors.black, blurRadius: 4, offset: Offset(0, 1))]
            )),
          ],
        ),
      ),
    );
  }

  void _showRatingSheet(Map<String, dynamic> player) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _RatingSheet(player: player, isCoach: widget.isCoach),
    ).then((value) {
      if (value == true) {
        setState(() {
          player['rated'] = true;
        });
      }
    });
  }

  Widget _buildBottomStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatIndicator(Icons.check, '$_ratedCount rated', greenAccent),
          _buildStatIndicator(Icons.access_time, '${_attendedCount - _ratedCount} pending', goldColor),
          _buildStatIndicator(Icons.close, '${_players.length - _attendedCount} absent', Colors.white24),
        ],
      ),
    );
  }

  Widget _buildStatIndicator(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 14),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _RatingSheet extends StatefulWidget {
  final Map<String, dynamic> player;
  final bool isCoach;
  const _RatingSheet({required this.player, this.isCoach = false});

  @override
  State<_RatingSheet> createState() => _RatingSheetState();
}

class _RatingSheetState extends State<_RatingSheet> {
  int goals = 2;
  int assists = 1;
  final TextEditingController _feedbackController = TextEditingController();
  Map<String, int> ratings = {
    'Work ethic': 4,
    'Communication': 3,
    'Teamwork': 4,
    'Passing': 5,
    'Dribbling': 3,
    'Defence': 2,
    'Stamina': 4,
  };

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        color: Color(0xFF161616),
        borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 25),
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: goldColor.withValues(alpha: 0.1),
                  backgroundImage: AssetImage(widget.player['image']),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.player['name'] + ' Khan', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const Text('Thu Apr 16', style: TextStyle(color: Colors.white38, fontSize: 12)),
                    ],
                  ),
                ),
                const Column(
                  children: [
                    Text('—', style: TextStyle(color: goldColor, fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('Overall', style: TextStyle(color: Colors.white38, fontSize: 10)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                _buildCounter('Goals', goals, (v) => setState(() => goals = v)),
                const SizedBox(width: 20),
                _buildCounter('Assists', assists, (v) => setState(() => assists = v)),
              ],
            ),
            const SizedBox(height: 30),
            const Text('ATTITUDE', style: TextStyle(color: Colors.white24, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
            const SizedBox(height: 15),
            _buildRatingRow('Work ethic'),
            _buildRatingRow('Communication'),
            _buildRatingRow('Teamwork'),
            const SizedBox(height: 25),
            const Text('TECHNICAL', style: TextStyle(color: Colors.white24, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
            const SizedBox(height: 15),
            _buildRatingRow('Passing'),
            _buildRatingRow('Dribbling'),
            _buildRatingRow('Defence'),
            _buildRatingRow('Stamina'),
            if (widget.isCoach) ...[
              const SizedBox(height: 30),
              const Text('WRITTEN FEEDBACK',
                  style: TextStyle(
                      color: Colors.white24,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5)),
              const SizedBox(height: 15),
              TextField(
                controller: _feedbackController,
                maxLines: 4,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Add performance notes...',
                  hintStyle: const TextStyle(color: Colors.white24, fontSize: 13),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.03),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(15),
                ),
              ),
            ],
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: goldColor,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: Text('Save ${widget.player['name']}\'s rating', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
            ),
            const SizedBox(height: 15),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel', style: TextStyle(color: Colors.white24, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounter(String label, int val, Function(int) onChanged) {
    return Expanded(
      child: Row(
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
          const Spacer(),
          _counterBtn(Icons.remove, () => onChanged(val > 0 ? val - 1 : 0)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text('$val', style: const TextStyle(color: goldColor, fontSize: 18, fontWeight: FontWeight.w900)),
          ),
          _counterBtn(Icons.add, () => onChanged(val + 1)),
        ],
      ),
    );
  }

  Widget _counterBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(6)),
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }

  Widget _buildRatingRow(String key) {
    int rating = ratings[key] ?? 0;
    Color statusColor = rating >= 4 ? greenAccent : (rating == 3 ? Colors.orangeAccent : Colors.redAccent);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(child: Text(key, style: const TextStyle(color: Colors.white70, fontSize: 14))),
          Row(
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () => setState(() => ratings[key] = index + 1),
                child: Icon(
                  index < rating ? Icons.star_rounded : Icons.star_rounded,
                  color: index < rating ? goldColor : Colors.white.withValues(alpha: 0.05),
                  size: 22,
                ),
              );
            }),
          ),
          const SizedBox(width: 15),
          Container(
            width: 8, height: 8,
            decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
          )
        ],
      ),
    );
  }
}

