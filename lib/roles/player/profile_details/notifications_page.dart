import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);
const Color darkBg = Color(0xFF080808);

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {
        'title': 'NEW MATCH CREATED',
        'desc': 'Coach James has scheduled a new league match for Feb 02 at Al Hamra Stadium.',
        'time': '2 hours ago',
        'icon': 'sports_soccer',
        'isNew': 'true',
      },
      {
        'title': 'TRAINING SESSION UPDATED',
        'desc': 'Tactical training session for FEB 05 has been moved to Pitch 4.',
        'time': '5 hours ago',
        'icon': 'fitness_center',
        'isNew': 'true',
      },
      {
        'title': 'MVP AWARDED!',
        'desc': 'Congratulations! You have been awarded MVP for the match against Dubai Lions.',
        'time': '1 day ago',
        'icon': 'emoji_events',
        'isNew': 'false',
      },
      {
        'title': 'NEW STATS AVAILABLE',
        'desc': 'Your performance stats for the last match have been uploaded.',
        'time': '2 days ago',
        'icon': 'analytics',
        'isNew': 'false',
      },
      {
        'title': 'TEAM MEETING',
        'desc': 'Mandatory team meeting in the locker room at 5:00 PM today.',
        'time': '3 days ago',
        'icon': 'groups',
        'isNew': 'false',
      },
    ];

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        centerTitle: true,
        title: const Text('NOTIFICATIONS',
            style: TextStyle(
                color: goldColor,
                fontSize: 16,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5)),
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
          final bool isNew = notif['isNew'] == 'true';
          
          final List<String> tileImages = [
            'assets/images/img1.jpeg',
            'assets/images/img2.jpeg',
            'assets/images/img3.jpeg',
            'assets/images/img4.jpeg',
          ];
          String currentImage = tileImages[index % tileImages.length];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isNew ? goldColor.withValues(alpha: 0.3) : Colors.white.withValues(alpha: 0.05),
              ),
              image: DecorationImage(
                image: AssetImage(currentImage),
                fit: BoxFit.cover,
                opacity: 0.25,
              ),
              gradient: isNew ? LinearGradient(
                colors: [goldColor.withValues(alpha: 0.1), Colors.transparent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ) : null,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isNew ? goldColor.withValues(alpha: 0.1) : Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getIcon(notif['icon']!),
                    color: isNew ? goldColor : Colors.white38,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(notif['title']!,
                              style: TextStyle(
                                  color: isNew ? goldColor : Colors.white70,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.5)),
                          if (isNew)
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(color: goldColor, shape: BoxShape.circle),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(notif['desc']!,
                          style: TextStyle(
                              color: isNew ? Colors.white : Colors.white38,
                              fontSize: 13,
                              height: 1.4)),
                      const SizedBox(height: 10),
                      Text(notif['time']!,
                          style: const TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
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
