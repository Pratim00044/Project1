import 'package:flutter/material.dart';
import 'pending_approval_page.dart';
import 'player_profiles_management.dart';
import 'league_tables_page.dart';
import 'cdl_teams_management.dart';
import 'cdl_fixture_maker.dart';
import 'social_leagues_page.dart';
import 'player_interests_page.dart';
import 'create_match_page.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color greenAccent = Color(0xFF2ECC71);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);
const Color cardLightColor = Color(0xFFC0C0C0);

class OrganizationHome extends StatefulWidget {
  const OrganizationHome({super.key});

  @override
  State<OrganizationHome> createState() => _OrganizationHomeState();
}

class _OrganizationHomeState extends State<OrganizationHome> {
  bool isApproved = true;
  DateTime _selectedDate = DateTime.parse('2024-06-10');
  String _selectedFilter = 'ALL';
  final ScrollController _dateScrollController = ScrollController();

  @override
  void dispose() {
    _dateScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isApproved) {
      return const PendingApprovalPage();
    }
    return Scaffold(
      backgroundColor: Colors.black,
      endDrawer: _buildDrawer(context),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: CustomScrollView(
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
                      child: Text('SYSTEM OVERVIEW',
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
                      child: _buildCreateMatchSection(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text('SOCIAL LEAGUES', 
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
                      _buildLeagueCard('7-A-SIDE', '1 FIXTURE', 'Zayed City', 'Jun 12', '69 AED', category: 'MIXED', colors: [const Color(0xFF007CFE), const Color(0xFF004A99)]),
                      _buildLeagueCard('6-A-SIDE', '2 FIXTURES', 'Dubai Sports', 'Jun 14', '55 AED', category: 'MIXED', colors: [const Color(0xFF6A11CB), const Color(0xFF2575FC)]),
                      _buildLeagueCard('4-A-SIDE', '3 FIXTURES', 'Al Barsha', 'Jun 15', '40 AED', category: 'MIXED', colors: [const Color(0xFF38EF7D), const Color(0xFF11998E)]),
                    ]),
                  ),
                  SliverToBoxAdapter(
                    child: _buildCategorySection('MEN', [
                      _buildLeagueCard('5-A-SIDE', '2 FIXTURES', 'Kite Beach', 'Jun 10', '45 AED', category: 'MEN', colors: [const Color(0xFFFFB75E), const Color(0xFFED8F03)]),
                      _buildLeagueCard('11-A-SIDE', '0 FIXTURES', 'Main Stadium', 'Jun 20', '99 AED', category: 'MEN', colors: [const Color(0xFFEE0979), const Color(0xFFF12711)]),
                      _buildLeagueCard('6-A-SIDE', '3 FIXTURES', 'JLT Pitch', 'Jun 18', '55 AED', category: 'MEN', colors: [const Color(0xFFF093FB), const Color(0xFFF5576C)]),
                      _buildLeagueCard('5-A-SIDE', '1 FIXTURE', 'Dubai Hills', 'Jun 13', '45 AED', category: 'MEN', colors: [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)]),
                    ]),
                  ),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                      child: Text('RECENT ALERTS', 
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1)),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: _buildNotificationItem('New booking request for 7-A-Side', 'Booking', 'Today', '02:30 PM', [const Color(0xFF007CFE), const Color(0xFF004A99)]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: _buildNotificationItem('League table updated for Mixed Div', 'League', 'Yesterday', '10:00 AM', [const Color(0xFF38EF7D), const Color(0xFF11998E)]),
                      ),
                    ]),
                  ),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                      child: Text('MANAGEMENT TOOLS', 
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1)),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverGrid.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.9,
                      children: [
                        _buildOrgCard(context, Icons.assignment_ind_rounded, 'PLAYER PROFILES', 'Manage Players', 'assets/images/Core FC Theme .jpeg', () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const PlayerProfilesManagement()));
                        }, colors: [const Color(0xFF007CFE), const Color(0xFF004A99)]),
                        _buildOrgCard(context, Icons.add_business_rounded, 'TEAMS & LOGOS', 'Add Teams & Branding', 'assets/images/login_background.jpeg', () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const CdlTeamsManagement()));
                        }, colors: [const Color(0xFFFFB75E), const Color(0xFFED8F03)]),
                        _buildOrgCard(context, Icons.event_available_rounded, 'FIXTURE MAKER', 'Generate Match Days', 'assets/images/Core FC Theme .jpeg', () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const CdlFixtureMaker()));
                        }, colors: [const Color(0xFF38EF7D), const Color(0xFF11998E)]),
                        _buildOrgCard(context, Icons.table_view_rounded, 'LEAGUE TABLES', 'Games Played & Scores', 'assets/images/login_background.jpeg', () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LeagueTablesPage()));
                        }, colors: [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)]),
                      ],
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 30)),
                  _buildFooter(),
                ],
              ),
            ),
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
                          Text('3', style: TextStyle(color: isSelected ? greenAccent : Colors.white10, fontSize: 10, fontWeight: FontWeight.bold)),
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
              }),
            ),
            Positioned(
              right: 10,
              child: _buildArrowButton(Icons.arrow_forward_ios_rounded, () {
                _dateScrollController.animateTo(_dateScrollController.offset + 100, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
              }, isGreen: true),
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

  Widget _buildLeagueCard(String type, String fixtures, String location, String date, String price, {required String category, List<Color>? colors}) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerInterestsPage(gameType: type))),
      child: Container(
        height: 140,
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors ?? [surfaceColor, const Color(0xFF1A1A1A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          boxShadow: [
            BoxShadow(
              color: (colors?.first ?? Colors.black).withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
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
                      color: Colors.black.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(category, 
                      style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(price, 
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900)),
                  ),
                ],
              ),
              const Spacer(),
              Text(type, 
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
              const SizedBox(height: 10),
              Row(
                children: [
                  _buildCardInfo(Icons.calendar_today_rounded, date),
                  const SizedBox(width: 15),
                  _buildCardInfo(Icons.location_on_rounded, location),
                  const SizedBox(width: 15),
                  _buildCardInfo(Icons.sports_soccer_rounded, fixtures),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardInfo(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white60, size: 12),
        const SizedBox(width: 5),
        Text(text, 
          style: const TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 3),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/sunil.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('AHMED AL-MANSOORI',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5)),
                    const SizedBox(height: 5),
                    const Text('SPECIAL ORGANIZATION FOOTBALL TEAMS',
                        style: TextStyle(
                            color: greenAccent,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1)),
                    const SizedBox(height: 5),
                    Text('FOOTLAB DXB',
                        style: TextStyle(
                            color: goldColor.withValues(alpha: 0.8),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5)),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.verified_user_rounded, color: greenAccent, size: 24),
            ],
          ),
          const SizedBox(height: 25),
          Divider(color: Colors.white.withValues(alpha: 0.1), height: 1),
          const SizedBox(height: 25),
          Row(
            children: [
              _buildSimpleStat('12', 'ACTIVE LEAGUES', color: Colors.white),
              const SizedBox(width: 35),
              _buildSimpleStat('452', 'PLAYERS', color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleStat(String val, String label, {Color color = Colors.white}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(val, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w900)),
        Text(label, style: TextStyle(color: color.withValues(alpha: 0.5), fontSize: 8, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildNotificationItem(String title, String category, String day, String time, List<Color> colors) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: colors.first.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                Text(category, style: const TextStyle(color: Colors.white70, fontSize: 11)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(day, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              Text(time, style: const TextStyle(color: Colors.white60, fontSize: 9)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCreateMatchSection() {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateMatchPage())),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: goldColor.withValues(alpha: 0.3)),
          gradient: const LinearGradient(
            colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.sports_soccer_rounded, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 20),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CREATE NEW MATCH', 
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1)),
                  SizedBox(height: 4),
                  Text('Schedule custom games & manage squads', 
                    style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
      child: Row(
        children: [
          Image.asset('assets/logo.png', height: 65, fit: BoxFit.contain),
          const SizedBox(width: 20),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CORE FC',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0)),
              Text('ORGANISER DASHBOARD',
                  style: TextStyle(
                      color: goldColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5)),
            ],
          ),
          const Spacer(),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: goldColor),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrgCard(BuildContext context, IconData icon, String title, String subtitle, String bgImage, VoidCallback onTap, {List<Color>? colors}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: colors != null ? null : surfaceColor,
          gradient: colors != null ? LinearGradient(colors: colors, begin: Alignment.topCenter, end: Alignment.bottomCenter) : null,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(height: 15),
              Text(title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      letterSpacing: 0.5),
                  textAlign: TextAlign.center),
              const SizedBox(height: 4),
              Text(subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70, fontSize: 9),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      );
  }

  Widget _buildFooter() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.8),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        ),
        child: Column(
          children: [
            Image.asset('assets/logo.png', height: 25, color: Colors.white10),
            const SizedBox(height: 15),
            Text('STATIXA ADMINISTRATION',
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.2),
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1)),
            const SizedBox(height: 5),
            Text('© 2024 STATIXA. ALL RIGHTS RESERVED.',
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.1),
                    fontSize: 8)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: darkBg,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
                    decoration: const BoxDecoration(color: Color(0xFF0D0D0D)),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xFF1A1A1A),
                          child: Icon(Icons.groups_outlined, size: 35, color: greenAccent),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('AHMED AL-MANSOORI',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              Text('Social Organiser | STATIXA',
                                  style: TextStyle(
                                      color: goldColor.withValues(alpha: 0.7),
                                      fontSize: 10)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
                    child: Text('MANAGEMENT',
                        style: TextStyle(
                            color: Colors.white24,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2)),
                  ),
                  _buildDrawerItem(Icons.explore_outlined, 'Social Leagues', () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SocialLeaguesPage()));
                  }),
                  _buildDrawerItem(Icons.sports_soccer_rounded, 'Create Match', () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateMatchPage()));
                  }),
                  _buildDrawerItem(Icons.assignment_ind_rounded, 'Player Profiles', () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PlayerProfilesManagement()));
                  }),
                  _buildDrawerItem(Icons.event_note_outlined, 'Season Schedule', () {}),
                  _buildDrawerItem(Icons.payments_outlined, 'League Fees', () {}),
                  _buildDrawerItem(Icons.verified_outlined, 'Club Affiliations', () {}),
                  _buildDrawerItem(Icons.settings_outlined, 'Organiser Settings', () {}),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
                    child: Text('SUPPORT',
                        style: TextStyle(
                            color: Colors.white24,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2)),
                  ),
                  _buildDrawerItem(Icons.help_outline_rounded, 'Help Center', () {}),
                  _buildDrawerItem(Icons.info_outline_rounded, 'About Statixa', () {}),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.white10, height: 1),
          _buildDrawerItem(Icons.logout_rounded, 'Logout', () {
            Navigator.pushReplacementNamed(context, '/login');
          }),
          _buildDrawerItem(Icons.delete_forever_rounded, 'Delete Account', () {
          }, isRed: true),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap,
      {bool isRed = false, bool isSelected = false, Color? accentColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListTile(
        dense: true,
        visualDensity: const VisualDensity(vertical: -2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Icon(icon,
            color: isSelected
                ? (accentColor ?? goldColor)
                : (isRed ? Colors.redAccent.withValues(alpha: 0.7) : Colors.white38),
            size: 20),
        title: Text(title,
            style: TextStyle(
                color: isSelected
                    ? (accentColor ?? goldColor)
                    : (isRed ? Colors.redAccent : Colors.white70),
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500)),
        onTap: onTap,
        selected: isSelected,
        selectedTileColor: (accentColor ?? goldColor).withValues(alpha: 0.05),
      ),
    );
  }
}
