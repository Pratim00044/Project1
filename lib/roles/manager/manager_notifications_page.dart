import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class ManagerNotificationsPage extends StatelessWidget {
  const ManagerNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        'title': 'New equipment request from Coach',
        'category': 'Logistics',
        'day': 'Today',
        'time': '10:45 AM',
        'colors': [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)]
      },
      {
        'title': 'Monthly budget report generated',
        'category': 'Finance',
        'day': 'Yesterday',
        'time': '04:00 PM',
        'colors': [const Color(0xFFEE0979), const Color(0xFFF12711)]
      },
      {
        'title': 'Sponsorship deal under review',
        'category': 'Contracts',
        'day': 'Yesterday',
        'time': '11:20 AM',
        'colors': [const Color(0xFF007CFE), const Color(0xFF004A99)]
      },
      {
        'title': 'New trialist registration received',
        'category': 'Recruitment',
        'day': '2 days ago',
        'time': '09:00 AM',
        'colors': [const Color(0xFF38EF7D), const Color(0xFF11998E)]
      },
    ];

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('NOTIFICATIONS',
            style: TextStyle(
                color: goldColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 2)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return _buildNotificationCard(item);
        },
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> item) {
    List<Color> colors = item['colors'] as List<Color>;
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colors.first.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(15)),
            child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['title'],
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(item['category'],
                    style: const TextStyle(color: Colors.white70, fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(item['day'],
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold)),
              Text(item['time'],
                  style: const TextStyle(color: Colors.white60, fontSize: 9)),
            ],
          ),
        ],
      ),
    );
  }
}
