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
              color: surfaceColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: goldColor.withValues(alpha: 0.1)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [surfaceColor, const Color(0xFF1A1A1A)],
              ),
            ),
            child: Column(
              children: [
                const Icon(Icons.stars_rounded, color: goldColor, size: 48),
                const SizedBox(height: 15),
                const Text('PROFESSIONAL PATHWAY',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1)),
                const SizedBox(height: 10),
                const Text('Step into the professional world. Get scouted by top clubs like Core FC.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white38, fontSize: 12, height: 1.5)),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () => _showRegistrationDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: goldColor,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text('JOIN AS TRIALIST',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 14)),
                ),
                const SizedBox(height: 12),
                const Text('Registration Fee: 150 AED',
                    style: TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          
          const SizedBox(height: 25),
          const Text('FOR POTENTIAL PROS', 
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
          const SizedBox(height: 15),
          
          _buildActionCard(
            context,
            Icons.description_outlined,
            'CREATE DIGITAL CV',
            'Upload your technical data, match highlights, and career history for club managers.',
            () {},
          ),
          const SizedBox(height: 15),
          _buildActionCard(
            context,
            Icons.visibility_outlined,
            'CLUB VISIBILITY',
            'Top clubs like Core FC pay to access trialist data. Get your profile in front of decision makers.',
            () {},
          ),
          
          const SizedBox(height: 30),
          const Text('COACHES & MANAGERS', 
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
          const SizedBox(height: 15),
          
          _buildActionCard(
            context,
            Icons.assignment_ind_outlined,
            'PRO COACHING CV',
            'Register your coaching badges and tactical philosophy to find elite opportunities.',
            () {},
          ),
          
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(20),
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

  Widget _buildActionCard(BuildContext context, IconData icon, String title, String desc, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.02)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: goldColor.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: goldColor, size: 24),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(desc, style: const TextStyle(color: Colors.white38, fontSize: 11, height: 1.4)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white12),
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
                Text('150 AED', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
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
