import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class TrialistDatabasePage extends StatelessWidget {
  const TrialistDatabasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('PRO PATHWAY DATABASE', style: TextStyle(color: goldColor, fontWeight: FontWeight.bold, fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            color: const Color(0xFF0D0D0D),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('PREMIUM ACCESS ACTIVE', style: TextStyle(color: Colors.greenAccent, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                      const SizedBox(height: 5),
                      const Text('Trialist Discovery', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const Text('View potential pro players', style: TextStyle(color: Colors.white38, fontSize: 12)),
                      const SizedBox(height: 5),
                      const Text('REGISTRATION FEE: 100-200 AED', style: TextStyle(color: goldColor, fontSize: 9, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: goldColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(15)),
                  child: const Icon(Icons.search, color: goldColor),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(25),
              itemCount: 4,
              itemBuilder: (context, index) {
                final trialists = [
                  {'name': 'Marcus Rashford (Trialist)', 'age': '19', 'pos': 'CM', 'data': '88 Pace | 82 Pass', 'fee': '150 AED'},
                  {'name': 'Bukayo Saka (Trialist)', 'age': '18', 'pos': 'AM', 'data': '90 Drib | 85 Skill', 'fee': '200 AED'},
                  {'name': 'Vinícius Júnior (Trialist)', 'age': '20', 'pos': 'LW', 'data': '95 Pace | 84 Cross', 'fee': '180 AED'},
                  {'name': 'Alphonso Davies (Trialist)', 'age': '21', 'pos': 'LB', 'data': '87 Stam | 89 Def', 'fee': '200 AED'},
                ];
                final t = trialists[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.02)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(radius: 12, backgroundColor: goldColor, child: Text(t['pos']!, style: const TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.bold))),
                              const SizedBox(width: 10),
                              Text(t['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                            ],
                          ),
                          Text('Age: ${t['age']}', style: const TextStyle(color: Colors.white24, fontSize: 11)),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(t['data']!, style: const TextStyle(color: goldColor, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1)),
                          Text('Fee Paid: ${t['fee']}', style: const TextStyle(color: Colors.greenAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                _showCV(context, t['name']!);
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white10),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text('VIEW CV', style: TextStyle(color: Colors.white70, fontSize: 11)),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _initiateTrial(context, t['name']!);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: goldColor.withValues(alpha: 0.1),
                                foregroundColor: goldColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                side: BorderSide(color: goldColor.withValues(alpha: 0.2)),
                              ),
                              child: const Text('INITIATE TRIAL', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
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

  void _showCV(BuildContext context, String name) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: surfaceColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name.toUpperCase(), style: const TextStyle(color: goldColor, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text('PROFESSIONAL PLAYER CV', style: TextStyle(color: Colors.white38, fontSize: 12, letterSpacing: 2)),
              const Divider(color: Colors.white10, height: 40),
              _buildCVDetail('Previous Club', 'Regional Elite Academy'),
              _buildCVDetail('Years Pro', '2 Years'),
              _buildCVDetail('Market Value', '₹45L (Potential)'),
              _buildCVDetail('Status', 'Active Trialist'),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: goldColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('DOWNLOAD PDF CV', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCVDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white60, fontSize: 12)),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _initiateTrial(BuildContext context, String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: surfaceColor,
        title: const Text('Initiate Trial?', style: TextStyle(color: goldColor)),
        content: Text('Are you sure you want to invite $name for a trial at your club? A finder\'s fee will be applicable upon signing.',
            style: const TextStyle(color: Colors.white70, fontSize: 13)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL', style: TextStyle(color: Colors.white24))),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Trial Invitation Sent to $name!')));
            },
            style: ElevatedButton.styleFrom(backgroundColor: goldColor),
            child: const Text('CONFIRM', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
