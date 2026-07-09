import 'package:flutter/material.dart';
import 'dashboard_sections/news_section.dart';
import 'dashboard_sections/session_section.dart';
import 'dashboard_sections/ranking_section.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('LATEST NEWS', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 2)),
        foregroundColor: goldColor,
        elevation: 0,
      ),
      body: const SingleChildScrollView(child: NewsSection()),
    );
  }
}

class SessionsPage extends StatelessWidget {
  const SessionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('ACADEMY SESSIONS', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 2)),
        foregroundColor: goldColor,
        elevation: 0,
      ),
      body: const SessionSection(),
    );
  }
}

class RankingsPage extends StatelessWidget {
  const RankingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('GLOBAL RANKINGS', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 2)),
        foregroundColor: goldColor,
        elevation: 0,
      ),
      body: const SingleChildScrollView(child: RankingSection()),
    );
  }
}
