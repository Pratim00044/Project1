import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class ManagerSettingsPage extends StatelessWidget {
  const ManagerSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(25),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const Text('PREFERENCES',
                  style: TextStyle(
                      color: goldColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2)),
              const SizedBox(height: 25),
              _buildSettingsGroup('ACCOUNT', [
                _buildSettingsTile(Icons.person_outline, 'Personal Information'),
                _buildSettingsTile(Icons.security, 'Password & Security'),
                _buildSettingsTile(Icons.language, 'Language Preferences'),
              ]),
              const SizedBox(height: 35),
              _buildSettingsGroup('CLUB SETTINGS', [
                _buildSettingsTile(Icons.notifications_none, 'Notification Controls'),
                _buildSettingsTile(Icons.visibility_outlined, 'Privacy Policy'),
                _buildSettingsTile(Icons.info_outline, 'Terms of Service'),
              ]),
              const SizedBox(height: 40),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.redAccent, width: 1),
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text('DEACTIVATE CLUB ACCOUNT',
                    style: TextStyle(color: Colors.redAccent, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsGroup(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingsTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white38, size: 20),
      title: Text(title, style: const TextStyle(color: Colors.white70, fontSize: 14)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white10, size: 12),
      onTap: () {},
    );
  }
}
