import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class DisplayThemePage extends StatelessWidget {
  const DisplayThemePage({super.key});

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
        title: const Text('DISPLAY THEME', 
          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 4)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          _buildSectionHeader('APPEARANCE'),
          const SizedBox(height: 15),
          _buildThemeOption(Icons.dark_mode, 'Elite Dark Mode', 'System default dark theme', true),
          _buildThemeOption(Icons.light_mode, 'Standard Light Mode', 'Not recommended for elite UI', false),
          
          const SizedBox(height: 35),
          _buildSectionHeader('ACCENT COLOR'),
          const SizedBox(height: 15),
          Wrap(
            spacing: 15,
            runSpacing: 15,
            children: [
              _buildColorBox(goldColor, true),
              _buildColorBox(Colors.blueAccent, false),
              _buildColorBox(Colors.greenAccent, false),
              _buildColorBox(Colors.redAccent, false),
              _buildColorBox(Colors.purpleAccent, false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title,
        style: const TextStyle(
            color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2));
  }

  Widget _buildThemeOption(IconData icon, String title, String subtitle, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor, 
        borderRadius: BorderRadius.circular(20),
        border: isSelected ? Border.all(color: goldColor.withValues(alpha: 0.3)) : null,
      ),
      child: Row(
        children: [
          Icon(icon, color: isSelected ? goldColor : Colors.white24, size: 24),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: isSelected ? Colors.white : Colors.white38, fontSize: 16, fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(color: Colors.white24, fontSize: 12)),
              ],
            ),
          ),
          if (isSelected) const Icon(Icons.check_circle, color: goldColor, size: 20),
        ],
      ),
    );
  }

  Widget _buildColorBox(Color color, bool isSelected) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
        boxShadow: isSelected ? [BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 10)] : null,
      ),
    );
  }
}
