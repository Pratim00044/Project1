import 'package:flutter/material.dart';
import 'organization_home.dart';
import 'create_match_page.dart';
import 'organiser_attendance_view.dart';
import 'player_progress_dashboard.dart';
import 'org_footer.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color greenAccent = Color(0xFF2ECC71);
const Color surfaceColor = Color(0xFF121212);

class OrganisationDashboard extends StatefulWidget {
  const OrganisationDashboard({super.key});

  @override
  State<OrganisationDashboard> createState() => _OrganisationDashboardState();
}

class _OrganisationDashboardState extends State<OrganisationDashboard> {
  DateTime _selectedDate = DateTime.parse('2024-06-10');
  String _selectedFilter = 'ALL';
  final ScrollController _dateScrollController = ScrollController();

  final List<List<Color>> tileColors = [
    [const Color(0xFF2E5B4F), const Color(0xFF3B2A50)],
    [const Color(0xFF1E3A8A), const Color(0xFF312E81)],
    [const Color(0xFF064E3B), const Color(0xFF14532D)],
    [const Color(0xFF334155), const Color(0xFF1E293B)],
    [const Color(0xFF4C1D95), const Color(0xFF2E1065)],
    [const Color(0xFF831843), const Color(0xFF701A75)],
  ];

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
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: _buildHeroCard(),
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
            child: Text('OVERVIEW',
                style: TextStyle(
                    color: goldColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2)),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(child: _buildCreateMatchSection(context)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildProgressSection(context)),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text('UPCOMING GAMES', 
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 1)),
                ),
                _buildBookingsBadge(),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: _buildPickADate()),
        SliverToBoxAdapter(child: _buildFilterSection()),
        SliverToBoxAdapter(
          child: _buildCategorySection('MIXED', [
            _buildLeagueCard(context, 'Midweek Turbo 5s', 'Wed, Apr 15 • 11:00 PM', 'Business Bay Courts', 'Jun 12', '55 AED', category: 'OPEN', bgImage: _cardImages[0], reserved: 6, total: 10, gradient: tileColors[1]),
            _buildLeagueCard(context, 'Thursday Social 7s', 'Thu, Apr 16 • 11:30 PM', 'Dubai Sports City', 'Jun 14', '75 AED', category: 'OPEN', bgImage: _cardImages[1], reserved: 8, total: 14, gradient: tileColors[0]),
            _buildLeagueCard(context, 'Friday Night Lights 7s', 'Sat, Apr 18 • 10:00 PM', 'JBR Arena', 'Jun 15', '75 AED', category: 'OPEN', bgImage: _cardImages[2], reserved: 6, total: 14, gradient: tileColors[5]),
          ]),
        ),
        SliverToBoxAdapter(
          child: _buildCategorySection('MEN', [
            _buildLeagueCard(context, '5-A-SIDE', '2 FIXTURES', 'Kite Beach', 'Jun 10', '45 AED', category: 'MEN', bgImage: _cardImages[3], gradient: tileColors[1]),
            _buildLeagueCard(context, '11-A-SIDE', '0 FIXTURES', 'Main Stadium', 'Jun 20', '99 AED', category: 'MEN', bgImage: _cardImages[4], gradient: tileColors[4]),
            _buildLeagueCard(context, '6-A-SIDE', '3 FIXTURES', 'JLT Pitch', 'Jun 18', '55 AED', category: 'MEN', bgImage: _cardImages[0], gradient: tileColors[2]),
            _buildLeagueCard(context, '5-A-SIDE', '1 FIXTURE', 'Dubai Hills', 'Jun 13', '45 AED', category: 'MEN', bgImage: _cardImages[1], gradient: tileColors[3]),
          ]),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 50)),
      ],
    );
  }

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF1A1A1A), const Color(0xFF0D0D0D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: goldColor.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 90,
            height: 90,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: goldColor.withValues(alpha: 0.1),
              border: Border.all(color: goldColor.withValues(alpha: 0.5), width: 2.5),
            ),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/sunil.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('AHMED AL-MANSOORI',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5)),
              const SizedBox(width: 8),
              Icon(Icons.verified_user_rounded, color: goldColor, size: 18),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PlayerProgressDashboard())),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: tileColors[0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(color: tileColors[0][0].withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 8))
          ],
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.auto_graph_rounded, color: Colors.white, size: 28),
            SizedBox(height: 15),
            Text('PLAYER PROGRESS', 
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1)),
            SizedBox(height: 4),
            Text('Track trends & skills', 
              style: TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateMatchSection(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateMatchPage())),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: tileColors[4],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(color: tileColors[4][0].withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 8))
          ],
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.sports_soccer_rounded, color: Colors.white, size: 28),
            SizedBox(height: 15),
            Text('CREATE MATCH', 
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1)),
            SizedBox(height: 4),
            Text('Schedule games', 
              style: TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingsBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: goldColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: goldColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.bookmark_border, color: goldColor, size: 14),
          const SizedBox(width: 5),
          const Text('BOOKINGS', style: TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.w900)),
          const SizedBox(width: 5),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(color: goldColor, shape: BoxShape.circle),
            child: const Text('3', style: TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildPickADate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
          child: Text('PICK A DATE', style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 110,
              child: ListView.builder(
                controller: _dateScrollController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                itemCount: 30,
                itemBuilder: (context, index) {
                  DateTime date = DateTime.parse('2024-06-10').add(Duration(days: index));
                  bool isSelected = date.day == _selectedDate.day && date.month == _selectedDate.month;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedDate = date),
                    child: Container(
                      width: 85,
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        color: surfaceColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isSelected ? greenAccent : Colors.white10, width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(index == 0 ? 'TODAY' : ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'][date.weekday - 1],
                            style: TextStyle(color: isSelected ? greenAccent : Colors.white24, fontSize: 10, fontWeight: FontWeight.w900)),
                          const SizedBox(height: 8),
                          Text(date.day.toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                          const SizedBox(height: 4),
                          Text(['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'][date.month - 1],
                            style: TextStyle(color: isSelected ? greenAccent : Colors.white24, fontSize: 10, fontWeight: FontWeight.w900)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              left: 10,
              child: GestureDetector(
                onTap: () {
                  _dateScrollController.animateTo(
                    (_dateScrollController.offset - 101).clamp(0, _dateScrollController.position.maxScrollExtent),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(color: greenAccent, shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 16),
                ),
              ),
            ),
            Positioned(
              right: 10,
              child: GestureDetector(
                onTap: () {
                  _dateScrollController.animateTo(
                    (_dateScrollController.offset + 101).clamp(0, _dateScrollController.position.maxScrollExtent),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(color: greenAccent, shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black, size: 16),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: Row(
            children: [
              const Text('TODAY', style: TextStyle(color: greenAccent, fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1)),
              const SizedBox(width: 8),
              const Icon(Icons.circle, size: 4, color: Colors.white24),
              const SizedBox(width: 8),
              const Text('JULY 10', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              const Icon(Icons.circle, size: 4, color: Colors.white24),
              const SizedBox(width: 8),
              const Text('3 games', style: TextStyle(color: Colors.white38, fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 15),
          child: Text('FILTER BY', style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
        ),
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
          color: isSelected ? goldColor : surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? goldColor : Colors.white.withValues(alpha: 0.05)),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.black : Colors.white38, size: 16),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(color: isSelected ? Colors.black : Colors.white38, fontSize: 11, fontWeight: FontWeight.w900)),
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

  Widget _buildLeagueCard(BuildContext context, String type, String time, String location, String date, String price, {required String category, required String bgImage, int reserved = 0, int total = 10, List<Color>? gradient}) {
    int slotsLeft = total - reserved;
    double progress = (reserved / total).clamp(0.0, 1.0);
    final List<Color> cardGradient = gradient ?? tileColors[1];

    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OrganiserAttendanceView(
        title: type,
        date: 'Thu Apr 16',
        time: '11:30 PM',
        location: location,
      ))),
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: cardGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(color: cardGradient[0].withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 5)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(category, 
                      style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(price.replaceAll(' AED', 'S'), 
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900)),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(type, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.white70, size: 12),
                  const SizedBox(width: 5),
                  Text(time, style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w600)),
                  const SizedBox(width: 10),
                  const Icon(Icons.location_on_rounded, color: Colors.white70, size: 12),
                  const SizedBox(width: 5),
                  Expanded(child: Text(location, style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.people_alt_rounded, color: Colors.white, size: 14),
                  const SizedBox(width: 5),
                  Text('$reserved reserved', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  const Icon(Icons.check_circle_outline_rounded, color: Colors.white70, size: 14),
                  const SizedBox(width: 5),
                  Text('$slotsLeft slots left', style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 10),
              Stack(
                children: [
                  Container(
                    height: 4,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)),
                  ),
                  FractionallySizedBox(
                    widthFactor: progress,
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(2)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
