import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class AdminNotificationsPage extends StatelessWidget {
  const AdminNotificationsPage({super.key});

  final List<Map<String, dynamic>> notifications = const [
    {
      'title': 'NEW MATCH CREATED',
      'message': 'Core FC vs Dubai Lions scheduled by Organiser Ahmed.',
      'time': '2 mins ago',
      'icon': Icons.sports_soccer_rounded,
      'color': Color(0xFF8E2DE2),
      'category': 'MATCH'
    },
    {
      'title': 'MATCH VICTORY ALERT',
      'message': 'National Gulf FC won 3-1 against Eagle FC. Table updated.',
      'time': '45 mins ago',
      'icon': Icons.emoji_events_rounded,
      'color': Color(0xFF38EF7D),
      'category': 'RESULT'
    },
    {
      'title': 'COACH RECRUITMENT',
      'message': 'New application received from Coach Sarah Jenkins.',
      'time': '2 hours ago',
      'icon': Icons.assignment_ind_rounded,
      'color': Color(0xFF007CFE),
      'category': 'COACH'
    },
    {
      'title': 'MANAGER UPDATE',
      'message': 'Manager Marcus updated team roster for United FC.',
      'time': '5 hours ago',
      'icon': Icons.manage_accounts_rounded,
      'color': Color(0xFFFFB75E),
      'category': 'MANAGER'
    },
    {
      'title': 'SYSTEM ALERT',
      'message': 'Audit logs show multiple failed login attempts from IP 192.168.1.1',
      'time': 'Yesterday',
      'icon': Icons.security_rounded,
      'color': Color(0xFFEE0979),
      'category': 'SYSTEM'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('NOTIFICATIONS', 
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 2)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              boxShadow: [
                BoxShadow(
                  color: (item['color'] as Color).withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (item['color'] as Color).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(item['icon'], color: item['color'], size: 22),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item['category'],
                            style: TextStyle(
                              color: item['color'],
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            item['time'],
                            style: const TextStyle(color: Colors.white24, fontSize: 9),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item['message'],
                        style: const TextStyle(color: Colors.white60, fontSize: 12),
                      ),
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
}
