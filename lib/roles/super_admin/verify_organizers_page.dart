import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class VerifyOrganisersPage extends StatefulWidget {
  const VerifyOrganisersPage({super.key});

  @override
  State<VerifyOrganisersPage> createState() => _VerifyOrganisersPageState();
}

class _VerifyOrganisersPageState extends State<VerifyOrganisersPage> {
  final List<Map<String, dynamic>> _pendingOrganisers = [
    {
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'clubName': 'Dubai Lions',
      'experience': '10 Years',
      'documents': 'Verified',
      'signupDate': '02 July 2024',
    },
    {
      'name': 'Sarah Smith',
      'email': 'sarah.smith@club.ae',
      'clubName': 'Eagle FC',
      'experience': '5 Years',
      'documents': 'Pending Review',
      'signupDate': '01 July 2024',
    },
    {
      'name': 'Ahmed Khalil',
      'email': 'ahmed@sports.ae',
      'clubName': 'United Football Club',
      'experience': '12 Years',
      'documents': 'Verified',
      'signupDate': '30 June 2024',
    },
  ];

  void _showOrganiserDetails(Map<String, dynamic> organiser) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text('ORGANISER/HOST APPLICATION', 
                      style: TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: Colors.orange.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                    child: const Text('PENDING REVIEW', style: TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const Text('Personal Information', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              _buildDetailRow('Full Name', organiser['name']),
              _buildDetailRow('Email Address', organiser['email']),
              _buildDetailRow('Phone Number', '+971 50 123 4567'),
              
              const Divider(color: Colors.white10, height: 40),
              const Text('Club Details', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              _buildDetailRow('Target Club', organiser['clubName']),
              _buildDetailRow('Professional Experience', organiser['experience']),
              
              const Divider(color: Colors.white10, height: 40),
              const Text('Verification Documents', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              _buildDocumentItem('Identity Proof (Emirates ID)', 'Verified'),
              _buildDocumentItem('Coaching License', organiser['documents']),
              _buildDocumentItem('Club Affiliation Letter', 'Pending'),
              
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _pendingOrganisers.remove(organiser);
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Application Rejected')));
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.redAccent),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: const Text('REJECT', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _pendingOrganisers.remove(organiser);
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Organiser/Host ${organiser['name']} approved!')));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: const Text('APPROVE', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentItem(String title, String status) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            const Icon(Icons.description_outlined, color: Colors.white38, size: 20),
            const SizedBox(width: 15),
            Expanded(child: Text(title, style: const TextStyle(color: Colors.white70, fontSize: 14))),
            Text(status, style: TextStyle(color: status == 'Verified' ? Colors.greenAccent : Colors.orangeAccent, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        centerTitle: true,
        title: const Text('PENDING APPROVALS', style: TextStyle(color: goldColor, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _pendingOrganisers.isEmpty
          ? const Center(child: Text('No pending organisers', style: TextStyle(color: Colors.white24)))
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _pendingOrganisers.length,
              itemBuilder: (context, index) {
                final organiser = _pendingOrganisers[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.02)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: const CircleAvatar(backgroundColor: Color(0xFF1A1A1A), child: Icon(Icons.person, color: goldColor)),
                    title: Text(organiser['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: Text(organiser['clubName'], style: const TextStyle(color: Colors.white38, fontSize: 12)),
                    trailing: const Icon(Icons.chevron_right, color: Colors.white10),
                    onTap: () => _showOrganiserDetails(organiser),
                  ),
                );
              },
            ),
    );
  }
}
