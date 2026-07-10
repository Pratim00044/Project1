import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class CdlTeamsManagement extends StatefulWidget {
  const CdlTeamsManagement({super.key});

  @override
  State<CdlTeamsManagement> createState() => _CdlTeamsManagementState();
}

class _CdlTeamsManagementState extends State<CdlTeamsManagement> {
  final List<Map<String, String>> _teams = [
    {'name': 'Core FC', 'logo': 'C', 'city': 'Dubai', 'founded': '2015'},
    {'name': 'Dubai Lions', 'logo': 'D', 'city': 'Abu Dhabi', 'founded': '2018'},
    {'name': 'Eagle FC', 'logo': 'E', 'city': 'Sharjah', 'founded': '2020'},
    {'name': 'Turan Dubai', 'logo': 'T', 'city': 'Dubai', 'founded': '2022'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        centerTitle: true,
        title: const Text('TEAMS & LOGOS', style: TextStyle(color: goldColor, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18), onPressed: () => Navigator.pop(context)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(25, 20, 25, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('REGISTERED TEAMS', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                Text('Manage club identities and branding', style: TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: _teams.length,
              itemBuilder: (context, index) {
                final team = _teams[index];
                final List<Color> cardColors = index % 4 == 0 
                    ? [const Color(0xFFFFB75E), const Color(0xFFED8F03)]
                    : index % 4 == 1
                        ? [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)]
                        : index % 4 == 2
                            ? [const Color(0xFF00C6FF), const Color(0xFF0072FF)]
                            : [const Color(0xFF11998E), const Color(0xFF38EF7D)];

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: cardColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 4))
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                        ),
                        child: Center(
                          child: Text(team['logo']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 24)),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(team['name']!.toUpperCase(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
                            const SizedBox(height: 5),
                            Wrap(
                              spacing: 12,
                              runSpacing: 4,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.location_on, color: Colors.white70, size: 12),
                                    const SizedBox(width: 4),
                                    Text(team['city']!, style: const TextStyle(color: Colors.white70, fontSize: 11)),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.history, color: Colors.white70, size: 12),
                                    const SizedBox(width: 4),
                                    Text('Est. ${team['founded']}', style: const TextStyle(color: Colors.white70, fontSize: 11)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit_note_rounded, color: Colors.white, size: 24),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: goldColor,
        elevation: 10,
        onPressed: () => _showAddTeamDialog(),
        icon: const Icon(Icons.add, color: Colors.black),
        label: const Text('ADD NEW TEAM', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 12)),
      ),
    );
  }

  void _showAddTeamDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Color(0xFF161616),
          borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
        ),
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10)))),
            const SizedBox(height: 30),
            const Text('REGISTER NEW TEAM', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
            const SizedBox(height: 30),
            _buildFieldLabel('TEAM NAME'),
            _buildTextField('Enter official team name'),
            const SizedBox(height: 25),
            _buildFieldLabel('BASE CITY'),
            _buildTextField('e.g. Dubai, Abu Dhabi'),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: goldColor.withValues(alpha: 0.1)),
              ),
              child: Column(
                children: [
                  const Icon(Icons.cloud_upload_outlined, color: goldColor, size: 32),
                  const SizedBox(height: 10),
                  const Text('UPLOAD TEAM LOGO', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                  const Text('Recommended size: 512x512 PNG', style: TextStyle(color: Colors.white24, fontSize: 10)),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: goldColor,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text('CREATE TEAM IDENTITY', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 8),
      child: Text(label, style: const TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
    );
  }

  Widget _buildTextField(String hint) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white24, fontSize: 14),
        filled: true,
        fillColor: Colors.black,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
    );
  }
}
