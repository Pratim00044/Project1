import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class AttendanceDetail extends StatelessWidget {
  const AttendanceDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('ATTENDANCE HISTORY', 
          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 2)),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.white.withValues(alpha: 0.05), height: 1),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        itemCount: 20,
        itemBuilder: (context, index) {
          return _buildTimelineRecord(index);
        },
      ),
    );
  }

  Widget _buildTimelineRecord(int index) {
    String type = index % 3 == 0 ? 'MATCH' : (index % 3 == 1 ? 'TRAINING' : 'MEETING');
    Color accent = type == 'MATCH' ? Colors.blueAccent : (type == 'TRAINING' ? Colors.greenAccent : Colors.orangeAccent);
    
    final List<String> tileImages = [
      'assets/images/img1.jpeg',
      'assets/images/img2.jpeg',
      'assets/images/img3.jpeg',
      'assets/images/img4.jpeg',
    ];
    String currentImage = tileImages[index % tileImages.length];

    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
              ),
              Expanded(
                child: Container(width: 2, color: Colors.white10),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('0${(index % 30) + 1} JUL 2024', style: const TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                      image: DecorationImage(
                        image: AssetImage(currentImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(type == 'MATCH' ? 'LEAGUE MATCH' : (type == 'TRAINING' ? 'TACTICAL DRILL' : 'VIDEO ANALYSIS'),
                                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900)),
                            _buildPill('PRESENT', Colors.greenAccent),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildDetailItem(Icons.access_time, '09:00 AM - 11:30 AM'),
                        const SizedBox(height: 6),
                        _buildDetailItem(Icons.location_on, type == 'MATCH' ? 'MAIN STADIUM' : (type == 'TRAINING' ? 'PITCH A' : 'VIDEO ROOM')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPill(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 8, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildDetailItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white24, size: 12),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: Colors.white54, fontSize: 11)),
      ],
    );
  }
}
