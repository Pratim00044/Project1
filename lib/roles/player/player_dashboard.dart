import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dashboard_sections/overview_section.dart';
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
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/Video/Banner.mp4')
      ..initialize().then((_) {
        setState(() {});
        _videoController.setLooping(true);
        _videoController.setVolume(0);
        _videoController.play();
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

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
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: _buildUniqueHeroCard(),
          ),
        ),

        const SliverToBoxAdapter(
          child: OverviewSection(),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 50)),
      ],
    );
  }

  Widget _buildActiveContent() {
    switch (_activeTab) {
      case 'Overview':
        return const OverviewSection();
      case 'Stats':
        return StatsSection(
          onSeeHistory: () {
          },
        );
      default:
        return const OverviewSection();
    }
  }

  Widget _buildUniqueHeroCard() {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFED8F03).withValues(alpha: 0.3),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (_videoController.value.isInitialized)
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _videoController.value.size.width,
                    height: _videoController.value.size.height,
                    child: VideoPlayer(_videoController),
                  ),
                ),
              ),
            ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black.withValues(alpha: 0.4),
                  Colors.black.withValues(alpha: 0.8),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 2.0),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/sunil.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'LIONEL MESSI',
                  style: TextStyle(
                    color: goldColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    height: 1.0,
                    letterSpacing: -0.5,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                      )
                    ],
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? goldColor.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? goldColor.withValues(alpha: 0.3) : Colors.white10,
            width: 1,
          ),
        ),
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            color: isActive ? goldColor : Colors.white,
            fontSize: 12,
            fontWeight: isActive ? FontWeight.w900 : FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
