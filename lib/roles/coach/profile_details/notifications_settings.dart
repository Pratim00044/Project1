import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class NotificationsSettingsPage extends StatelessWidget {
  const NotificationsSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('NOTIFICATIONS', 
          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 4)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          _buildSectionHeader('PUSH NOTIFICATIONS'),
          const SizedBox(height: 15),
          _buildNotificationSwitch('Match Reminders', 'Get notified about upcoming matches', true),
          _buildNotificationSwitch('Training Sessions', 'Updates on scheduled sessions', true),
          _buildNotificationSwitch('Goal Alerts', 'Real-time goal notifications during matches', false),
          
          const SizedBox(height: 35),
          _buildSectionHeader('SYSTEM ALERTS'),
          const SizedBox(height: 15),
          _buildNotificationSwitch('Performance Reports', 'Weekly tactical analysis summaries', true),
          _buildNotificationSwitch('News & Updates', 'Club news and management updates', true),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title,
        style: const TextStyle(
            color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2));
  }

  Widget _buildNotificationSwitch(String title, String subtitle, bool initialValue) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: surfaceColor, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          Switch(
            value: initialValue,
            onChanged: (val) {},
            activeColor: goldColor,
            activeTrackColor: goldColor.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }
}
