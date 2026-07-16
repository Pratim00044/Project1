import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);

class PlayerReserveSpot extends StatefulWidget {
  final String title;
  final String date;
  final String time;
  final String location;
  final String type; // e.g., "7S", "5S", etc.

  const PlayerReserveSpot({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.type,
  });

  @override
  State<PlayerReserveSpot> createState() => _PlayerReserveSpotState();
}

class _PlayerReserveSpotState extends State<PlayerReserveSpot> {
  int? _selectedSpotIndex;
  bool _isReservedByMe = false;
  int? _myReservedSpotIndex;

  // Mock data for players already in spots
  late List<Map<String, dynamic>> _playerSpots;

  @override
  void initState() {
    super.initState();
    _initializeSpots();
  }

  void _initializeSpots() {
    int playersPerSide = _getPlayersCount(widget.type);
    int totalSpots = playersPerSide * 2;
    
    // Generate positions based on formation
    List<Offset> positions = _getPositions(widget.type);

    _playerSpots = List.generate(totalSpots, (index) {
      // Mock: Occupy some spots initially
      bool isOccupied = index < (totalSpots * 0.6).floor() && index != 5; 
      return {
        'id': index,
        'pos': positions[index],
        'isOccupied': isOccupied,
        'name': isOccupied ? 'Player $index' : null,
        'image': isOccupied ? 'assets/images/sunil.png' : null,
        'label': _getPositionLabel(index, playersPerSide),
      };
    });
  }

  int _getPlayersCount(String type) {
    RegExp regExp = RegExp(r'(\d+)');
    var match = regExp.firstMatch(type);
    if (match != null) {
      return int.parse(match.group(1)!);
    }
    return 7; // Default
  }

  String _getPositionLabel(int index, int perSide) {
    int sideIndex = index % perSide;
    List<String> labels5s = ['GK', 'DF', 'LM', 'RM', 'ST'];
    List<String> labels6s = ['GK', 'LDF', 'RDF', 'LMF', 'RMF', 'ST'];
    List<String> labels7s = ['GK', 'LB', 'RB', 'LM', 'CM', 'RM', 'ST'];
    List<String> labels8s = ['GK', 'LDF', 'RDF', 'LMF', 'CMF', 'RMF', 'LST', 'RST'];
    List<String> labels9s = ['GK', 'LDF', 'CDF', 'RDF', 'LMF', 'CMF', 'RMF', 'LST', 'RST'];
    
    if (perSide == 5) return labels5s[sideIndex % labels5s.length];
    if (perSide == 6) return labels6s[sideIndex % labels6s.length];
    if (perSide == 7) return labels7s[sideIndex % labels7s.length];
    if (perSide == 8) return labels8s[sideIndex % labels8s.length];
    if (perSide == 9) return labels9s[sideIndex % labels9s.length];
    return 'P'; // Player
  }

  List<Offset> _getPositions(String type) {
    int perSide = _getPlayersCount(type);
    List<Offset> side1 = [];
    List<Offset> side2 = [];

    // Compact coordinates for 680px height
    if (perSide == 5) {
      side1 = [
        const Offset(0.5, 0.05), // GK
        const Offset(0.5, 0.22), // DF
        const Offset(0.2, 0.35), // LM
        const Offset(0.8, 0.35), // RM
        const Offset(0.5, 0.45), // ST
      ];
    } else if (perSide == 6) {
      side1 = [
        const Offset(0.5, 0.05), // GK
        const Offset(0.3, 0.18), // LDF
        const Offset(0.7, 0.18), // RDF
        const Offset(0.2, 0.32), // LMF
        const Offset(0.8, 0.32), // RMF
        const Offset(0.5, 0.45), // ST
      ];
    } else if (perSide == 7) {
      side1 = [
        const Offset(0.5, 0.05), // GK
        const Offset(0.25, 0.18), // LB
        const Offset(0.75, 0.18), // RB
        const Offset(0.15, 0.32), // LM
        const Offset(0.5, 0.32),  // CM
        const Offset(0.85, 0.32), // RM
        const Offset(0.5, 0.45),  // ST
      ];
    } else if (perSide == 8) {
      side1 = [
        const Offset(0.5, 0.04), // GK
        const Offset(0.25, 0.18), // LDF
        const Offset(0.75, 0.18), // RDF
        const Offset(0.15, 0.30), // LMF
        const Offset(0.5, 0.32), // CMF
        const Offset(0.85, 0.30), // RMF
        const Offset(0.35, 0.45), // LST
        const Offset(0.65, 0.45), // RST
      ];
    } else if (perSide == 9) {
      side1 = [
        const Offset(0.5, 0.04), // GK
        const Offset(0.2, 0.15), // LDF
        const Offset(0.5, 0.18), // CDF
        const Offset(0.8, 0.15), // RDF
        const Offset(0.15, 0.30), // LMF
        const Offset(0.5, 0.30), // CMF
        const Offset(0.85, 0.30), // RMF
        const Offset(0.35, 0.45), // LST
        const Offset(0.65, 0.45), // RST
      ];
    } else {
      // Fallback
      side1 = List.generate(perSide, (i) {
        double x = 0.2 + (i % 3) * 0.3;
        double y = 0.05 + (i ~/ 3) * 0.12;
        return Offset(x, y);
      });
    }

    // Mirror for side 2 (bottom half of field)
    side2 = side1.map((p) => Offset(p.dx, 1.0 - p.dy)).toList();
    
    return [...side1, ...side2];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            // Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildHeaderBtn(Icons.arrow_back, 'BACK', () => Navigator.pop(context)),
                  _buildHeaderBtn(Icons.bookmark_border, 'MY BOOKINGS', () {}),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Title and Badges
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildPill(widget.type, greenAccent, Colors.black),
                      const SizedBox(width: 8),
                      if (_isReservedByMe) _buildPill('BOOKED', greenAccent, Colors.black),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Pitch Container
            Container(
              height: 680, // Decreased by 20% from 850px
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/ground.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    // Players
                    ..._playerSpots.map((spot) => _buildPlayerSpot(spot)),
                  ],
                ),
              ),
            ),
            // Bottom Info Panel
            _buildBottomPanel(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBtn(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: greenAccent.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: greenAccent, size: 16),
            const SizedBox(width: 5),
            Text(label, style: const TextStyle(color: greenAccent, fontSize: 10, fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }

  Widget _buildPill(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: TextStyle(color: text, fontSize: 10, fontWeight: FontWeight.w900)),
    );
  }

  Widget _buildPlayerSpot(Map<String, dynamic> spot) {
    int index = spot['id'];
    bool isOccupied = spot['isOccupied'];
    bool isSelected = _selectedSpotIndex == index;
    bool isMine = _myReservedSpotIndex == index;
    Offset pos = spot['pos'];

    return Align(
      alignment: FractionalOffset(pos.dx, pos.dy),
      child: GestureDetector(
        onTap: () {
          if (isOccupied && !isMine) return;
          setState(() {
            _selectedSpotIndex = index;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isMine)
              Container(
                margin: const EdgeInsets.only(bottom: 4),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(4)),
                child: Text('YOU - ${spot['label']}', style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w900)),
              ),
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isOccupied || isMine ? Colors.transparent : Colors.black26,
                border: Border.all(
                  color: isSelected ? greenAccent : (isOccupied || isMine ? goldColor : Colors.white24),
                  width: isSelected ? 3 : 1.5,
                ),
                boxShadow: isSelected ? [BoxShadow(color: greenAccent.withValues(alpha: 0.5), blurRadius: 10)] : null,
              ),
              child: ClipOval(
                child: isMine || (isOccupied && spot['image'] != null)
                    ? Image.asset(isMine ? 'assets/images/sunil.png' : spot['image'], fit: BoxFit.cover)
                    : Center(
                        child: Text(
                          isMine ? 'YOU' : (isOccupied ? 'JP' : spot['label']),
                          style: TextStyle(
                            color: isOccupied ? Colors.white : Colors.white24,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              isMine ? 'YOU' : (isOccupied ? (spot['name'] ?? 'Player') : ''),
              style: const TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomPanel() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(child: _buildBottomStat(Icons.people_outline, '6 slots left')),
              const SizedBox(width: 6),
              Expanded(child: _buildBottomStat(Icons.toll, '30 credits')),
              const SizedBox(width: 6),
              Expanded(child: _buildBottomStat(Icons.timer_outlined, '90 minutes')),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoRow(Icons.location_on_outlined, widget.location),
          const SizedBox(height: 10),
          _buildInfoRow(Icons.calendar_today_outlined, '${widget.date} • ${widget.time} • Dubai Sports City'),
          const SizedBox(height: 30),
          
          if (_selectedSpotIndex != null)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_myReservedSpotIndex == _selectedSpotIndex) {
                    // Cancel
                    _myReservedSpotIndex = null;
                    _isReservedByMe = false;
                  } else {
                    // Reserve
                    _myReservedSpotIndex = _selectedSpotIndex;
                    _isReservedByMe = true;
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _myReservedSpotIndex == _selectedSpotIndex ? const Color(0xFF2D1616) : goldColor,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: _myReservedSpotIndex == _selectedSpotIndex ? const BorderSide(color: Colors.redAccent, width: 0.5) : BorderSide.none,
                ),
              ),
              child: Text(
                _myReservedSpotIndex == _selectedSpotIndex ? 'CANCEL RESERVATION' : 'RESERVE MY SPOT',
                style: TextStyle(
                  color: _myReservedSpotIndex == _selectedSpotIndex ? Colors.redAccent : Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomStat(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: greenAccent, size: 14),
          const SizedBox(width: 4),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white38, size: 16),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(color: Colors.white38, fontSize: 13)),
      ],
    );
  }
}
