import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class SecurityDetail extends StatelessWidget {
  const SecurityDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: darkBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('PROFILE SECURITY', 
          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 2)),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.white.withValues(alpha: 0.05), height: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSecurityOption(Icons.lock_outline, 'Change Password', 'Update your account password regularly'),
            _buildSecurityOption(Icons.fingerprint, 'Biometric Login', 'Enabled for quick and secure access'),
            _buildSecurityOption(Icons.devices, 'Active Sessions', 'Manage devices currently logged in'),
            _buildSecurityOption(Icons.verified_user_outlined, 'Two-Factor Auth', 'Add an extra layer of security'),
            const SizedBox(height: 40),
            const Text('PRIVACY SETTINGS', style: TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
            const SizedBox(height: 20),
            _buildPrivacySwitch('Public Profile', true),
            _buildPrivacySwitch('Show Stats to Scouts', true),
            _buildPrivacySwitch('Receive Notifications', false),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityOption(IconData icon, String title, String sub) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
      ),
      child: Row(
        children: [
          Icon(icon, color: goldColor, size: 22),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(sub, style: const TextStyle(color: Colors.white38, fontSize: 11)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.white10, size: 12),
        ],
      ),
    );
  }

  Widget _buildPrivacySwitch(String label, bool value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500)),
          Switch(
            value: value,
            onChanged: (v) {},
            activeColor: goldColor,
            activeTrackColor: goldColor.withValues(alpha: 0.3),
            inactiveTrackColor: Colors.white10,
          ),
        ],
      ),
    );
  }
}
