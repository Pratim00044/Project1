import 'package:flutter/material.dart';
import '../organization/pitch_rating_view.dart';
import '../player/player_profile.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);

class SessionAttendancePage extends StatefulWidget {
  final String sessionTitle;
  final String time;
  final String pitch;
  final String date;

  const SessionAttendancePage({
    super.key,
    required this.sessionTitle,
    required this.time,
    required this.pitch,
    required this.date,
  });

  @override
  State<SessionAttendancePage> createState() => _SessionAttendancePageState();
}

class _SessionAttendancePageState extends State<SessionAttendancePage> {
  final List<Map<String, dynamic>> _players = [
    {'name': 'James Doe', 'ratio': '8/10', 'status': null, 'image': 'assets/images/sunil.png'},
    {'name': 'Marcus Reid', 'ratio': '10/10', 'status': null, 'image': 'assets/images/sunil.png'},
    {'name': 'Lena Shah', 'ratio': '7/10', 'status': null, 'image': 'assets/images/sunil.png'},
    {'name': 'Omar Patel', 'ratio': '5/10', 'status': null, 'image': 'assets/images/sunil.png'},
    {'name': 'Sam Khan', 'ratio': '9/10', 'status': null, 'image': 'assets/images/sunil.png'},
    {'name': 'Leo Messi', 'ratio': '10/10', 'status': 'Present', 'image': 'assets/images/sunil.png'},
    {'name': 'Cristiano R.', 'ratio': '9/10', 'status': 'Absent', 'image': 'assets/images/sunil.png'},
  ];

  int get presentCount => _players.where((p) => p['status'] == 'Present').length;
  int get absentCount => _players.where((p) => p['status'] == 'Absent').length;
  int get unmarkedCount => _players.where((p) => p['status'] == null).length;

  void _showPlayerOptions(int index) {
    final player = _players[index];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.fromLTRB(25, 20, 25, 30),
        decoration: const BoxDecoration(
          color: Color(0xFF0D0D0D),
          borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 25),
              CircleAvatar(
                radius: 40,
                backgroundColor: goldColor.withOpacity(0.1),
                backgroundImage: player['image'] != null ? AssetImage(player['image']) : null,
                child: player['image'] == null ? Text(player['name'].split(' ').map((e) => e[0]).join(), style: const TextStyle(color: goldColor, fontWeight: FontWeight.bold, fontSize: 24)) : null,
              ),
              const SizedBox(height: 15),
              Text(player['name'].toUpperCase(), 
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1)),
              const SizedBox(height: 30),
              _buildOptionItem(Icons.auto_graph_rounded, 'View Progress & Records', () {
                Navigator.pop(context);
                // Navigate to Progress
              }),
              _buildOptionItem(Icons.star_outline_rounded, 'Rate Performance', () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => PitchRatingView(
                  title: widget.sessionTitle,
                  date: widget.date,
                  time: widget.time,
                )));
              }),
              _buildOptionItem(Icons.person_search_rounded, 'Full Player Profile', () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerProfile(
                  playerName: player['name'],
                  playerNumber: '10',
                  isReadOnly: true,
                )));
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionItem(IconData icon, String title, VoidCallback onTap) {
    bool isProgress = title == 'View Progress & Records';
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isProgress ? Colors.white.withOpacity(0.03) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(icon, color: isProgress ? goldColor : goldColor, size: 24),
            const SizedBox(width: 20),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  void _markAllPresent() {
    setState(() {
      for (var p in _players) {
        if (p['status'] == null) p['status'] = 'Present';
      }
    });
  }

  void _showAbsentConfirmation(int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0D0D0D),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) => SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(2)))),
                const SizedBox(height: 25),
                const Text('Mark as absent?', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                const SizedBox(height: 8),
                Text('This will affect ${_players[index]['name']}\'s reliability score', style: const TextStyle(color: Colors.white38, fontSize: 13)),
                const SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(color: surfaceColor, borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      CircleAvatar(backgroundColor: Colors.white10, radius: 18, child: Text(_players[index]['name'].split(' ').map((e) => e[0]).join(), style: const TextStyle(color: Colors.white70, fontSize: 12))),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_players[index]['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            Text('${_players[index]['ratio']} sessions attended', style: const TextStyle(color: Colors.white38, fontSize: 11)),
                          ],
                        ),
                      ),
                      const Text('Absent', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 13)),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: surfaceColor, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.white.withOpacity(0.05))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Reliability score impact', style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              const Text('Current: ', style: TextStyle(color: Colors.white24, fontSize: 11)),
                              const Text('90%', style: TextStyle(color: greenAccent, fontSize: 11, fontWeight: FontWeight.bold)),
                              const Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Icon(Icons.arrow_forward, color: Colors.white12, size: 12)),
                              const Text('After: ', style: TextStyle(color: Colors.white24, fontSize: 11)),
                              const Text('82%', style: TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    setState(() => _players[index]['status'] = 'Absent');
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text('Confirm absent', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
                ),
                const SizedBox(height: 15),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel — keep unmarked', style: TextStyle(color: Colors.white38, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveAttendance() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceSavedPage(
      sessionTitle: widget.sessionTitle,
      date: widget.date,
      time: widget.time,
      present: presentCount,
      absent: absentCount,
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 110,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.only(left: 15, top: 12, bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(color: surfaceColor, borderRadius: BorderRadius.circular(8)),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back, color: Colors.white38, size: 14),
                SizedBox(width: 4),
                Text('Dashboard', style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _markAllPresent,
            child: const Text('Mark all present', style: TextStyle(color: goldColor, fontWeight: FontWeight.w900, fontSize: 13)),
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.sessionTitle, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.white38, size: 14),
                    const SizedBox(width: 5),
                    Text(widget.time, style: const TextStyle(color: Colors.white38, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 15),
                    const Icon(Icons.location_on_outlined, color: Colors.white38, size: 14),
                    const SizedBox(width: 5),
                    Text(widget.pitch, style: const TextStyle(color: Colors.white38, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 15),
                    const Icon(Icons.calendar_today_outlined, color: Colors.white38, size: 14),
                    const SizedBox(width: 5),
                    Text(widget.date, style: const TextStyle(color: Colors.white38, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildSummaryBox(presentCount.toString(), 'Present', greenAccent),
                const SizedBox(width: 12),
                _buildSummaryBox(absentCount.toString(), 'Absent', Colors.redAccent),
                const SizedBox(width: 12),
                _buildSummaryBox(unmarkedCount.toString(), 'Unmarked', goldColor),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                Container(height: 4, decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(2))),
                FractionallySizedBox(
                  widthFactor: (presentCount + absentCount) / _players.length,
                  child: Container(height: 4, decoration: BoxDecoration(color: greenAccent, borderRadius: BorderRadius.circular(2))),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('PLAYERS (12 CONFIRMED ATTENDING)', style: TextStyle(color: Colors.white24, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: _players.length,
              itemBuilder: (context, index) {
                final player = _players[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    onTap: () => _showPlayerOptions(index),
                    leading: CircleAvatar(
                      backgroundColor: _getStatusColor(player['status']).withOpacity(0.1),
                      child: Text(player['name'].split(' ').map((e) => e[0]).join(), style: TextStyle(color: _getStatusColor(player['status']), fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                    title: Text(player['name'], style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                    subtitle: Text('Attended ${player['ratio']} sessions', style: const TextStyle(color: Colors.white38, fontSize: 11)),
                    trailing: player['status'] == null
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildActionButton('Present', greenAccent, () => setState(() => player['status'] = 'Present')),
                              const SizedBox(width: 8),
                              _buildActionButton('Absent', Colors.redAccent, () => _showAbsentConfirmation(index)),
                            ],
                          )
                        : _buildStatusPill(player['status']),
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
            decoration: BoxDecoration(
              color: const Color(0xFF0D0D0D),
              border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lock_outline_rounded, color: Colors.white24, size: 14),
                    const SizedBox(width: 8),
                    const Text('Attendance locks 6 hours after session ends', style: TextStyle(color: Colors.white24, fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveAttendance,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: goldColor,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text('SAVE ATTENDANCE', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, letterSpacing: 1)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryBox(String val, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(color: surfaceColor, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Text(val, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.w900)),
            Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildStatusPill(String status) {
    Color color = status == 'Present' ? greenAccent : Colors.redAccent;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Text(status, style: const TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }

  Color _getStatusColor(String? status) {
    if (status == 'Present') return greenAccent;
    if (status == 'Absent') return Colors.redAccent;
    return Colors.white38;
  }
}

class AttendanceSavedPage extends StatelessWidget {
  final String sessionTitle;
  final String date;
  final String time;
  final int present;
  final int absent;

  const AttendanceSavedPage({
    super.key,
    required this.sessionTitle,
    required this.date,
    required this.time,
    required this.present,
    required this.absent,
  });

  @override
  Widget build(BuildContext context) {
    double rate = (present / (present + absent)) * 100;

    return Scaffold(
      backgroundColor: darkBg,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(color: greenAccent, shape: BoxShape.circle),
                child: const Icon(Icons.check, color: Colors.black, size: 40),
              ),
              const SizedBox(height: 30),
              const Text('Attendance saved', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
              Text('$sessionTitle • $date • $time', style: const TextStyle(color: Colors.white38, fontSize: 13, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: surfaceColor, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    _buildRow('Session', sessionTitle, Colors.white),
                    _buildRow('Present', '$present players', goldColor),
                    _buildRow('Absent', '$absent players', Colors.redAccent),
                    _buildRow('Attendance rate', '${rate.toStringAsFixed(0)}%', goldColor),
                    _buildRow('Reliability scores', 'Updated', goldColor),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text('Back to dashboard', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PitchRatingView(
                    title: 'Under 12s Training',
                    date: 'Jul 12',
                    time: '11:00 AM',
                  )));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Rate players from this session', style: TextStyle(color: goldColor, fontSize: 13, fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: goldColor, size: 14),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String val, Color valColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white38, fontSize: 14, fontWeight: FontWeight.bold)),
          Text(val, style: TextStyle(color: valColor, fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
