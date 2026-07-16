import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class CoachRecruitmentHub extends StatelessWidget {
  const CoachRecruitmentHub({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> _coaches = [
      {'name': 'Arsene Wenger', 'exp': '20+ Years', 'license': 'UEFA Pro', 'fee': 'Paid', 'status': 'Available'},
      {'name': 'Pep Guardiola', 'exp': '15 Years', 'license': 'UEFA Pro', 'fee': 'Paid', 'status': 'Negotiating'},
      {'name': 'Zinedine Zidane', 'exp': '10 Years', 'license': 'UEFA Pro', 'fee': 'Pending', 'status': 'Available'},
      {'name': 'Jurgen Klopp', 'exp': '18 Years', 'license': 'UEFA Pro', 'fee': 'Paid', 'status': 'Hired'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('COACH RECRUITMENT HUB', style: TextStyle(color: Colors.purpleAccent, fontWeight: FontWeight.bold, fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            color: Colors.purpleAccent.withOpacity(0.05),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.purpleAccent, size: 20),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    'Academies pay a fee to access these premium coach profiles. Coaches pay a registration fee to list their CVs.',
                    style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(25),
              itemCount: _coaches.length,
              itemBuilder: (context, index) {
                final coach = _coaches[index];
                const List<Color> colors = [Color(0xFF1E3C31), Color(0xFF2A1B3D)];
                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: colors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 4))
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.purpleAccent.withOpacity(0.1),
                            child: const Icon(Icons.person, color: Colors.purpleAccent),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(coach['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                                Text('${coach['license']} | ${coach['exp']} Exp', style: const TextStyle(color: Colors.white38, fontSize: 12)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: coach['fee'] == 'Paid' ? Colors.greenAccent.withOpacity(0.1) : Colors.redAccent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              coach['fee']!,
                              style: TextStyle(color: coach['fee'] == 'Paid' ? Colors.greenAccent : Colors.redAccent, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white10),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text('VIEW FULL CV', style: TextStyle(color: Colors.white70, fontSize: 11)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purpleAccent.withOpacity(0.2),
                                foregroundColor: Colors.purpleAccent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text('CONTACT', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
