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
        'day': 'Today',
        'time': '08:30 AM',
        'icon': Icons.fitness_center_rounded,
        'color': const Color(0xFF38EF7D),
      },
      {
        'title': 'Player Performance Report Ready',
        'category': 'Analysis',
        'day': 'Today',
        'time': '11:15 AM',
        'icon': Icons.analytics_outlined,
        'color': const Color(0xFF007CFE),
      },
      {
        'title': 'Upcoming Match vs Tigers FC',
        'category': 'Match',
        'day': 'Yesterday',
        'time': '05:00 PM',
        'icon': Icons.sports_soccer_rounded,
        'color': goldColor,
      },
      {
        'title': 'New message from Team Manager',
        'category': 'Chat',
        'day': 'Yesterday',
        'time': '02:30 PM',
        'icon': Icons.chat_bubble_outline_rounded,
        'color': const Color(0xFFEE0979),
      },
      {
        'title': 'Squad Availability Updated',
        'category': 'Roster',
        'day': '2 days ago',
        'time': '09:00 AM',
        'icon': Icons.people_outline_rounded,
        'color': Colors.orangeAccent,
      },
    ];

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        title: const Text('NOTIFICATIONS',
            style: TextStyle(
                color: goldColor,
                fontSize: 14,
                fontWeight: FontWeight.w900,
                letterSpacing: 2)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all_rounded, color: goldColor, size: 20),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return _buildNotificationItem(item);
        },
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (item['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(item['icon'] as IconData, color: item['color'] as Color, size: 22),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item['category'].toString().toUpperCase(),
                        style: TextStyle(
                            color: item['color'] as Color,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1)),
                    Text('${item['day']} • ${item['time']}',
                        style: const TextStyle(color: Colors.white24, fontSize: 10)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(item['title'],
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
