import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('TERMS & CONDITIONS',
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w900,
                letterSpacing: 2)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('1. ACCEPTANCE OF TERMS',
                'By creating an account on Statixa, you agree to abide by these Terms and Conditions. If you do not agree to these terms, please do not use our services.'),
            _buildSection('2. USER ELIGIBILITY',
                'Users must be at least 13 years of age to register. If you are under 18, you represent that you have parental or guardian consent to use the app.'),
            _buildSection('3. ACCOUNT SECURITY',
                'You are responsible for maintaining the confidentiality of your account credentials. Any activities that occur under your account are your sole responsibility.'),
            _buildSection('4. DATA PRIVACY',
                'Your personal data is handled in accordance with our Privacy Policy. We collect information to improve your experience and manage club activities.'),
            _buildSection('5. CODE OF CONDUCT',
                'Users are expected to behave professionally. Harassment, abuse, or any illegal activities within the platform will result in immediate account termination.'),
            _buildSection('6. LIMITATION OF LIABILITY',
                'Statixa is not liable for any injuries, losses, or damages occurring during physical activities organized through the app.'),
            const SizedBox(height: 40),
            Center(
              child: Text(
                'Last Updated: July 20, 2026',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 10),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: goldColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1)),
          const SizedBox(height: 10),
          Text(content,
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 14,
                  height: 1.6)),
        ],
      ),
    );
  }
}
