import 'package:flutter/material.dart';
import 'chat_page.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class PlayerDetailPage extends StatefulWidget {
  final String playerName;
  final String playerNumber;
  final String position;

  const PlayerDetailPage({
    super.key,
    required this.playerName,
    required this.playerNumber,
    required this.position,
  });

  @override
  State<PlayerDetailPage> createState() => _PlayerDetailPageState();
}

class _PlayerDetailPageState extends State<PlayerDetailPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isCaptain = false;
  
  double restingHours = 8.0;
  double bodyFat = 12.0;
  int vo2Max = 55;

  Map<String, double> skills = {
    'Shooting': 4.5,
    'Passing': 3.8,
    'Dribbling': 4.1,
    'Defending': 1.8,
    'Physical': 4.4,
    'Saving': 4.6,
    'Saved': 4.2,
  };

  Color _getSkillColor(String skill) {
    switch (skill.toLowerCase()) {
      case 'shooting': return Colors.orange;
      case 'passing': return Colors.blue;
      case 'dribbling': return Colors.purple;
      case 'defending': return Colors.teal;
      case 'physical': return Colors.red;
      case 'saving': return Colors.greenAccent;
      case 'saved': return Colors.lightBlueAccent;
      default: return goldColor;
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _showFitnessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        double tempResting = restingHours;
        double tempFat = bodyFat;
        int tempVo2 = vo2Max;
        TextEditingController titleController = TextEditingController();
        TextEditingController messageController = TextEditingController();

        return AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Text('MANAGE EVALUATION', style: TextStyle(color: goldColor, fontSize: 16, fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Test Title / Session Name',
                    labelStyle: TextStyle(color: Colors.white38),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white10)),
                  ),
                ),
                const SizedBox(height: 20),
                _buildSliderRow('Resting Hours', 0, 24, tempResting, (v) => tempResting = v),
                _buildSliderRow('Body Fat %', 5, 25, tempFat, (v) => tempFat = v),
                _buildSliderRow('VO2 Max', 30, 90, tempVo2.toDouble(), (v) => tempVo2 = v.toInt()),
                const SizedBox(height: 20),
                const Text('SKILL ADJUSTMENTS', style: TextStyle(color: Colors.white60, fontSize: 12, fontWeight: FontWeight.bold)),
                ...skills.keys.map((s) => _buildSmallSliderRow(s, skills[s]!, (v) => skills[s] = v)),
                const SizedBox(height: 20),
                TextField(
                  controller: messageController,
                  maxLines: 2,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Message for Player Notification',
                    labelStyle: TextStyle(color: Colors.white38),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white10)),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL', style: TextStyle(color: Colors.white38))),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: goldColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              onPressed: () {
                setState(() {
                  restingHours = tempResting;
                  bodyFat = tempFat;
                  vo2Max = tempVo2;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Player evaluated and notification sent!')));
              },
              child: const Text('SAVE & SEND', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSliderRow(String label, double min, double max, double value, Function(double) onChanged) {
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
              Text(value.toStringAsFixed(1), style: const TextStyle(color: goldColor, fontWeight: FontWeight.bold)),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            activeColor: goldColor,
            inactiveColor: Colors.white10,
            onChanged: (v) {
              setState(() => value = v);
              onChanged(v);
            },
          ),
        ],
      );
    });
  }

  Widget _buildSmallSliderRow(String label, double value, Function(double) onChanged) {
    return StatefulBuilder(builder: (context, setState) {
      return Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(color: Colors.white38, fontSize: 11))),
          Expanded(
            flex: 2,
            child: Slider(
              value: value,
              min: 0,
              max: 5,
              divisions: 10,
              activeColor: goldColor,
              onChanged: (v) {
                setState(() => value = v);
                onChanged(v);
              },
            ),
          ),
          Text(value.toStringAsFixed(1), style: const TextStyle(color: goldColor, fontSize: 10)),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              backgroundColor: const Color(0xFF0D0D0D),
              leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
              actions: [
                IconButton(
                  icon: const Icon(Icons.chat_bubble_outline, color: goldColor),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(playerName: widget.playerName))),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, darkBg.withOpacity(0.8), darkBg],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: goldColor, width: 2),
                                boxShadow: [BoxShadow(color: goldColor.withOpacity(0.2), blurRadius: 20)],
                              ),
                              child: const CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage('assets/images/sunil.png'),
                              ),
                            ),
                            if (isCaptain)
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(color: goldColor, shape: BoxShape.circle),
                                  child: const Text('C', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(widget.playerName.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: 1)),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildHeaderPill(widget.position),
                            const SizedBox(width: 8),
                            _buildHeaderPill('#${widget.playerNumber}'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: darkBg,
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: goldColor,
                  labelColor: goldColor,
                  unselectedLabelColor: Colors.white38,
                  labelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1),
                  tabs: const [
                    Tab(text: 'SKILLS'),
                    Tab(text: 'FITNESS'),
                    Tab(text: 'ATTENDANCE'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildSkillsTab(),
            _buildFitnessTab(),
            _buildAttendanceTab(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _showFitnessDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: goldColor,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('NEW EVALUATION', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                color: isCaptain ? Colors.redAccent.withOpacity(0.1) : goldColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isCaptain ? Colors.redAccent : goldColor),
              ),
              child: IconButton(
                icon: Icon(isCaptain ? Icons.star : Icons.star_border, color: isCaptain ? Colors.redAccent : goldColor),
                onPressed: () => setState(() => isCaptain = !isCaptain),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: goldColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: goldColor.withOpacity(0.2)),
      ),
      child: Text(text, style: const TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSkillsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 2.5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: skills.entries.map((e) => _buildSkillCard(e.key, e.value)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(String label, double rating) {
    Color color = _getSkillColor(label);
    double progress = rating / 5.0;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.02)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
              Text('${(progress * 100).toInt()}%', style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white10,
              valueColor: AlwaysStoppedAnimation(color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFitnessTab() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            children: [
              _buildFitnessCard('RESTING', '$restingHours h', Icons.bedtime_outlined),
              const SizedBox(width: 12),
              _buildFitnessCard('BODY FAT', '$bodyFat%', Icons.monitor_weight_outlined),
              const SizedBox(width: 12),
              _buildFitnessCard('VO2 MAX', '$vo2Max', Icons.speed),
            ],
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: surfaceColor, borderRadius: BorderRadius.circular(24)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('COACH NOTES', style: TextStyle(color: Colors.white60, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
                SizedBox(height: 15),
                Text('Player shows excellent recovery rates after high-intensity intervals. Tactical understanding of defensive shape has improved significantly.',
                  style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFitnessCard(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(color: surfaceColor, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Icon(icon, color: goldColor.withOpacity(0.5), size: 24),
            const SizedBox(height: 10),
            Text(label, style: const TextStyle(color: Colors.white24, fontSize: 9, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceTab() {
    return ListView(
      padding: const EdgeInsets.all(25),
      children: [
        _buildAttendanceItem('Training Session', '02 JUL', 'PRESENT', Colors.greenAccent),
        _buildAttendanceItem('Match v East Bengal', '30 JUN', 'PRESENT', Colors.greenAccent),
        _buildAttendanceItem('Tactical Meeting', '28 JUN', 'ABSENT', Colors.redAccent),
        _buildAttendanceItem('Recovery Session', '25 JUN', 'PRESENT', Colors.greenAccent),
      ],
    );
  }

  Widget _buildAttendanceItem(String title, String date, String status, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: surfaceColor, borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              Text(date, style: const TextStyle(color: Colors.white24, fontSize: 11)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: Text(status, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
