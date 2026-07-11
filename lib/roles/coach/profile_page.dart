import 'package:flutter/material.dart';
import 'details/avg_point_history.dart';
import 'details/trophy_history.dart';
import 'details/win_rate_history.dart';
import 'details/managed_history.dart';
import 'profile_details/privacy_security.dart';
import 'profile_details/notifications_settings.dart';
import 'profile_details/display_theme.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);
const Color darkBg = Color(0xFF080808);

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: const Color(0xFF0D0D0D),
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/images/login_background.jpeg', fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, darkBg.withValues(alpha: 0.6), darkBg],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: goldColor, width: 2),
                          boxShadow: [BoxShadow(color: goldColor.withValues(alpha: 0.2), blurRadius: 20)],
                        ),
                        child: const CircleAvatar(
                          radius: 55,
                          backgroundColor: Color(0xFF1A1A1A),
                          child: Icon(Icons.person, size: 60, color: goldColor),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text('LIONEL SCALONI',
                        style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900, letterSpacing: 1)),
                      const SizedBox(height: 8),
                      _buildHeaderPill('HEAD COACH | CORE FC', isGold: true),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSmallStat('12', 'EXP'),
                          const SizedBox(width: 20),
                          _buildSmallStat('150', 'GAMES'),
                          const SizedBox(width: 20),
                          _buildSmallStat('A+', 'RATE'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined, color: goldColor)),
            ],
          ),
        ];
      },
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('SEASON PERFORMANCE'),
            const SizedBox(height: 15),
            _buildStatsGrid(),
            
            const SizedBox(height: 35),
            _buildSectionHeader('CAREER OVERVIEW'),
            const SizedBox(height: 15),
            _buildCareerGrid(),
            
            const SizedBox(height: 35),
            _buildSectionHeader('MATCH ACHIEVEMENTS'),
            const SizedBox(height: 15),
            _buildAchievementItem('Clean Sheet', 'v Mohun Bagan', 'assets/images/img3.jpeg'),
            _buildAchievementItem('Goal Scored', 'v Kerala Blasters', 'assets/images/img4.jpeg'),
            
            const SizedBox(height: 35),
            _buildSectionHeader('ACADEMY RECRUITMENT'),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: goldColor.withOpacity(0.1)),
                image: const DecorationImage(
                  image: AssetImage('assets/images/img1.jpeg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('COACH CV', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(color: goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                        child: const Text('PRO', style: TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.w900)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text('Upload your professional CV to be discovered by top academies across the UAE.', 
                    style: TextStyle(color: Colors.white38, fontSize: 12)),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.upload_file_rounded, color: Colors.black, size: 18),
                    label: const Text('UPLOAD CV', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: goldColor,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text('Recruitment fee: 50 AED / upload', 
                      style: TextStyle(color: Colors.white24, fontSize: 9, fontStyle: FontStyle.italic)),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 35),
            _buildSectionHeader('ACCOUNT & SETTINGS'),
            const SizedBox(height: 15),
            _buildMenuOption(context, Icons.security, 'Privacy & Security', const PrivacySecurityPage(), 'assets/images/img1.jpeg'),
            _buildMenuOption(context, Icons.notifications_active_outlined, 'Notifications', const NotificationsSettingsPage(), 'assets/images/img2.jpeg'),
            _buildMenuOption(context, Icons.dark_mode_outlined, 'Display Theme', const DisplayThemePage(), 'assets/images/img3.jpeg'),
            const SizedBox(height: 30),
            _buildLogoutButton(context),
            const SizedBox(height: 12),
            _buildDeleteAccountButton(context),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallStat(String val, String label) {
    return Column(
      children: [
        Text(val, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900)),
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 9, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildHeaderPill(String text, {bool isGold = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: isGold ? goldColor.withOpacity(0.1) : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isGold ? goldColor.withOpacity(0.3) : Colors.white10),
      ),
      child: Text(text, 
        style: TextStyle(color: isGold ? goldColor : Colors.white70, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.8,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        _buildStatCard('A+', 'TACTICAL', Icons.analytics, goldColor, 'assets/images/img1.jpeg'),
        _buildStatCard('12', 'TROPHIES', Icons.emoji_events, Colors.blueAccent, 'assets/images/img2.jpeg'),
        _buildStatCard('85%', 'WIN RATE', Icons.trending_up, Colors.greenAccent, 'assets/images/img3.jpeg'),
        _buildStatCard('150', 'MANAGED', Icons.sports, Colors.orangeAccent, 'assets/images/img4.jpeg'),
      ],
    );
  }

  Widget _buildStatCard(String val, String label, IconData icon, Color color, String imagePath) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 14),
              const SizedBox(width: 6),
              Text(label, style: const TextStyle(color: Colors.white38, fontSize: 9, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          Text(val, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title,
        style: const TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5));
  }

  Widget _buildCareerGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 2.5,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        _buildInfoCard(Icons.badge, 'LICENSE', 'UEFA Pro', 'assets/images/img1.jpeg'),
        _buildInfoCard(Icons.sports_soccer, 'PREV', 'Bengal Warriors', 'assets/images/img2.jpeg'),
      ],
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value, String imagePath) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: goldColor.withOpacity(0.4), size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label, style: const TextStyle(color: Colors.white30, fontSize: 8, fontWeight: FontWeight.bold)),
                Text(value, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementItem(String title, String subtitle, String imagePath) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.stars, color: goldColor, size: 24),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(color: Colors.white38, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuOption(BuildContext context, IconData icon, String title, Widget targetPage, String imagePath) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => targetPage)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: goldColor.withOpacity(0.7), size: 20),
            const SizedBox(width: 18),
            Text(title, style: const TextStyle(color: Colors.white70, fontSize: 15, fontWeight: FontWeight.w500)),
            const Spacer(),
            const Icon(Icons.chevron_right, size: 20, color: Colors.white10),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white70,
        side: const BorderSide(color: Colors.white10, width: 1.5),
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: const Text('LOG OUT ACCOUNT', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
    );
  }

  Widget _buildDeleteAccountButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xFF1A1A1A),
            title: const Text('Delete Account?', style: TextStyle(color: Colors.white)),
            content: const Text('This action is permanent and cannot be undone.', style: TextStyle(color: Colors.white60)),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL')),
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('DELETE', style: TextStyle(color: Colors.redAccent))),
            ],
          ),
        );
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.redAccent.withOpacity(0.7),
        minimumSize: const Size(double.infinity, 40),
      ),
      child: const Text('DELETE ACCOUNT PERMANENTLY', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
    );
  }
}
