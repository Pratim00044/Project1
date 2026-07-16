import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class CdlTeamsManagement extends StatefulWidget {
  const CdlTeamsManagement({super.key});

  @override
  State<CdlTeamsManagement> createState() => CdlTeamsManagementState();
}

class CdlTeamsManagementState extends State<CdlTeamsManagement> {
  final List<Map<String, dynamic>> _teams = [
    {'name': 'Core FC', 'logo': 'C', 'city': 'Dubai', 'founded': '2015', 'gradient': [Color(0xFF2E5B4F), Color(0xFF3B2A50)]},
    {'name': 'Dubai Lions', 'logo': 'D', 'city': 'Abu Dhabi', 'founded': '2018', 'gradient': [Color(0xFF1E3A8A), Color(0xFF312E81)]},
    {'name': 'Eagle FC', 'logo': 'E', 'city': 'Sharjah', 'founded': '2020', 'gradient': [Color(0xFF064E3B), Color(0xFF14532D)]},
    {'name': 'Turan Dubai', 'logo': 'T', 'city': 'Dubai', 'founded': '2022', 'gradient': [Color(0xFF334155), Color(0xFF1E293B)]},
  ];

  void showAddTeamDialog() {
    _showAddTeamDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: _teams.length,
              itemBuilder: (context, index) {
                final team = _teams[index];
                final List<Color> gradient = team['gradient'];

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(color: gradient[0].withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 5)),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.asset('assets/images/footlab.png', fit: BoxFit.cover),
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
                        icon: const Icon(Icons.edit_note_rounded, color: goldColor, size: 24),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddTeamDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
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
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
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
                        child: const Column(
                          children: [
                            Icon(Icons.cloud_upload_outlined, color: goldColor, size: 32),
                            SizedBox(height: 10),
                            Text('UPLOAD TEAM LOGO', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                            Text('Recommended size: 512x512 PNG', style: TextStyle(color: Colors.white24, fontSize: 10)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
