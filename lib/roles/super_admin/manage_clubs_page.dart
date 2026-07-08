import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class ManageClubsPage extends StatefulWidget {
  const ManageClubsPage({super.key});

  @override
  State<ManageClubsPage> createState() => _ManageClubsPageState();
}

class _ManageClubsPageState extends State<ManageClubsPage> {
  final List<Map<String, dynamic>> _clubs = [
    {'name': 'CORE FC', 'logo': 'assets/logo.png', 'theme': 'assets/images/Core FC Theme .jpeg', 'members': 45, 'status': 'Active', 'category': 'Professional'},
    {'name': 'Dubai Lions', 'logo': 'assets/logo.png', 'theme': 'assets/images/login_background.jpeg', 'members': 32, 'status': 'Active', 'category': 'Semi-Pro'},
    {'name': 'Eagle FC', 'logo': 'assets/logo.png', 'theme': 'assets/images/login_background.jpeg', 'members': 28, 'status': 'Suspended', 'category': 'Youth'},
    {'name': 'United Football Club', 'logo': 'assets/logo.png', 'theme': 'assets/images/login_background.jpeg', 'members': 50, 'status': 'Active', 'category': 'Professional'},
    {'name': 'City Football', 'logo': 'assets/logo.png', 'theme': 'assets/images/login_background.jpeg', 'members': 40, 'status': 'Active', 'category': 'Amateur'},
  ];

  void _editClub(Map<String, dynamic> club) {
    TextEditingController nameController = TextEditingController(text: club['name']);
    String selectedStatus = club['status'];
    String selectedCategory = club['category'];
    String currentTheme = club['theme'];
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: surfaceColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Text('EDIT CLUB PROFILE', style: TextStyle(color: goldColor, fontSize: 16, fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('CLUB LOGO', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(image: AssetImage(club['logo']), fit: BoxFit.contain),
                        ),
                      ),
                      Positioned(
                        right: -5,
                        bottom: -5,
                        child: IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Selecting new logo from gallery...')));
                          },
                          icon: const CircleAvatar(backgroundColor: goldColor, radius: 15, child: Icon(Icons.camera_alt, color: Colors.black, size: 15)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                const Text('CLUB THEME IMAGE', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    setDialogState(() {
                      currentTheme = currentTheme == 'assets/images/Core FC Theme .jpeg'
                        ? 'assets/images/login_background.jpeg' 
                        : 'assets/images/Core FC Theme .jpeg';
                    });
                  },
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: goldColor.withOpacity(0.3)),
                      image: DecorationImage(image: AssetImage(currentTheme), fit: BoxFit.cover, opacity: 0.6),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.cloud_upload_outlined, color: goldColor, size: 28),
                          const SizedBox(height: 8),
                          Text('REPLACE THEME', style: TextStyle(color: goldColor.withOpacity(0.8), fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                TextField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Club Name',
                    labelStyle: const TextStyle(color: Colors.white38, fontSize: 12),
                    filled: true,
                    fillColor: Colors.black12,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 15),
                _buildDropdownField('Status', selectedStatus, ['Active', 'Suspended', 'Inactive'], (val) {
                  setDialogState(() => selectedStatus = val!);
                }),
                const SizedBox(height: 15),
                _buildDropdownField('Category', selectedCategory, ['Professional', 'Semi-Pro', 'Amateur', 'Youth'], (val) {
                  setDialogState(() => selectedCategory = val!);
                }),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL', style: TextStyle(color: Colors.white38))),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  club['name'] = nameController.text;
                  club['status'] = selectedStatus;
                  club['category'] = selectedCategory;
                  club['theme'] = currentTheme;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Club profile updated successfully!')));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: goldColor,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('SAVE CHANGES', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(15)),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            dropdownColor: surfaceColor,
            underline: const SizedBox(),
            style: const TextStyle(color: Colors.white),
            items: items.map((String item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        title: const Text('CLUB REPOSITORY', style: TextStyle(color: goldColor, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _clubs.length,
        itemBuilder: (context, index) {
          final club = _clubs[index];
          final bool isSuspended = club['status'] == 'Suspended';
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: isSuspended ? Colors.redAccent.withOpacity(0.2) : Colors.white.withOpacity(0.02)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(15),
              leading: Container(
                width: 55, height: 55,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15)),
                child: Image.asset(club['logo'], fit: BoxFit.contain),
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      club['name'], 
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isSuspended) ...[
                    const SizedBox(width: 8),
                    const Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 14),
                  ],
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('${club['category']} • ${club['members']} Members', style: const TextStyle(color: Colors.white24, fontSize: 11)),
                  Text(club['status'], style: TextStyle(color: isSuspended ? Colors.redAccent : Colors.greenAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
              trailing: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.tune_rounded, color: goldColor, size: 20),
              ),
              onTap: () => _editClub(club),
            ),
          );
        },
      ),
    );
  }
}
