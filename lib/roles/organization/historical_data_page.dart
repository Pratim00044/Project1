import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class HistoricalDataPage extends StatelessWidget {
  const HistoricalDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> _archives = [
      {'season': '2023 Winter', 'winner': 'National Gulf FC', 'mvp': 'Ryan Cooper'},
      {'season': '2023 Summer', 'winner': 'Turan Dubai FC', 'mvp': 'Sahal Samad'},
      {'season': '2022 Annual', 'winner': 'National Paints FC', 'mvp': 'Sunil Chhetri'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('HISTORICAL DATA', style: TextStyle(color: goldColor, fontWeight: FontWeight.bold, fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(25),
        itemCount: _archives.length,
        itemBuilder: (context, index) {
          final item = _archives[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['season']!, style: const TextStyle(color: goldColor, fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDataColumn('CHAMPIONS', item['winner']!),
                    _buildDataColumn('MVP', item['mvp']!),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDataColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
