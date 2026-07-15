import 'package:flutter/material.dart';
import '../player_home.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);
const Color darkBg = Color(0xFF080808);

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        'title': 'NEW MATCH CREATED',
        'desc': 'Coach James has scheduled a new league match for Feb 02 at Al Hamra Stadium.',
        'time': '2 hours ago',
        'icon': 'sports_soccer',
        'isNew': true,
        'color': const Color(0xFFD4AF37),
      },
      {
        'title': 'TRAINING SESSION UPDATED',
        'desc': 'Tactical training session for FEB 05 has been moved to Pitch 4.',
        'time': '5 hours ago',
        'icon': 'fitness_center',
        'isNew': true,
        'color': const Color(0xFF38EF7D),
      },
      {
        'title': 'MVP AWARDED!',
        'desc': 'Congratulations! You have been awarded MVP for the match against Dubai Lions.',
        'time': '1 day ago',
        'icon': 'emoji_events',
        'isNew': false,
        'color': const Color(0xFF007CFE),
      },
      {
        'title': 'NEW STATS AVAILABLE',
        'desc': 'Your performance stats for the last match have been uploaded.',
        'time': '2 days ago',
        'icon': 'analytics',
        'isNew': false,
        'color': const Color(0xFFEE0979),
      },
      {
        'title': 'TEAM MEETING',
        'desc': 'Mandatory team meeting in the locker room at 5:00 PM today.',
        'time': '3 days ago',
        'icon': 'groups',
        'isNew': false,
        'color': Colors.orangeAccent,
      },
    ];

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/footlab.png', height: 30),
            const SizedBox(width: 10),
            const Text('NOTIFICATIONS',
                style: TextStyle(
                    color: goldColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5)),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Clear All', style: TextStyle(color: Colors.white38, fontSize: 12)),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notif = notifications[index];
          final bool isNew = notif['isNew'] == true;
          final bool isEven = index % 2 == 0;
          final Color accentColor = notif['color'] as Color;
          
          Widget iconWidget = Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: accentColor.withValues(alpha: 0.2)),
            ),
            child: Icon(
              _getIcon(notif['icon']!),
              color: accentColor,
              size: 20,
            ),
          );

          Widget contentWidget = Expanded(
            child: Column(
              crossAxisAlignment: isEven ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: isEven ? MainAxisAlignment.start : MainAxisAlignment.end,
                  children: [
                    if (!isEven && isNew)
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 8, height: 8,
                        decoration: BoxDecoration(color: accentColor, shape: BoxShape.circle),
                      ),
                    Text(notif['title']!,
                        style: TextStyle(
                            color: accentColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.0)),
                    if (isEven && isNew)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        width: 8, height: 8,
                        decoration: BoxDecoration(color: accentColor, shape: BoxShape.circle),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(notif['desc']!,
                    textAlign: isEven ? TextAlign.left : TextAlign.right,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        height: 1.5)),
                const SizedBox(height: 12),
                Text(notif['time']!,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 10, 
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          );

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: isNew ? accentColor.withValues(alpha: 0.3) : Colors.white.withValues(alpha: 0.05),
                  width: 1.5,
                ),
                gradient: isNew ? LinearGradient(
                  colors: [accentColor.withValues(alpha: 0.05), Colors.transparent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ) : null,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: isEven 
                  ? [iconWidget, const SizedBox(width: 20), contentWidget]
                  : [contentWidget, const SizedBox(width: 20), iconWidget],
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _getIcon(String name) {
    switch (name) {
      case 'sports_soccer': return Icons.sports_soccer;
      case 'fitness_center': return Icons.fitness_center;
      case 'emoji_events': return Icons.emoji_events;
      case 'analytics': return Icons.analytics;
      case 'groups': return Icons.groups;
      default: return Icons.notifications;
    }
  }
}
