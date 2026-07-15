import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class ManagerContractsPage extends StatelessWidget {
  const ManagerContractsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> contracts = [
      {'name': 'Sunil Chhetri', 'role': 'Senior Player', 'expiry': '15 Aug 2024', 'type': 'Pro'},
      {'name': 'Sandesh Jhingan', 'role': 'Senior Player', 'expiry': '01 Sep 2024', 'type': 'Pro'},
      {'name': 'Sahal Samad', 'role': 'Academy Player', 'expiry': '22 Jul 2024', 'type': 'Academy'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        centerTitle: true,
        title: const Text('CONTRACT RENEWALS', style: TextStyle(color: goldColor, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: contracts.length,
        itemBuilder: (context, index) {
          final item = contracts[index];
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
                const CircleAvatar(
                  backgroundColor: Color(0xFF1A1A1A),
                  child: Icon(Icons.description_rounded, color: Colors.orangeAccent, size: 20),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['name'], style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(item['role'], style: const TextStyle(color: Colors.white38, fontSize: 11)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('EXPIRES', style: TextStyle(color: Colors.white24, fontSize: 8, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(item['expiry'], style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 12)),
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
