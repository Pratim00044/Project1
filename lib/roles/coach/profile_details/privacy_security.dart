import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class PrivacySecurityPage extends StatelessWidget {
  const PrivacySecurityPage({super.key});

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
        title: const Text('PRIVACY & SECURITY', 
          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 4)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          _buildSectionHeader('SECURITY SETTINGS'),
          const SizedBox(height: 15),
          _buildMenuOption(Icons.lock_outline, 'Change Password', 'Update your account password'),
          _buildMenuOption(Icons.phonelink_lock, 'Two-Factor Authentication', 'Add an extra layer of security'),
          _buildMenuOption(Icons.fingerprint, 'Biometric Login', 'Use fingerprint or face ID'),
          
          const SizedBox(height: 35),
          _buildSectionHeader('PRIVACY SETTINGS'),
          const SizedBox(height: 15),
          _buildPrivacySwitch('Public Profile', 'Allow others to see your coaching stats', true),
          _buildPrivacySwitch('Share Performance', 'Share match data with other clubs', false),
          _buildPrivacySwitch('Data Analytics', 'Allow CORE SC to use your data for analysis', true),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title,
        style: const TextStyle(
            color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2));
  }

  Widget _buildMenuOption(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: surfaceColor, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Icon(icon, color: goldColor, size: 24),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.white10),
        ],
      ),
    );
  }

  Widget _buildPrivacySwitch(String title, String subtitle, bool initialValue) {
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
