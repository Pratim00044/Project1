import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);

class PlayerInterestsPage extends StatefulWidget {
  final String gameType;
  const PlayerInterestsPage({super.key, required this.gameType});

  @override
  State<PlayerInterestsPage> createState() => _PlayerInterestsPageState();
}

class _PlayerInterestsPageState extends State<PlayerInterestsPage> {
  final List<Map<String, dynamic>> _interestedPlayers = [
    {'name': 'Marcus Rashford', 'position': 'FW', 'rating': '8.2', 'status': 'PENDING'},
    {'name': 'Kevin De Bruyne', 'position': 'MF', 'rating': '9.0', 'status': 'ACCEPTED'},
    {'name': 'Virgil van Dijk', 'position': 'DF', 'rating': '8.8', 'status': 'ACCEPTED'},
    {'name': 'Alisson Becker', 'position': 'GK', 'rating': '8.5', 'status': 'PENDING'},
    {'name': 'Bukayo Saka', 'position': 'RW', 'rating': '8.4', 'status': 'PENDING'},
    {'name': 'Jude Bellingham', 'position': 'MF', 'rating': '8.9', 'status': 'ACCEPTED'},
    {'name': 'Phil Foden', 'position': 'LW', 'rating': '8.7', 'status': 'PENDING'},
    {'name': 'Rodri', 'position': 'DM', 'rating': '8.6', 'status': 'ACCEPTED'},
    {'name': 'Kyle Walker', 'position': 'RB', 'rating': '8.1', 'status': 'PENDING'},
    {'name': 'Luke Shaw', 'position': 'LB', 'rating': '7.9', 'status': 'PENDING'},
    {'name': 'Harry Kane', 'position': 'ST', 'rating': '9.1', 'status': 'ACCEPTED'},
    {'name': 'Declan Rice', 'position': 'DM', 'rating': '8.5', 'status': 'PENDING'},
  ];

  int get _acceptedCount => _interestedPlayers.where((p) => p['status'] == 'ACCEPTED').length;
  int get _maxPlayers => int.tryParse(widget.gameType.split('-')[0]) ?? 11;

  void _updateStatus(int index, String newStatus) {
    if (newStatus == 'ACCEPTED' && _acceptedCount >= _maxPlayers) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Squad is FULL! Max $_maxPlayers players allowed for ${widget.gameType}.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }
    setState(() {
      _interestedPlayers[index]['status'] = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isFull = _acceptedCount >= _maxPlayers;

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: darkBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.gameType.toUpperCase(), 
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1)),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text('$_acceptedCount / $_maxPlayers', 
                style: TextStyle(
                  color: isFull ? greenAccent : Colors.white70, 
                  fontWeight: FontWeight.w900, 
                  fontSize: 16
                )),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          if (isFull)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: greenAccent.withValues(alpha: 0.1),
              child: const Text('SQUAD FULL - NO MORE PLAYERS CAN BE ADDED', 
                textAlign: TextAlign.center,
                style: TextStyle(color: greenAccent, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
            ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('INTERESTED PLAYERS', style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                Text('${_interestedPlayers.length} REQUESTS', style: const TextStyle(color: Colors.white24, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _interestedPlayers.length,
              itemBuilder: (context, index) {
                final player = _interestedPlayers[index];
                String status = player['status'];
                bool isAccepted = status == 'ACCEPTED';
                bool isPending = status == 'PENDING';

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: isAccepted ? greenAccent.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.05)),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white.withValues(alpha: 0.05),
                        child: Text(player['position'], style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(player['name'], style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.star, color: goldColor, size: 12),
                                const SizedBox(width: 4),
                                Text(player['rating'], style: const TextStyle(color: Colors.white38, fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (isPending) ...[
                        IconButton(
                          icon: const Icon(Icons.check_circle_outline, color: greenAccent, size: 28),
                          onPressed: () => _updateStatus(index, 'ACCEPTED'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.cancel_outlined, color: Colors.redAccent, size: 28),
                          onPressed: () => _updateStatus(index, 'REJECTED'),
                        ),
                      ] else ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isAccepted ? greenAccent.withValues(alpha: 0.1) : Colors.redAccent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(status, style: TextStyle(color: isAccepted ? greenAccent : Colors.redAccent, fontSize: 10, fontWeight: FontWeight.w900)),
                        ),
                        if (!isPending)
                          IconButton(
                            icon: const Icon(Icons.refresh, color: Colors.white24, size: 18),
                            onPressed: () => _updateStatus(index, 'PENDING'),
                          ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Submission Completed! Squad finalized.'), backgroundColor: greenAccent),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: goldColor,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 0,
              ),
              child: const Text('COMPLETE SUBMISSION', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, letterSpacing: 1)),
            ),
          ),
        ],
      ),
    );
  }
}
