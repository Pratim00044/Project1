import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);

class PitchRatingView extends StatefulWidget {
  final String title;
  final String date;
  final String time;

  const PitchRatingView({
    super.key,
    required this.title,
    this.date = 'Jul 12',
    this.time = '11:30 PM',
  });

  @override
  State<PitchRatingView> createState() => _PitchRatingViewState();
}

class _PitchRatingViewState extends State<PitchRatingView> {
  final List<Map<String, dynamic>> _players = [
    {'name': 'Lena', 'initials': 'LS', 'pos': 'ST', 'x': 0.5, 'y': 0.15, 'rated': true, 'absent': false},
    {'name': 'James', 'initials': 'JD', 'pos': 'LM', 'x': 0.25, 'y': 0.4, 'rated': true, 'absent': false},
    {'name': 'Marcus', 'initials': 'MR', 'pos': 'RM', 'x': 0.75, 'y': 0.4, 'rated': true, 'absent': false},
    {'name': 'Sam', 'initials': 'SK', 'pos': 'CM', 'x': 0.5, 'y': 0.55, 'rated': false, 'absent': false},
    {'name': 'Omar', 'initials': 'OP', 'pos': 'LB', 'x': 0.3, 'y': 0.75, 'rated': false, 'absent': true},
    {'name': 'Ivan', 'initials': 'IV', 'pos': 'RB', 'x': 0.7, 'y': 0.75, 'rated': false, 'absent': true},
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
          const SizedBox(height: 20),
          _buildScoreBoard(),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color(0xFF1B2414),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Stack(
                  children: [
                    CustomPaint(
                      size: Size.infinite,
                      painter: PitchPainter(),
                    ),
                    ..._players.map((p) => _buildPitchPlayer(p)),
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
                backgroundColor: const Color(0xFF1B2414),
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: const BorderSide(color: greenAccent, width: 0.5)),
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
            if (!isRated && !isAbsent)
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: goldColor, borderRadius: BorderRadius.circular(6)),
                child: const Text('Tap to rate', style: TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.bold)),
              ),
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isAbsent ? Colors.transparent : goldColor.withValues(alpha: 0.2),
                border: Border.all(color: isAbsent ? Colors.white24 : goldColor, width: 2, style: isAbsent ? BorderStyle.solid : BorderStyle.solid),
              ),
              child: Center(
                child: Text(p['initials'], style: TextStyle(color: isAbsent ? Colors.white24 : Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 4),
            Text(p['name'], style: TextStyle(color: isAbsent ? Colors.white24 : Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            if (isRated)
              Container(
                margin: const EdgeInsets.only(top: 2),
                width: 4, height: 4,
                decoration: const BoxDecoration(color: goldColor, shape: BoxShape.circle),
              ),
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
      builder: (context) => _RatingSheet(player: player),
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
  const _RatingSheet({required this.player});

  @override
  State<_RatingSheet> createState() => _RatingSheetState();
}

class _RatingSheetState extends State<_RatingSheet> {
  int goals = 2;
  int assists = 1;
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
                  child: Text(widget.player['initials'], style: const TextStyle(color: goldColor, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.player['name'] + ' Khan', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const Text('Midfielder • Thu Apr 16', style: TextStyle(color: Colors.white38, fontSize: 12)),
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

class PitchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawRect(Rect.fromLTWH(10, 10, size.width - 20, size.height - 20), paint);
    canvas.drawLine(Offset(10, size.height / 2), Offset(size.width - 10, size.height / 2), paint);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 40, paint);
    
    // Penalty boxes
    canvas.drawRect(Rect.fromLTWH(size.width * 0.25, 10, size.width * 0.5, 50), paint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.25, size.height - 60, size.width * 0.5, 50), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
