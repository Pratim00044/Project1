import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class SecurityDetail extends StatelessWidget {
  const SecurityDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('PRIVACY & SECURITY',
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
            _buildSecurityOption(0, Icons.lock_outline, 'Change Password', 'Update your account password regularly'),
            _buildSecurityOption(1, Icons.fingerprint, 'Biometric Login', 'Enabled for quick and secure access'),
            _buildSecurityOption(2, Icons.devices, 'Active Sessions', 'Manage devices currently logged in'),
            _buildSecurityOption(3, Icons.verified_user_outlined, 'Two-Factor Auth', 'Add an extra layer of security'),
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

  Widget _buildSecurityOption(int index, IconData icon, String title, String sub) {
    final bool isEven = index % 2 == 0;
    final List<String> tileImages = [
      'assets/images/img1.jpeg',
      'assets/images/img2.jpeg',
      'assets/images/img3.jpeg',
      'assets/images/img4.jpeg',
    ];
    String currentImage = tileImages[index % tileImages.length];

    Widget iconWidget = Icon(icon, color: goldColor, size: 22);

    Widget contentWidget = Expanded(
      child: Column(
        crossAxisAlignment: isEven ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(title, 
            style: const TextStyle(
              color: Colors.white, 
              fontSize: 14, 
              fontWeight: FontWeight.bold,
              shadows: [Shadow(color: Colors.black, blurRadius: 4)],
            )
          ),
          const SizedBox(height: 4),
          Text(sub, 
            textAlign: isEven ? TextAlign.left : TextAlign.right,
            style: const TextStyle(
              color: Colors.white70, 
              fontSize: 11,
              shadows: [Shadow(color: Colors.black, blurRadius: 4)],
            )
          ),
        ],
      ),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(currentImage),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: isEven ? Alignment.centerLeft : Alignment.centerRight,
            end: isEven ? Alignment.centerRight : Alignment.centerLeft,
            colors: [
              Colors.black.withValues(alpha: 0.7),
              Colors.black.withValues(alpha: 0.2),
            ],
          ),
        ),
        child: Row(
          children: isEven 
            ? [iconWidget, const SizedBox(width: 20), contentWidget, const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 12)]
            : [const Icon(Icons.arrow_back_ios, color: Colors.white24, size: 12), contentWidget, const SizedBox(width: 20), iconWidget],
        ),
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
