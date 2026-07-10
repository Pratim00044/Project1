import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class ProfessionalPathwayPage extends StatelessWidget {
  const ProfessionalPathwayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF007CFE).withValues(alpha: 0.8),
                  const Color(0xFF004A99).withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              image: const DecorationImage(
                image: AssetImage('assets/images/img2.jpeg'),
                fit: BoxFit.cover,
                opacity: 0.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF007CFE).withValues(alpha: 0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: Column(
              children: [
                const Icon(Icons.stars_rounded, color: Colors.white, size: 48),
                const SizedBox(height: 15),
                const Text('PROFESSIONAL PATHWAY',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1)),
                const SizedBox(height: 10),
                const Text('Step into the professional world. Get scouted by top clubs like Core FC, Dubai Lions FC, and Eagle FC.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5)),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () => _showRegistrationDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text('JOIN AS TRIALIST',
                      style: TextStyle(color: Color(0xFF004A99), fontWeight: FontWeight.w900, fontSize: 14)),
                ),
                const SizedBox(height: 12),
                const Text('Next Trials: July 15th - Zayed Sports City',
                    style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          
          const SizedBox(height: 35),
          const Text('UPCOMING OPPORTUNITIES', 
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
          const SizedBox(height: 15),
          
          _buildActionCard(
            context,
            Icons.explore,
            'DUBAI CITY FC TRIALS',
            'Open trials for U23 squad. Registration closing on July 10th.',
            [const Color(0xFF38EF7D), const Color(0xFF11998E)],
            () {},
          ),
          const SizedBox(height: 15),
          _buildActionCard(
            context,
            Icons.explore,
            'SHARJAH ELITE ACADEMY',
            'Scouting event for defensive midfielders. Minimum age 16.',
            [const Color(0xFFEE0979), const Color(0xFFF12711)],
            () {},
          ),
          const SizedBox(height: 35),
          const Text('FOR POTENTIAL PROS', 
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
          const SizedBox(height: 15),
          
          _buildActionCard(
            context,
            Icons.description_outlined,
            'CREATE DIGITAL CV',
            'Upload your technical data, match highlights, and career history for club managers.',
            [const Color(0xFFFFB75E), const Color(0xFFED8F03)],
            () {},
          ),
          const SizedBox(height: 15),
          _buildActionCard(
            context,
            Icons.visibility_outlined,
            'CLUB VISIBILITY',
            'Top clubs like Core FC pay to access trialist data. Get your profile in front of decision makers.',
            [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)],
            () {},
          ),
          
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: goldColor, size: 20),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    'Note: A finders fee applies upon successful club placement.',
                    style: TextStyle(color: Colors.white54, fontSize: 11, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, IconData icon, String title, String desc, List<Color> colors, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colors[0].withValues(alpha: 0.8),
              colors[1].withValues(alpha: 0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
            image: AssetImage('assets/images/img3.jpeg'),
            fit: BoxFit.cover,
            opacity: 0.4,
          ),
          boxShadow: [
            BoxShadow(
              color: colors[0].withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(desc, style: const TextStyle(color: Colors.white70, fontSize: 11, height: 1.4)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white38),
          ],
        ),
      ),
    );
  }

  void _showRegistrationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        title: const Text('TRIALIST REGISTRATION', 
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Benefits include:', style: TextStyle(color: goldColor, fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildDialogBenefit('Direct scout access from Core FC'),
            _buildDialogBenefit('Professional Digital CV Setup'),
            _buildDialogBenefit('Match Data Integration'),
            const SizedBox(height: 20),
            const Divider(color: Colors.white10),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Registration Fee', style: TextStyle(color: Colors.white60, fontSize: 13)),
                const Text('150 AED', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL', style: TextStyle(color: Colors.white38))),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: goldColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: const Text('PAY NOW', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogBenefit(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.greenAccent, size: 14),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 11))),
        ],
      ),
    );
  }
}
