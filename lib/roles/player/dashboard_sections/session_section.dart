import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class SessionSection extends StatefulWidget {
  const SessionSection({super.key});

  @override
  State<SessionSection> createState() => _SessionSectionState();
}

class _SessionSectionState extends State<SessionSection> {
  Map<String, dynamic>? _selectedSession;
  String? _filterMode;
  final Set<String> _confirmedSessions = {};

  @override
  Widget build(BuildContext context) {
    if (_selectedSession != null) {
      return _buildSessionDetail(_selectedSession!);
    }

    if (_filterMode != null) {
      return _buildFullSessionList(_filterMode == 'all_upcoming');
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderSection('UPCOMING SESSIONS', () => setState(() => _filterMode = 'all_upcoming')),
          const SizedBox(height: 15),
          _buildSessionCard(0, 'TACTICAL TRAINING', '09:00 AM - 11:00 AM', 'Pitch A', Icons.psychology, {
            'coach': 'Zinedine Zidane',
            'focus': 'Positional play, transition speed',
            'squad': 'Full Squad',
            'intensity': 'High'
          }),
          const SizedBox(height: 12),
          _buildSessionCard(1, 'STRENGTH & CONDITIONING', '02:00 PM - 03:30 PM', 'Gym Center', Icons.fitness_center, {
            'coach': 'Dr. Marcus Fitness',
            'focus': 'Core stability, explosive power',
            'squad': 'Group B',
            'intensity': 'Medium'
          }),
          
          const SizedBox(height: 35),
          _buildHeaderSection('RECENT SESSIONS', () => setState(() => _filterMode = 'all_recent')),
          const SizedBox(height: 15),
          _buildSessionCard(2, 'PRACTICE MATCH', 'Yesterday', 'Main Stadium', Icons.sports_soccer, {
            'result': 'Win 2-0',
            'performance': 'Excellent, 1 Goal, 1 Assist',
            'match_type': 'Internal Scrimmage',
            'duration': '90 Mins'
          }, completed: true),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(String title, VoidCallback onMore) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
                color: Colors.white24,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 2)),
        TextButton(
          onPressed: onMore,
          child: const Text('EXPLORE',
              style: TextStyle(
                  color: goldColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildSessionCard(int index, String title, String time, String location, IconData icon, Map<String, dynamic> data, {bool completed = false}) {
    bool isConfirmed = _confirmedSessions.contains(title);
    
    final List<Color> accentColors = [
      const Color(0xFF007CFE),
      const Color(0xFF38EF7D),
      const Color(0xFFFFB75E),
      const Color(0xFFEE0979),
    ];
    final Color accentColor = completed ? Colors.green : accentColors[index % accentColors.length];

    return GestureDetector(
      onTap: () => setState(() => _selectedSession = {
        'title': title,
        'time': time,
        'location': location,
        'icon': icon,
        'completed': completed,
        ...data
      }),
      child: Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isConfirmed || completed ? accentColor.withValues(alpha: 0.3) : Colors.white.withValues(alpha: 0.05), width: 1.5),
          gradient: LinearGradient(
            colors: [accentColor.withValues(alpha: 0.1), Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: accentColor.withValues(alpha: 0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(22),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: accentColor.withValues(alpha: 0.2)),
                ),
                child: Icon(icon, color: accentColor, size: 22),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        if (isConfirmed && !completed) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: accentColor.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(4)),
                            child: Text('CONFIRMED', style: TextStyle(color: accentColor, fontSize: 8, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text('$time • $location',
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.6), fontSize: 11, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Icon(completed || isConfirmed ? Icons.verified : Icons.arrow_forward_ios,
                  color: accentColor.withValues(alpha: 0.5),
                  size: 14),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSessionDetail(Map<String, dynamic> session) {
    bool isUpcoming = !(session['completed'] ?? false);
    bool isConfirmed = _confirmedSessions.contains(session['title']);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => setState(() => _selectedSession = null),
            icon: const Icon(Icons.arrow_back, color: goldColor),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(session['title'],
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5)),
              ),
              if (isConfirmed)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: goldColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: goldColor.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: goldColor, size: 14),
                      const SizedBox(width: 8),
                      const Text('CONFIRMED', style: TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 25),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Column(
              children: [
                _buildInfoRow(Icons.access_time, 'TIME', session['time']),
                _buildInfoRow(Icons.location_on, 'LOCATION', session['location']),
                if (session['coach'] != null) _buildInfoRow(Icons.person, 'COACH', session['coach']),
                if (session['focus'] != null) _buildInfoRow(Icons.center_focus_strong, 'FOCUS', session['focus']),
                if (session['intensity'] != null) _buildInfoRow(Icons.flash_on, 'INTENSITY', session['intensity']),
                if (session['result'] != null) _buildInfoRow(Icons.emoji_events, 'RESULT', session['result']),
                if (session['performance'] != null) _buildInfoRow(Icons.analytics, 'PERFORMANCE', session['performance']),
              ],
            ),
          ),
          if (isUpcoming && !isConfirmed) ...[
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _confirmedSessions.add(session['title']);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: goldColor,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text('CONFIRM ATTENDANCE', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
            ),
          ],
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String val) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Icon(icon, color: Colors.white24, size: 18),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      color: Colors.white24,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1)),
              const SizedBox(height: 2),
              Text(val,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFullSessionList(bool isUpcoming) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => setState(() => _filterMode = null),
                icon: const Icon(Icons.arrow_back, color: goldColor),
              ),
              const SizedBox(width: 10),
              Text(isUpcoming ? 'ALL UPCOMING' : 'SESSION HISTORY',
                  style: const TextStyle(
                      color: goldColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1)),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: 8,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _buildSessionCard(
                  index,
                  isUpcoming ? 'FUTURE DRILL ${index + 1}' : 'PAST GAME ${index + 1}',
                  isUpcoming ? 'Feb ${index + 5}, 2024' : 'Jan ${25 - index}, 2024',
                  'Training Ground',
                  isUpcoming ? Icons.upcoming : Icons.history,
                  {},
                  completed: !isUpcoming
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
