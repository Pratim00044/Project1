import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class CoachNotificationsPage extends StatelessWidget {
  const CoachNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        'title': 'New Training Session Scheduled',
        'category': 'Training',
        'time': '08:30 AM',
        'icon': Icons.fitness_center_rounded,
        'color': const Color(0xFF2E5B4F),
        'isNew': true,
      },
      {
        'title': 'Player Performance Report Ready',
        'category': 'Analysis',
        'time': '11:15 AM',
        'icon': Icons.analytics_outlined,
        'color': const Color(0xFF1E3A8A),
        'isNew': true,
      },
      {
        'title': 'Upcoming Match vs Tigers FC',
        'category': 'Match',
        'time': 'Yesterday',
        'icon': Icons.sports_soccer_rounded,
        'color': const Color(0xFF064E3B),
        'isNew': true,
      },
      {
        'title': 'New message from Team Manager',
        'category': 'Chat',
        'time': 'Yesterday',
        'icon': Icons.chat_bubble_outline_rounded,
        'color': const Color(0xFF831843),
        'isNew': true,
      },
      {
        'title': 'Squad Availability Updated',
        'category': 'Roster',
        'time': '2 days ago',
        'icon': Icons.people_outline_rounded,
        'color': const Color(0xFF4C1D95),
        'isNew': true,
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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: isNew ? Colors.white.withValues(alpha: 0.4) : Colors.white10),
            ),
            child: Icon(
              notif['icon'] as IconData,
              color: isNew ? Colors.white : accentColor.withValues(alpha: 0.7),
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
                        decoration: const BoxDecoration(color: goldColor, shape: BoxShape.circle),
                      ),
                    Text(notif['category'].toString().toUpperCase(),
                        style: TextStyle(
                            color: isNew ? Colors.white.withValues(alpha: 0.7) : accentColor.withValues(alpha: 0.8),
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5)),
                    if (isEven && isNew)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        width: 8, height: 8,
                        decoration: const BoxDecoration(color: goldColor, shape: BoxShape.circle),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(notif['title']!,
                    textAlign: isEven ? TextAlign.left : TextAlign.right,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        height: 1.4,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(notif['time']!,
                    style: const TextStyle(
                      color: Colors.white38, 
                      fontSize: 10, 
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          );

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isNew 
                  ? [accentColor, accentColor.withValues(alpha: 0.7)]
                  : [surfaceColor, surfaceColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 4))
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: isNew ? Colors.white.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.05)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: isEven 
                  ? [iconWidget, const SizedBox(width: 15), contentWidget]
                  : [contentWidget, const SizedBox(width: 15), iconWidget],
              ),
            ),
          );
        },
      ),
    );
  }
}
