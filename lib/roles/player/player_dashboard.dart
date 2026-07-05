import 'package:flutter/material.dart';
import 'dashboard_sections/overview_section.dart';
import 'dashboard_sections/news_section.dart';
import 'dashboard_sections/session_section.dart';
import 'dashboard_sections/ranking_section.dart';
import 'dashboard_sections/stats_section.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);
const Color cardLightColor = Color(0xFFC0C0C0);
const Color silverText = Color(0xFFB0B0B0);

class PlayerDashboard extends StatefulWidget {
  const PlayerDashboard({super.key});

  @override
  State<PlayerDashboard> createState() => _PlayerDashboardState();
}

class _PlayerDashboardState extends State<PlayerDashboard> {
  String _activeTab = 'Overview';
  final List<String> _tabHistory = ['Overview'];

  void _changeTab(String label) {
    if (_activeTab != label) {
      setState(() {
        _activeTab = label;
        _tabHistory.add(label);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _activeTab == 'Overview' && _tabHistory.length <= 1,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_tabHistory.length > 1) {
          setState(() {
            _tabHistory.removeLast();
            _activeTab = _tabHistory.last;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                child: _buildUniqueHeroCard(),
              ),
            ),

        SliverToBoxAdapter(
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isWide = constraints.maxWidth > 800;
              if (isWide) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTabLink('Overview'),
                      _buildTabLink('News'),
                      _buildTabLink('Session'),
                      _buildTabLink('Ranking'),
                      _buildTabLink('Stats'),
                    ],
                  ),
                );
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    _buildTabLink('Overview'),
                    const SizedBox(width: 35),
                    _buildTabLink('News'),
                    const SizedBox(width: 35),
                    _buildTabLink('Session'),
                    const SizedBox(width: 35),
                    _buildTabLink('Ranking'),
                    const SizedBox(width: 35),
                    _buildTabLink('Stats'),
                  ],
                ),
              );
            },
          ),
        ),

        SliverToBoxAdapter(
          child: _buildActiveContent(),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 50)),
          ],
        ),
      ),
    ),
  );
}

  Widget _buildActiveContent() {
    switch (_activeTab) {
      case 'Overview':
        return const OverviewSection();
      case 'News':
        return const NewsSection();
      case 'Session':
        return const SessionSection();
      case 'Ranking':
        return const RankingSection();
      case 'Stats':
        return StatsSection(
          onSeeHistory: () {
            // History navigation removed as requested
          },
        );
      default:
        return const OverviewSection();
    }
  }

  Widget _buildUniqueHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: cardLightColor,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: cardLightColor.withValues(alpha: 0.2),
            blurRadius: 40,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black.withValues(alpha: 0.05), width: 4),
              image: const DecorationImage(
                image: AssetImage('assets/images/sunil.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Sunil',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                    letterSpacing: -0.5,
                  ),
                ),
                const FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Chhetri',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      height: 1.0,
                      letterSpacing: -1,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.shield, color: Colors.black45, size: 16),
                        SizedBox(width: 8),
                        Text(
                          'CORE FC',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabLink(String label) {
    bool isActive = _activeTab == label;
    return GestureDetector(
      onTap: () => _changeTab(label),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: isActive ? Colors.white : Colors.white24,
          fontSize: 14,
          fontWeight: isActive ? FontWeight.w900 : FontWeight.w600,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
