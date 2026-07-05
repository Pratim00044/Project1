import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class OverviewSection extends StatelessWidget {
  const OverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
          child: Row(
            children: [
              _buildSharpDataBox(Icons.history, '39 Years', 'Aug 03, 1984'),
              const SizedBox(width: 12),
              _buildSharpDataBox(Icons.sports_soccer, 'Forward', 'Core FC'),
              const SizedBox(width: 12),
              _buildSharpDataBox(Icons.flash_on, 'Attack', 'Primary'),
            ],
          ),
        ),
        const SizedBox(height: 25),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 15),
          child: Text('MATCH ALERT',
              style: TextStyle(
                  color: Colors.white24,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _buildPremiumMatchCard(),
        ),
        const SizedBox(height: 35),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('MY CLUBS',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5)),
              TextButton(
                onPressed: () {},
                child: const Text('EXPLORE',
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _buildClubAffiliation('Dubai City FC', 'Pro League', true),
              const SizedBox(height: 12),
              _buildClubAffiliation('Eagle FC', 'First Division', false),
            ],
          ),
        ),
        const SizedBox(height: 35),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: const Text('EXPLORE LEAGUES',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              _buildEliteLeagueCard('11 A SIDE LEAGUES', "The Middle East's largest football league", Colors.greenAccent, '11', null),
              _buildEliteLeagueCard('7 A SIDE LEAGUES', 'Professionally run 7-a-side competitions', Colors.cyanAccent, '7', null),
              _buildEliteLeagueCard('LADIES LEAGUES', "Competitive women's football leagues", Colors.redAccent, 'W', null),
              _buildEliteLeagueCard('SOCIAL LEAGUES', 'Friendly matches and social football', Colors.green, null, Icons.sports_soccer),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEliteLeagueCard(String title, String sub, Color themeColor, String? leadingText, IconData? leadingIcon) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage('assets/images/login_background.jpeg'),
          fit: BoxFit.cover,
          opacity: 0.3,
        ),
        color: surfaceColor,
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 30,
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: const BorderRadius.horizontal(right: Radius.circular(4)),
                ),
              ),
              const SizedBox(width: 15),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: themeColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: leadingIcon != null
                      ? Icon(leadingIcon, color: themeColor, size: 24)
                      : Text(leadingText!, style: TextStyle(color: themeColor, fontSize: 20, fontWeight: FontWeight.w900)),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 0.5)),
                    const SizedBox(height: 4),
                    Text(sub, style: const TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Container(
                width: 32,
                height: 32,
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: themeColor.withValues(alpha: 0.3)),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.chevron_right, color: themeColor, size: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSharpDataBox(IconData icon, String val, String sub) {
    return Expanded(
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: Colors.white24, size: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(val,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold)),
                Text(sub,
                    style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 10,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumMatchCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                _buildMatchTeam('Emirates Club', true),
                const SizedBox(height: 16),
                _buildMatchTeam('United FC', false),
              ],
            ),
          ),
          Container(
              height: 40,
              width: 1,
              color: Colors.white.withValues(alpha: 0.05),
              margin: const EdgeInsets.symmetric(horizontal: 20)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('FEB 02',
                  style: TextStyle(
                      color: goldColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w900)),
              const SizedBox(height: 4),
              Text('22:00 PM',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 11,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMatchTeam(String name, bool highlight) {
    return Row(
      children: [
        Icon(Icons.shield, color: highlight ? goldColor : Colors.white10, size: 18),
        const SizedBox(width: 12),
        Text(name,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildClubAffiliation(String name, String league, bool active) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color: active
                ? goldColor.withValues(alpha: 0.3)
                : Colors.white.withValues(alpha: 0.03)),
      ),
      child: Row(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: const Icon(Icons.shield, color: goldColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Text(league,
                    style: const TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          if (active)
            Icon(Icons.verified, color: goldColor.withValues(alpha: 0.5), size: 22),
          const SizedBox(width: 12),
          const Icon(Icons.more_vert, color: Colors.white10),
        ],
      ),
    );
  }
}
