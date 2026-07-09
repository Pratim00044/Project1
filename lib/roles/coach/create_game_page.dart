import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);
const Color darkBg = Color(0xFF080808);

class CreateGamePage extends StatefulWidget {
  const CreateGamePage({super.key});

  @override
  State<CreateGamePage> createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {
  final _formKey = GlobalKey<FormState>();
  String _matchType = 'LEAGUE';
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  
  String? _selectedTeam = 'CORE FC';
  String? _selectedOpponent;
  int _playerLimit = 11;
  final List<String> _invitedPlayers = [];
  final List<String> _mySquadPlayers = [
    'Sunil Chhetri', 'Gurpreet Singh', 'Sandesh Jhingan', 'Ashique K', 
    'Sahal Abdul', 'Anirudh Thapa', 'Pritam Kotal', 'Subhasish Bose',
    'L. Chhangte', 'Apuia Ralte', 'Naorem Mahesh'
  ];
  final List<String> _allSearchablePlayers = ['Liston Colaco', 'Manvir Singh', 'Vishal Kaith', 'Hugo Boumous'];
  final TextEditingController _inviteIdController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('CREATE NEW MATCH', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 2)),
        foregroundColor: goldColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('TEAMS'),
              const SizedBox(height: 15),
              _buildBeautifulDropdown('YOUR TEAM', ['CORE FC', 'Bengal Warriors', 'Goa Giants'], _selectedTeam, (v) => setState(() => _selectedTeam = v)),
              const SizedBox(height: 15),
              _buildBeautifulDropdown('SELECT OPPONENT', ['Mohun Bagan', 'East Bengal', 'Mumbai City'], _selectedOpponent, (v) => setState(() => _selectedOpponent = v)),
              
              const SizedBox(height: 25),
              _buildSectionTitle('MATCH TYPE'),
              const SizedBox(height: 15),
              Row(
                children: [
                  _buildTypeChip('LEAGUE'),
                  const SizedBox(width: 10),
                  _buildTypeChip('FRIENDLY'),
                  const SizedBox(width: 10),
                  _buildTypeChip('CUP'),
                ],
              ),
              
              const SizedBox(height: 25),
              _buildSectionTitle('LOCATION'),
              const SizedBox(height: 15),
              _buildModernTextField('Venue / Stadium', Icons.location_on_outlined, _venueController),
              
              const SizedBox(height: 25),
              _buildSectionTitle('DATE & TIME'),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: _buildPickerTile(
                      'DATE',
                      _selectedDate == null ? 'Select Date' : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                      Icons.calendar_today_rounded,
                      _pickDate
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildPickerTile(
                      'TIME',
                      _selectedTime == null ? 'Select Time' : _selectedTime!.format(context),
                      Icons.access_time_rounded,
                      _pickTime
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),
              _buildSectionTitle('SQUAD MANAGEMENT'),
              const SizedBox(height: 15),
              _buildBeautifulDropdown('SQUAD LIMIT (11-25)', 
                  List.generate(15, (index) => (index + 11).toString()), 
                  _playerLimit.toString(), (v) => setState(() => _playerLimit = int.parse(v!))),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: surfaceColor, borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('SELECTED PLAYERS', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
                    Text('${_invitedPlayers.length}/$_playerLimit', style: const TextStyle(color: goldColor, fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Text('SELECT FROM YOUR SQUAD', style: TextStyle(color: Colors.white60, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
              const SizedBox(height: 10),
              Container(
                height: 180,
                decoration: BoxDecoration(color: surfaceColor, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withValues(alpha: 0.05))),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ListView.builder(
                    itemCount: _mySquadPlayers.length,
                    itemBuilder: (context, index) {
                      final p = _mySquadPlayers[index];
                      final isSelected = _invitedPlayers.contains(p);
                      return CheckboxListTile(
                        title: Text(p, style: const TextStyle(color: Colors.white, fontSize: 13)),
                        value: isSelected,
                        activeColor: goldColor,
                        checkColor: Colors.black,
                        dense: true,
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true && _invitedPlayers.length < _playerLimit) {
                              _invitedPlayers.add(p);
                            } else if (value == false) {
                              _invitedPlayers.remove(p);
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),
              const Text('SEARCH EXTRA PLAYERS', style: TextStyle(color: Colors.white60, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
              const SizedBox(height: 10),
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '' || _invitedPlayers.length >= _playerLimit) return const Iterable<String>.empty();
                  return _allSearchablePlayers.where((String option) => option.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                },
                onSelected: (String selection) {
                  if (!_invitedPlayers.contains(selection)) setState(() => _invitedPlayers.add(selection));
                },
                fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                  return TextField(
                    controller: controller, focusNode: focusNode,
                    enabled: _invitedPlayers.length < _playerLimit,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Search player name...',
                      hintStyle: const TextStyle(color: Colors.white24, fontSize: 13),
                      prefixIcon: const Icon(Icons.search, color: goldColor, size: 20),
                      filled: true, fillColor: surfaceColor,
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: goldColor, width: 1)),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),
              const Text('INVITE BY USER ID', style: TextStyle(color: Colors.white60, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildModernTextField('Enter User ID...', Icons.person_add_alt_1_outlined, _inviteIdController),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (_inviteIdController.text.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invite sent to ${_inviteIdController.text}')));
                        _inviteIdController.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: goldColor, 
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: const Text('INVITE', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),

              if (_invitedPlayers.isNotEmpty) ...[
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _invitedPlayers.map((p) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: goldColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10), border: Border.all(color: goldColor.withValues(alpha: 0.3))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(p, style: const TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 6),
                        GestureDetector(onTap: () => setState(() => _invitedPlayers.remove(p)), child: const Icon(Icons.close, size: 14, color: goldColor)),
                      ],
                    ),
                  )).toList(),
                ),
              ],

              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Match Scheduled Successfully! Notification sent to players.'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: goldColor,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 0,
                ),
                child: const Text('SCHEDULE MATCH', 
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title,
        style: const TextStyle(
            color: Colors.white24,
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 2));
  }

  Widget _buildModernTextField(String hint, IconData icon, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white24, fontSize: 13),
          prefixIcon: Icon(icon, color: goldColor.withValues(alpha: 0.5), size: 18),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  Widget _buildTypeChip(String type) {
    bool isSelected = _matchType == type;
    return GestureDetector(
      onTap: () => setState(() => _matchType = type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? goldColor.withValues(alpha: 0.1) : surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? goldColor : Colors.white.withValues(alpha: 0.05)),
        ),
        child: Text(type,
            style: TextStyle(
                color: isSelected ? goldColor : Colors.white38,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1)),
      ),
    );
  }

  Widget _buildPickerTile(String label, String value, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.white24, fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 1)),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(icon, color: goldColor, size: 16),
                const SizedBox(width: 10),
                Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBeautifulDropdown(String label, List<String> items, String? val, Function(String?)? onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white24, fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 1)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: surfaceColor, 
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: val,
              isExpanded: true,
              dropdownColor: surfaceColor,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              items: items.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
