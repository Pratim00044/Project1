import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);

class SocialGamesManagerPage extends StatefulWidget {
  const SocialGamesManagerPage({super.key});

  @override
  State<SocialGamesManagerPage> createState() => _SocialGamesManagerPageState();
}

class _SocialGamesManagerPageState extends State<SocialGamesManagerPage> {
  final List<String> _venues = ['Town Square', 'Sports City', 'Jumeirah', 'Al Barsha'];
  String? _selectedVenue;
  double _charge = 40.0;
  String _gameType = '7-A-SIDE';
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader(context)),
          SliverToBoxAdapter(child: _buildCalendarHeader()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('SOCIAL GAMES MANAGER',
                      style: TextStyle(color: greenAccent, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
                  const SizedBox(height: 25),
                  const Text('CREATE NEW SOCIAL GAME', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  const SizedBox(height: 25),
                  _buildLabel('SELECT VENUE'),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(color: surfaceColor, borderRadius: BorderRadius.circular(15)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedVenue,
                        hint: const Text('Select Location', style: TextStyle(color: Colors.white24, fontSize: 14)),
                        dropdownColor: surfaceColor,
                        isExpanded: true,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        items: _venues.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                        onChanged: (v) => setState(() => _selectedVenue = v),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  _buildLabel('GAME TYPE'),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: ['5-A-SIDE', '7-A-SIDE', '8-A-SIDE', '9-A-SIDE', '11-A-SIDE'].map((type) {
                      bool isSelected = _gameType == type;
                      return GestureDetector(
                        onTap: () => setState(() => _gameType = type),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? greenAccent : surfaceColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: isSelected ? greenAccent : Colors.white.withOpacity(0.05)),
                          ),
                          child: Text(type, style: TextStyle(color: isSelected ? Colors.black : Colors.white70, fontSize: 11, fontWeight: FontWeight.w900)),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildLabel('MATCH FEE (AED)'),
                      Text('${_charge.toInt()} AED', style: const TextStyle(color: greenAccent, fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  Slider(
                    value: _charge,
                    min: 40,
                    max: 69,
                    divisions: 29,
                    activeColor: greenAccent,
                    inactiveColor: Colors.white10,
                    onChanged: (v) => setState(() => _charge = v),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('40 AED', style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold)),
                      Text('69 AED', style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 45),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Social Game Added to Platform!'), backgroundColor: greenAccent));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greenAccent,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 0,
                    ),
                    child: const Text('PUBLISH SOCIAL GAME', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, letterSpacing: 1)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: 14,
        itemBuilder: (context, index) {
          DateTime date = DateTime.now().add(Duration(days: index));
          bool isSelected = date.day == _selectedDate.day && date.month == _selectedDate.month;
          return GestureDetector(
            onTap: () => setState(() => _selectedDate = date),
            child: Container(
              width: 70,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: isSelected ? greenAccent.withOpacity(0.1) : surfaceColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: isSelected ? greenAccent : Colors.white10, width: 1.5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'][date.weekday - 1],
                      style: TextStyle(color: isSelected ? greenAccent : Colors.white38, fontSize: 9, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 5),
                  Text(date.day.toString(),
                      style: TextStyle(color: isSelected ? Colors.white : Colors.white70, fontSize: 20, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1));
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 10),
          Image.asset('assets/logo.png', height: 35, fit: BoxFit.contain),
          const SizedBox(width: 10),
          const Text('STATIXA',
              style: TextStyle(
                  color: Color(0xFFC0C0C0),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5)),
        ],
      ),
    );
  }
}
