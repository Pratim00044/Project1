import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class ManagerCreateMatchPage extends StatefulWidget {
  const ManagerCreateMatchPage({super.key});

  @override
  State<ManagerCreateMatchPage> createState() => _ManagerCreateMatchPageState();
}

class _ManagerCreateMatchPageState extends State<ManagerCreateMatchPage> {
  String _selectedMatchType = 'LEAGUE';
  String _selectedCategory = 'MEN';
  String _selectedSquadLimit = '11';
  String? _selectedYourTeam = 'CORE FC';
  String? _selectedOpponent;
  String? _selectedVenue;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final List<String> _categories = ['MEN', 'LADIES', 'MIXED', 'VETS'];
  final List<String> _myTeams = ['CORE FC', 'DUBAI LIONS', 'NATIONAL GULF FC'];
  final List<String> _opponents = ['Turan Dubai FC', 'National Paints FC', 'Street League FC', 'Eagle FC', 'United FC'];
  final List<String> _squadLimits = ['5', '7', '8', '11', '15', '20', '25'];
  final List<String> _venues = ['Wembley Stadium', 'Maracanã', 'Camp Nou', 'San Siro', 'Old Trafford', 'Allianz Arena', 'Bernabéu'];
  
  final List<Map<String, dynamic>> _players = [
    {'name': 'Lionel Messi', 'selected': false},
    {'name': 'Cristiano Ronaldo', 'selected': false},
    {'name': 'Kylian Mbappé', 'selected': false},
    {'name': 'Erling Haaland', 'selected': false},
    {'name': 'Kevin De Bruyne', 'selected': false},
    {'name': 'Neymar Jr', 'selected': false},
    {'name': 'Freddie Mercury', 'selected': false},
    {'name': 'David Bowie', 'selected': false},
    {'name': 'Mick Jagger', 'selected': false},
    {'name': 'John Lennon', 'selected': false},
  ];

  int get _selectedCount => _players.where((p) => p['selected'] == true).length;

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: goldColor,
              onPrimary: Colors.black,
              surface: surfaceColor,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: goldColor,
              onPrimary: Colors.black,
              surface: surfaceColor,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'CREATE NEW MATCH',
          style: TextStyle(
            color: goldColor,
            fontWeight: FontWeight.w900,
            fontSize: 18,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionLabel('CATEGORY'),
            const SizedBox(height: 15),
            Row(
              children: _categories.map((cat) => _buildChoiceChip(cat, _selectedCategory == cat, () => setState(() => _selectedCategory = cat))).toList(),
            ),

            const SizedBox(height: 25),
            _buildSectionLabel('TEAMS'),
            const SizedBox(height: 10),
            _buildCustomDropdown('YOUR TEAM', _selectedYourTeam ?? 'Select Team', _myTeams, (val) => setState(() => _selectedYourTeam = val)),
            const SizedBox(height: 15),
            _buildCustomDropdown('SELECT OPPONENT', _selectedOpponent ?? 'Select Opponent', _opponents, (val) => setState(() => _selectedOpponent = val)),
            
            const SizedBox(height: 25),
            _buildSectionLabel('MATCH TYPE'),
            const SizedBox(height: 15),
            Row(
              children: [
                _buildChoiceChip('LEAGUE', _selectedMatchType == 'LEAGUE', () => setState(() => _selectedMatchType = 'LEAGUE')),
                _buildChoiceChip('FRIENDLY', _selectedMatchType == 'FRIENDLY', () => setState(() => _selectedMatchType = 'FRIENDLY')),
                _buildChoiceChip('CUP', _selectedMatchType == 'CUP', () => setState(() => _selectedMatchType = 'CUP')),
              ],
            ),

            const SizedBox(height: 25),
            _buildSectionLabel('LOCATION'),
            const SizedBox(height: 10),
            _buildVenueDropdown(),

            const SizedBox(height: 25),
            _buildSectionLabel('DATE & TIME'),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _pickDate,
                    child: _buildDateTimeBox(
                      'DATE', 
                      _selectedDate == null ? 'Select Date' : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}', 
                      Icons.calendar_today_outlined
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: GestureDetector(
                    onTap: _pickTime,
                    child: _buildDateTimeBox(
                      'TIME', 
                      _selectedTime == null ? 'Select Time' : _selectedTime!.format(context), 
                      Icons.access_time_outlined
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),
            _buildSectionLabel('SQUAD MANAGEMENT'),
            const SizedBox(height: 5),
            Text(
              'SQUAD LIMIT ($_selectedSquadLimit / 25)',
              style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildSquadLimitDropdown(),
            
            const SizedBox(height: 15),
            _buildSelectedPlayersBar(),

            const SizedBox(height: 25),
            _buildSectionLabel('SELECT FROM YOUR SQUAD'),
            const SizedBox(height: 15),
            _buildPlayerList(),

            const SizedBox(height: 25),
            _buildSectionLabel('SEARCH EXTRA PLAYERS'),
            const SizedBox(height: 10),
            _buildSearchField(),

            const SizedBox(height: 25),
            _buildSectionLabel('INVITE BY USER ID'),
            const SizedBox(height: 10),
            _buildInviteField(),

            const SizedBox(height: 40),
            _buildScheduleButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white38,
        fontSize: 11,
        fontWeight: FontWeight.w900,
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildChoiceChip(String label, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            gradient: isSelected ? const LinearGradient(colors: [goldColor, Color(0xFFB8860B)]) : null,
            color: isSelected ? null : surfaceColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? Colors.transparent : Colors.white.withOpacity(0.05)),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white38,
                fontSize: 9,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomDropdown(String label, String value, List<String> options, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 8),
          child: Text(
            label,
            style: const TextStyle(color: Colors.white24, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [surfaceColor, const Color(0xFF1A1A1A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: options.contains(value) ? value : null,
              hint: Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              dropdownColor: surfaceColor,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, color: goldColor),
              items: options.map((String val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                );
              }).toList(),
              onChanged: (newValue) => onChanged(newValue!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVenueDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [surfaceColor, const Color(0xFF1A1A1A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedVenue,
          hint: const Text('Select Venue / Stadium', style: TextStyle(color: Colors.white24, fontSize: 14)),
          dropdownColor: surfaceColor,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: goldColor),
          items: _venues.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _selectedVenue = newValue;
            });
          },
        ),
      ),
    );
  }

  Widget _buildDateTimeBox(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 8),
          child: Text(
            label,
            style: const TextStyle(color: Colors.white24, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [surfaceColor, const Color(0xFF1A1A1A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Row(
            children: [
              Icon(icon, color: goldColor, size: 18),
              const SizedBox(width: 12),
              Text(
                value,
                style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSquadLimitDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 8),
          child: Text(
            'SELECT SQUAD LIMIT',
            style: TextStyle(color: Colors.white24, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [surfaceColor, const Color(0xFF1A1A1A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedSquadLimit,
              dropdownColor: surfaceColor,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, color: goldColor),
              style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
              items: _squadLimits.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text('$value PLAYERS', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedSquadLimit = newValue!;
                  if (_selectedCount > int.parse(_selectedSquadLimit)) {
                    for (var p in _players) {
                      p['selected'] = false;
                    }
                  }
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedPlayersBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0D47A1), Color(0xFF002171)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'SELECTED PLAYERS',
            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
          Text(
            '$_selectedCount/$_selectedSquadLimit',
            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerList() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1B222E), Color(0xFF0D121A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: _players.length,
          separatorBuilder: (context, index) => Divider(color: Colors.white.withValues(alpha: 0.05), height: 1),
          itemBuilder: (context, index) {
            final player = _players[index];
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              title: Text(
                player['name'],
                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
              ),
              trailing: GestureDetector(
                onTap: () {
                  setState(() {
                    if (!player['selected'] && _selectedCount >= int.parse(_selectedSquadLimit)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Squad limit reached!'), backgroundColor: Colors.redAccent),
                      );
                      return;
                    }
                    player['selected'] = !player['selected'];
                  });
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: player['selected'] ? goldColor : Colors.white24, width: 2),
                    color: player['selected'] ? goldColor : Colors.transparent,
                  ),
                  child: player['selected'] 
                    ? const Icon(Icons.check, color: Colors.black, size: 16)
                    : null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [surfaceColor, const Color(0xFF1A1A1A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: const TextField(
        style: TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Search player name...',
          hintStyle: TextStyle(color: Colors.white24, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: goldColor, size: 22),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildInviteField() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [surfaceColor, const Color(0xFF1A1A1A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: const TextField(
              style: TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Enter User ID...',
                hintStyle: TextStyle(color: Colors.white24, fontSize: 14),
                prefixIcon: Icon(Icons.person_add_alt_1_outlined, color: goldColor, size: 22),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
          decoration: BoxDecoration(
            color: goldColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: goldColor.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))
            ],
          ),
          child: const Text(
            'INVITE',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 0.5),
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: goldColor.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Match Scheduled Successfully!'), backgroundColor: Colors.green),
          );
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: goldColor,
          foregroundColor: Colors.black,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0,
        ),
        child: const Text(
          'SCHEDULE MATCH',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
