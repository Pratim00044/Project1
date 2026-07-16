import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class PremiumFeaturesPage extends StatelessWidget {
  const PremiumFeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> _academies = [
      {'name': 'Elite Football Academy', 'owner': 'John Doe', 'plan': 'Pro Monthly', 'status': 'Active', 'expiry': '12 Dec 2024'},
      {'name': 'Dubai Junior Strikers', 'owner': 'Sarah Smith', 'plan': 'Enterprise Annual', 'status': 'Active', 'expiry': '01 Jan 2026'},
      {'name': 'Gulf Youth FC', 'owner': 'Ahmed Khan', 'plan': 'Basic Free', 'status': 'Expired', 'expiry': '30 Oct 2024'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('PREMIUM ACADEMY FEATURES', style: TextStyle(color: goldColor, fontWeight: FontWeight.bold, fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('SUBSCRIPTION MANAGEMENT', style: TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
            const SizedBox(height: 25),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _academies.length,
              itemBuilder: (context, index) {
                final aca = _academies[index];
                const List<Color> colors = [Color(0xFF1E3C31), Color(0xFF2A1B3D)];
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: colors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 4))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(aca['name']!, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: aca['status'] == 'Active' ? Colors.greenAccent.withOpacity(0.1) : Colors.redAccent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(aca['status']!, style: TextStyle(color: aca['status'] == 'Active' ? Colors.greenAccent : Colors.redAccent, fontSize: 9, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text('Owner: ${aca['owner']}', style: const TextStyle(color: Colors.white38, fontSize: 12)),
                      const Divider(color: Colors.white10, height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('CURRENT PLAN', style: TextStyle(color: Colors.white24, fontSize: 9, fontWeight: FontWeight.bold)),
                              Text(aca['plan']!, style: const TextStyle(color: goldColor, fontSize: 12, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('EXPIRY DATE', style: TextStyle(color: Colors.white24, fontSize: 9, fontWeight: FontWeight.bold)),
                              Text(aca['expiry']!, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.05),
                          minimumSize: const Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('MANAGE BILLING', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
