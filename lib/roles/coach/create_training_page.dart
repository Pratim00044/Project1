import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);

class CreateTrainingPage extends StatefulWidget {
  const CreateTrainingPage({super.key});

  @override
  State<CreateTrainingPage> createState() => _CreateTrainingPageState();
}

class _CreateTrainingPageState extends State<CreateTrainingPage> {
  String _inviteType = 'PLAYER';
  String _sessionType = 'ACADEMY SESSION';
  String _selectedAgeGroup = 'Under 8s';
  String _selectedLocation = 'Town Square - Una Pitch';
  
  dynamic _logoImage;
  
  final List<String> _ageGroups = ['Under 8s', 'Under 10s', 'Under 12s', 'Under 14s', 'Under 16s'];
  final List<String> _locations = ['Town Square - Una Pitch', 'Dubai Sports City', 'Jumeirah', 'Al Barsha'];
  
  final List<String> _selectedPlayers = [];
  final List<String> _selectedTeams = [];
  final TextEditingController _sessionNameController = TextEditingController();

  final List<String> _myPlayers = [
    'Gurpreet Singh Sandhu', 'Amrinder Singh', 'Sandesh Jhingan', 
    'Pritam Kotal', 'Subhasish Bose', 'Sahal Abdul Samad', 
    'Anirudh Thapa', 'Brandon Fernandes', 'Sunil Chhetri', 'L. Chhangte'
  ];

  final List<String> _availableTeams = [
    'UNDER 8s', 'UNDER 10s', 'City Football', 'Dubai City Football Club',
    'United Football Club', 'Eagle FC', 'AFC'
  ];

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: const Color(0xFF0D0D0D),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: goldColor),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.9)],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: _pickLogo,
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: goldColor.withOpacity(0.5), width: 2),
                                boxShadow: [BoxShadow(color: goldColor.withOpacity(0.1), blurRadius: 20)],
                              ),
                              child: CircleAvatar(
                              radius: 45,
                              backgroundColor: const Color(0xFF1A1A1A),
                              backgroundImage: const AssetImage('assets/logo.png'),
                            ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(color: goldColor, shape: BoxShape.circle),
                                child: const Icon(Icons.camera_alt, color: Colors.black, size: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('NEW SESSION', 
                        style: TextStyle(color: goldColor, fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 2)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('SESSION TYPE'),
                  const SizedBox(height: 15),
                  _buildDropdown('Type', _sessionType, ['ACADEMY SESSION', 'BESPOKE COACHING', 'FRIENDLY GAME', 'TRAINING MATCH'], (v) => setState(() => _sessionType = v!)),
                  const SizedBox(height: 25),
                  _buildSectionTitle('BASIC INFO'),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _sessionNameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Session Name (e.g. Tactical Drills)',
                      hintStyle: const TextStyle(color: Colors.white24),
                      filled: true,
                      fillColor: const Color(0xFF121212),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                      prefixIcon: const Icon(Icons.edit, color: goldColor, size: 18),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(child: _buildDropdown('Age Group', _selectedAgeGroup, _ageGroups, (v) => setState(() => _selectedAgeGroup = v!))),
                      const SizedBox(width: 15),
                      Expanded(child: _buildDropdown('Location', _selectedLocation, _locations, (v) => setState(() => _selectedLocation = v!))),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(child: _buildDateTimePicker('DATE', _selectedDate == null ? 'Select Date' : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}', Icons.calendar_today, _pickDate)),
                      const SizedBox(width: 15),
                      Expanded(child: _buildDateTimePicker('TIME', _selectedTime == null ? 'Select Time' : _selectedTime!.format(context), Icons.access_time, _pickTime)),
                    ],
                  ),
                  const SizedBox(height: 35),
                  _buildSectionTitle('INVITATION METHOD'),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(child: _buildInviteTypeCard('PLAYER', 'Individual Players', Icons.person)),
                      const SizedBox(width: 15),
                      Expanded(child: _buildInviteTypeCard('TEAM', 'Full Teams', Icons.groups)),
                    ],
                  ),
                  const SizedBox(height: 35),
                  _inviteType == 'PLAYER' ? _buildPlayerSelection() : _buildTeamSelection(),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Training session scheduled successfully!')));
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: goldColor,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 10,
                      shadowColor: goldColor.withOpacity(0.3),
                    ),
                    child: const Text('SCHEDULE SESSION', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5));
  }

  Widget _buildInviteTypeCard(String type, String label, IconData icon) {
    bool isSelected = _inviteType == type;
    return GestureDetector(
      onTap: () => setState(() => _inviteType = type),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25),
        decoration: BoxDecoration(
          color: isSelected ? goldColor.withOpacity(0.1) : const Color(0xFF121212),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: isSelected ? goldColor : Colors.white.withOpacity(0.05)),
          boxShadow: isSelected ? [BoxShadow(color: goldColor.withOpacity(0.05), blurRadius: 10)] : null,
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? goldColor : Colors.white24, size: 32),
            const SizedBox(height: 12),
            Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.white24, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('SELECT PLAYERS (${_selectedPlayers.length})', style: const TextStyle(color: Colors.white60, fontSize: 11, fontWeight: FontWeight.bold)),
            if (_selectedPlayers.isNotEmpty)
              TextButton(onPressed: () => setState(() => _selectedPlayers.clear()), child: const Text('CLEAR ALL', style: TextStyle(color: Colors.redAccent, fontSize: 10))),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(color: const Color(0xFF121212), borderRadius: BorderRadius.circular(24)),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _myPlayers.length,
            separatorBuilder: (context, index) => Divider(color: Colors.white.withOpacity(0.02), height: 1),
            itemBuilder: (context, index) {
              final player = _myPlayers[index];
              final isSelected = _selectedPlayers.contains(player);
              return ListTile(
                leading: CircleAvatar(radius: 18, backgroundColor: const Color(0xFF1A1A1A), child: Text(player[0], style: const TextStyle(color: goldColor, fontSize: 12, fontWeight: FontWeight.bold))),
                title: Text(player, style: const TextStyle(color: Colors.white, fontSize: 14)),
                trailing: Icon(isSelected ? Icons.check_circle : Icons.add_circle_outline, color: isSelected ? goldColor : Colors.white10),
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedPlayers.remove(player);
                    } else {
                      _selectedPlayers.add(player);
                    }
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTeamSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('SELECT TEAMS (${_selectedTeams.length})', style: const TextStyle(color: Colors.white60, fontSize: 11, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _availableTeams.map((team) {
            bool isSelected = _selectedTeams.contains(team);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedTeams.remove(team);
                  } else {
                    _selectedTeams.add(team);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? goldColor : const Color(0xFF121212),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: isSelected ? goldColor : Colors.white10),
                ),
                child: Text(team, style: TextStyle(color: isSelected ? Colors.black : Colors.white70, fontSize: 13, fontWeight: FontWeight.bold)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Future<void> _pickLogo() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logo Upload feature - Open Gallery/Camera'),
        backgroundColor: goldColor,
      ),
    );
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) => Theme(data: ThemeData.dark().copyWith(colorScheme: const ColorScheme.dark(primary: goldColor)), child: child!),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => Theme(data: ThemeData.dark().copyWith(colorScheme: const ColorScheme.dark(primary: goldColor)), child: child!),
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  Widget _buildDateTimePicker(String label, String value, IconData icon, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(color: const Color(0xFF121212), borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Icon(icon, color: goldColor, size: 18),
                const SizedBox(width: 12),
                Expanded(child: Text(value, style: const TextStyle(color: Colors.white, fontSize: 13), overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: const Color(0xFF121212), borderRadius: BorderRadius.circular(15)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              dropdownColor: const Color(0xFF1A1A1A),
              style: const TextStyle(color: Colors.white, fontSize: 13),
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
