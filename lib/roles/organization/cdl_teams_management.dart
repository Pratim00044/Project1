import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class CdlTeamsManagement extends StatefulWidget {
  const CdlTeamsManagement({super.key});

  @override
  State<CdlTeamsManagement> createState() => _CdlTeamsManagementState();
}

class _CdlTeamsManagementState extends State<CdlTeamsManagement> {
  final List<Map<String, dynamic>> _teams = [
    {'name': 'Core FC', 'logo': 'C', 'city': 'Dubai', 'founded': '2015', 'color': Color(0xFF1E3A8A)},
    {'name': 'Dubai Lions', 'logo': 'D', 'city': 'Abu Dhabi', 'founded': '2018', 'color': Color(0xFF3730A3)},
    {'name': 'Eagle FC', 'logo': 'E', 'city': 'Sharjah', 'founded': '2020', 'color': Color(0xFF5B21B6)},
    {'name': 'Turan Dubai', 'logo': 'T', 'city': 'Dubai', 'founded': '2022', 'color': Color(0xFF7C3AED)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
                final Color tileColor = team['color'];

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: tileColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(18),
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
