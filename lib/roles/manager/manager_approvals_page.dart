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
        title: const Text('PENDING APPROVALS', style: TextStyle(color: goldColor, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2)),
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: approvals.length,
        itemBuilder: (context, index) {
          final item = approvals[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.02)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: goldColor.withValues(alpha: 0.1),
                  child: const Icon(Icons.rule_rounded, color: goldColor, size: 20),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['title'], style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(item['desc'], style: const TextStyle(color: Colors.white38, fontSize: 11)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(item['amount'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14)),
                    const SizedBox(height: 4),
                    Text(item['status'].toUpperCase(), 
                      style: TextStyle(color: item['status'] == 'Urgent' ? Colors.redAccent : goldColor, fontSize: 9, fontWeight: FontWeight.bold)),
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
