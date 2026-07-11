import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);

class SocialLeaguesPage extends StatefulWidget {
  const SocialLeaguesPage({super.key});

  @override
  State<SocialLeaguesPage> createState() => _SocialLeaguesPageState();
}

class _SocialLeaguesPageState extends State<SocialLeaguesPage> {
  DateTime _selectedDate = DateTime.now();
  String _selectedFilter = 'ALL';
  final ScrollController _dateScrollController = ScrollController();

  final List<String> _cardImages = [
    'assets/images/img1.jpeg',
    'assets/images/img2.jpeg',
    'assets/images/img3.jpeg',
    'assets/images/img4.jpeg',
    'assets/images/img_1.png',
  ];

  @override
  void dispose() {
    _dateScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: darkBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('SOCIAL LEAGUES', 
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15, top: 10, bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: greenAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: greenAccent.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.bookmark_border, color: greenAccent, size: 14),
                const SizedBox(width: 5),
                const Text('BOOKINGS', style: TextStyle(color: greenAccent, fontSize: 10, fontWeight: FontWeight.w900)),
                const SizedBox(width: 5),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: greenAccent, shape: BoxShape.circle),
                  child: const Text('3', style: TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text('Pick a league, find a game, and play.', 
                style: TextStyle(color: Colors.white38, fontSize: 13, fontWeight: FontWeight.w500)),
            ),
            const SizedBox(height: 25),
            _buildPickADate(),
            _buildFilterSection(),
            _buildCategorySection('MIXED', [
              _buildLeagueCard('7-A-SIDE', '1 FIXTURE', _cardImages[0], '7\$'),
            ]),
            _buildCategorySection('MEN', [
              _buildLeagueCard('5-A-SIDE', '2 FIXTURES', _cardImages[1], '5\$'),
              _buildLeagueCard('11-A-SIDE', '0 FIXTURES', _cardImages[2], '11\$'),
            ]),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPickADate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('PICK A DATE', style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
        ),
        const SizedBox(height: 15),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 90,
              child: ListView.builder(
                controller: _dateScrollController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                itemCount: 14,
                itemBuilder: (context, index) {
                  DateTime date = DateTime.now().add(Duration(days: index));
                  bool isSelected = date.day == _selectedDate.day && date.month == _selectedDate.month;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedDate = date),
                    child: Container(
                      width: 75,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.transparent : surfaceColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: isSelected ? greenAccent : Colors.white10, width: 1.5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(index == 0 ? 'TODAY' : ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'][date.weekday - 1],
                            style: TextStyle(color: isSelected ? greenAccent : Colors.white24, fontSize: 10, fontWeight: FontWeight.w900)),
                          const SizedBox(height: 5),
                          Text(date.day.toString(),
                            style: TextStyle(color: isSelected ? Colors.white : Colors.white70, fontSize: 22, fontWeight: FontWeight.w900)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              left: 10,
              child: _buildArrowButton(Icons.arrow_back_ios_new_rounded, () {
                _dateScrollController.animateTo(_dateScrollController.offset - 100, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
              }, isGreen: true),
            ),
            Positioned(
              right: 10,
              child: _buildArrowButton(Icons.arrow_forward_ios_rounded, () {
                _dateScrollController.animateTo(_dateScrollController.offset + 100, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
              }, isGreen: true),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text('TODAY', style: TextStyle(color: greenAccent, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1)),
              const SizedBox(width: 8),
              const Icon(Icons.circle, size: 4, color: Colors.white24),
              const SizedBox(width: 8),
              const Text('APR 15', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              const Icon(Icons.circle, size: 4, color: Colors.white24),
              const SizedBox(width: 8),
              const Text('3 games', style: TextStyle(color: Colors.white38, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildArrowButton(IconData icon, VoidCallback onTap, {bool isGreen = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isGreen ? greenAccent : surfaceColor.withValues(alpha: 0.8),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 10)
          ]
        ),
        child: Icon(icon, color: isGreen ? Colors.black : Colors.white38, size: 16),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('FILTER BY', style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
        ),
        const SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              _buildFilterChip('ALL', Icons.grid_view_rounded),
              _buildFilterChip('VETS', Icons.workspace_premium_outlined),
              _buildFilterChip('MIXED', Icons.group_outlined),
              _buildFilterChip('MEN', Icons.male),
              _buildFilterChip('LADIES', Icons.female),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('2 leagues', style: TextStyle(color: Colors.white24, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, IconData icon) {
    bool isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? greenAccent : surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? greenAccent : Colors.white.withValues(alpha: 0.05)),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.black : Colors.white38, size: 16),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(color: isSelected ? Colors.black : Colors.white38, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
          child: Row(
            children: [
              Icon(title == 'MIXED' ? Icons.group_outlined : Icons.male, color: Colors.white24, size: 16),
              const SizedBox(width: 10),
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
              const SizedBox(width: 15),
              Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.05))),
            ],
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildLeagueCard(String type, String fixtures, String image, String price) {
    return Container(
      height: 180,
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withValues(alpha: 0.1), Colors.black.withValues(alpha: 0.7)],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.group_outlined, color: Colors.white70, size: 12),
                    const SizedBox(width: 5),
                    Text('MIXED', style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 9, fontWeight: FontWeight.w900)),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(price, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900)),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(type, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: 1)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: greenAccent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: greenAccent.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.calendar_today, color: greenAccent, size: 10),
                        const SizedBox(width: 5),
                        Text(fixtures, style: const TextStyle(color: greenAccent, fontSize: 9, fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.bottomRight,
              child: Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}
