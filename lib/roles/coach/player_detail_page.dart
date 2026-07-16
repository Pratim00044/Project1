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
  
  double restingHours = 8.0;
  double bodyFat = 12.0;
  int vo2Max = 55;
  int walletBalance = 525;

  Map<String, double> skills = {
    'Readiness for learning': 4.0,
    'Attitude': 4.5,
    'Work Ethic': 4.1,
    'Communication': 3.8,
    'Teamwork': 4.3,
    'Technical': 4.2,
    'Passing': 4.6,
    'Possession': 4.4,
  };

  Color _getSkillColor(String skill) {
    switch (skill.toLowerCase()) {
      case 'readiness for learning': return Colors.greenAccent;
      case 'attitude': return Colors.orange;
      case 'work ethic': return Colors.purple;
      case 'communication': return Colors.blue;
      case 'teamwork': return Colors.teal;
      case 'technical': return Colors.amber;
      case 'passing': return Colors.red;
      case 'possession': return Colors.indigoAccent;
      default: return goldColor;
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _showFitnessDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        double tempResting = restingHours;
        double tempFat = bodyFat;
        int tempVo2 = vo2Max;
        TextEditingController titleController = TextEditingController();
        TextEditingController messageController = TextEditingController();

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: const BoxDecoration(
                color: Color(0xFF111111),
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(
                    width: 40, height: 4,
                    decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(2)),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('MANAGE EVALUATION',
                            style: TextStyle(color: goldColor, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close, color: Colors.white38),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildModalLabel('SESSION DETAILS', Icons.edit_calendar_rounded),
                          const SizedBox(height: 15),
                          TextField(
                            controller: titleController,
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'e.g., Weekly Fitness Test / ISL Recovery',
                              hintStyle: const TextStyle(color: Colors.white12),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.03),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                              contentPadding: const EdgeInsets.all(20),
                            ),
                          ),
                          const SizedBox(height: 35),
                          
                          _buildModalLabel('PHYSICAL METRICS', Icons.speed_rounded),
                          const SizedBox(height: 20),
                          _buildPremiumSlider(
                            label: 'Resting Hours',
                            icon: Icons.bedtime_outlined,
                            value: tempResting,
                            min: 0, max: 15,
                            suffix: 'h',
                            onChanged: (v) => setModalState(() => tempResting = v),
                          ),
                          const SizedBox(height: 20),
                          _buildPremiumSlider(
                            label: 'Body Fat %',
                            icon: Icons.monitor_weight_outlined,
                            value: tempFat,
                            min: 5, max: 25,
                            suffix: '%',
                            onChanged: (v) => setModalState(() => tempFat = v),
                          ),
                          const SizedBox(height: 20),
                          _buildPremiumSlider(
                            label: 'VO2 Max',
                            icon: Icons.bolt,
                            value: tempVo2.toDouble(),
                            min: 30, max: 80,
                            onChanged: (v) => setModalState(() => tempVo2 = v.toInt()),
                          ),
                          
                          const SizedBox(height: 35),
                          _buildModalLabel('SKILL EVALUATION', Icons.star_outline_rounded),
                          const SizedBox(height: 20),
                          ...skills.keys.map((s) => Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: _buildPremiumSlider(
                              label: s,
                              value: skills[s]!,
                              min: 0, max: 5,
                              isSmall: true,
                              onChanged: (v) => setModalState(() => skills[s] = v),
                            ),
                          )),
                          
                          const SizedBox(height: 35),
                          _buildModalLabel('NOTIFY PLAYER', Icons.chat_bubble_outline_rounded),
                          const SizedBox(height: 15),
                          TextField(
                            controller: messageController,
                            maxLines: 3,
                            style: const TextStyle(color: Colors.white, fontSize: 13),
                            decoration: InputDecoration(
                              hintText: 'Add a personal note for the player...',
                              hintStyle: const TextStyle(color: Colors.white12),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.03),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                              contentPadding: const EdgeInsets.all(20),
                            ),
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(25, 15, 25, 35),
                    decoration: BoxDecoration(
                      color: const Color(0xFF111111),
                      border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('DISCARD', style: TextStyle(color: Colors.white38, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: goldColor,
                              minimumSize: const Size(double.infinity, 55),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            onPressed: () {
                              setState(() {
                                restingHours = tempResting;
                                bodyFat = tempFat;
                                vo2Max = tempVo2;
                              });
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Player evaluated successfully!'), backgroundColor: Colors.green),
                              );
                            },
                            child: const Text('SAVE & SEND', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildModalLabel(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: goldColor.withOpacity(0.5), size: 16),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
      ],
    );
  }

  Widget _buildPremiumSlider({
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
    IconData? icon,
    String suffix = '',
    bool isSmall = false,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (icon != null) Icon(icon, color: Colors.white24, size: 14),
                if (icon != null) const SizedBox(width: 8),
                Text(label, style: TextStyle(color: Colors.white, fontSize: isSmall ? 12 : 14, fontWeight: isSmall ? FontWeight.w500 : FontWeight.bold)),
              ],
            ),
            Row(
              children: [
                if (isSmall) ...List.generate(5, (index) => Icon(
                  index < value.floor() ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: goldColor,
                  size: 14,
                )),
                const SizedBox(width: 8),
                Text('${isSmall ? value.toStringAsFixed(1) : value.toInt()}$suffix', 
                  style: TextStyle(color: goldColor, fontWeight: FontWeight.w900, fontSize: isSmall ? 12 : 16)),
              ],
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 2,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
            activeTrackColor: goldColor,
            inactiveTrackColor: Colors.white10,
            thumbColor: goldColor,
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: isSmall ? 10 : null,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  void _showLowBalanceAlert() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reminder: Wallet balance is low (65 AED).'), backgroundColor: Colors.orange),
    );
  }

  void _showZeroBalanceAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: surfaceColor,
        title: const Text('Insufficient Balance', style: TextStyle(color: Colors.white)),
        content: const Text('Wallet balance is 0. Please pay for the next 8 sessions (525 AED) to continue.', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK', style: TextStyle(color: goldColor))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Core FC Theme .jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                backgroundColor: const Color(0xFF0D0D0D),
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                  onPressed: () => Navigator.pop(context),
                ),
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
                          const SizedBox(height: 15),
                          Text(widget.playerName.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: 1)),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildHeaderPill(widget.position),
                              const SizedBox(width: 8),
                              _buildHeaderPill('#${widget.playerNumber}'),
                              const SizedBox(width: 8),
                              _buildHeaderPill('TOWN SQUARE'),
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
          body: Container(
            color: darkBg,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSkillsTab(),
                _buildFitnessTab(),
                _buildAttendanceTab(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              gradient: const LinearGradient(
                colors: [Color(0xFF2E5B4F), Color(0xFF3B2A50)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(color: const Color(0xFF2E5B4F).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))
              ],
            ),
            child: ElevatedButton(
              onPressed: _showFitnessDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                minimumSize: const Size(double.infinity, 65),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                elevation: 0,
              ),
              child: const Text('NEW EVALUATION', 
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 1)),
            ),
          ),
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
            childAspectRatio: 2.0,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: skills.entries.map((e) => _buildSkillCard(e.key, e.value)).toList(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSkillCard(String label, double rating) {
    Color color = _getSkillColor(label);
    double progress = rating / 5.0;
    
    Widget? trailing;
    if (label.toLowerCase().contains('readiness')) {
      Color lightColor = rating >= 4.0 ? Colors.green : (rating >= 2.5 ? Colors.orange : Colors.red);
      trailing = Container(
        width: 8, height: 8,
        decoration: BoxDecoration(color: lightColor, shape: BoxShape.circle, boxShadow: [BoxShadow(color: lightColor.withOpacity(0.5), blurRadius: 4)]),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.02)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(label.toUpperCase(), 
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (trailing != null) const SizedBox(width: 6),
                    if (trailing != null) trailing,
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text('${(progress * 100).toInt()}%', style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w900)),
            ],
          ),
          const SizedBox(height: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withOpacity(0.05),
              valueColor: AlwaysStoppedAnimation(color),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFitnessTab() {
    return SingleChildScrollView(
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
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildFitnessCard(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1E3A8A), Color(0xFF312E81)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white70, size: 24),
            const SizedBox(height: 10),
            Text(label, style: const TextStyle(color: Colors.white54, fontSize: 9, fontWeight: FontWeight.bold)),
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
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2E5B4F), Color(0xFF3B2A50)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('WALLET BALANCE', style: TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  const SizedBox(height: 5),
                  Text('$walletBalance AED', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (walletBalance >= 65) {
                    setState(() => walletBalance -= 65);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Attendance marked. 65 credits deducted. Remaining: $walletBalance AED'), backgroundColor: Colors.green),
                    );
                    if (walletBalance == 65) {
                      _showLowBalanceAlert();
                    }
                  } else {
                    _showZeroBalanceAlert();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2), 
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text('MARK ATTENDED', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
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
