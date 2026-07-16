import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class ManagerApprovalsPage extends StatelessWidget {
  const ManagerApprovalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> approvals = [
      {'title': 'Equipment Purchase', 'desc': 'New training cones & balls for U10s', 'amount': '₹15,000', 'status': 'Pending'},
      {'title': 'Travel Request', 'desc': 'Inter-city bus for Senior Squad', 'amount': '₹8,500', 'status': 'Urgent'},
      {'title': 'Trialist Onboarding', 'desc': 'Registration for 5 new trialists', 'amount': '₹750', 'status': 'Review'},
      {'title': 'Ground Maintenance', 'desc': 'Pitch repair at Town Square', 'amount': '₹25,000', 'status': 'Pending'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        centerTitle: true,
        title: const Text('PENDING APPROVALS', style: TextStyle(color: goldColor, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: approvals.length,
        itemBuilder: (context, index) {
          final item = approvals[index];
          List<Color> gradientColors;
          if (item['status'] == 'Urgent') {
            gradientColors = [const Color(0xFF311B92), const Color(0xFF12005E)]; // Deep Purple
          } else if (item['status'] == 'Review') {
            gradientColors = [const Color(0xFF263238), const Color(0xFF000A12)]; // Charcoal
          } else {
            gradientColors = [const Color(0xFF1B222E), const Color(0xFF0D121A)]; // Midnight
          }

          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(color: gradientColors.first.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 4))
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.rule_rounded, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['title'], style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(item['desc'], style: const TextStyle(color: Colors.white70, fontSize: 11)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(item['amount'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6)),
                      child: Text(item['status'].toUpperCase(), 
                        style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
