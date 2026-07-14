import 'package:flutter/material.dart';
import 'pitch_rating_view.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);

class OrganiserAttendanceView extends StatefulWidget {
  final String title;
  final String date;
  final String time;
  final String location;

  const OrganiserAttendanceView({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
  });

  @override
  State<OrganiserAttendanceView> createState() => _OrganiserAttendanceViewState();
}

class _OrganiserAttendanceViewState extends State<OrganiserAttendanceView> {
  final List<Map<String, dynamic>> _players = [
    {'name': 'James Doe', 'image': 'assets/images/sunil.png', 'wallet': 120, 'fee': 20, 'status': 'Attended', 'color': Colors.blueAccent},
    {'name': 'Marcus Reid', 'image': 'assets/images/sunil.png', 'wallet': 90, 'fee': 20, 'status': 'Attended', 'color': Colors.greenAccent},
    {'name': 'Sam Khan', 'image': 'assets/images/sunil.png', 'wallet': 60, 'fee': 20, 'status': 'Pending', 'color': Colors.pinkAccent},
    {'name': 'Omar Patel', 'image': 'assets/images/sunil.png', 'wallet': 0, 'fee': 20, 'status': 'Absent', 'color': Colors.orangeAccent},
    {'name': 'Lena Shah', 'image': 'assets/images/sunil.png', 'wallet': 45, 'fee': 20, 'status': 'Pending', 'color': Colors.grey},
    {'name': 'Zoe Miller', 'image': 'assets/images/sunil.png', 'wallet': 15, 'fee': 20, 'status': 'Pending', 'color': Colors.amberAccent},
  ];

  int get _attendedCount => _players.where((p) => p['status'] == 'Attended').length;
  int get _absentCount => _players.where((p) => p['status'] == 'Absent').length;
  int get _reservedCount => _players.length;

  void _markAbsent(int index) {
    setState(() {
      _players[index]['status'] = 'Absent';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Warning sent to ${_players[index]['name']}. Attendance marked as ABSENT.'),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  void _showPaymentPopup(int index) {
    final player = _players[index];
    int walletBalance = player['wallet'];
    int fee = player['fee'];
    bool hasBalance = walletBalance >= fee;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          String selectedMethod = hasBalance ? 'Wallet' : 'Cash';
          
          return Container(
            padding: const EdgeInsets.all(25),
            decoration: const BoxDecoration(
              color: Color(0xFF161616),
              borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(2)))),
                  const SizedBox(height: 25),
                  Text('How did ${player['name']} pay?', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 8),
                  Text('Game fee: $fee credits • ${widget.date}', style: const TextStyle(color: Colors.white38, fontSize: 12)),
                  const SizedBox(height: 25),

                  // Wallet Option
                  _buildPaymentMethodTile(
                    title: 'Wallet',
                    subtitle: 'Deduct from in-app balance',
                    detail: 'Balance: $walletBalance cr → ${walletBalance - fee} cr after',
                    icon: Icons.account_balance_wallet_outlined,
                    isSelected: selectedMethod == 'Wallet',
                    isEnabled: hasBalance,
                    onTap: () => setModalState(() => selectedMethod = 'Wallet'),
                    note: hasBalance ? null : 'insufficient balance — use cash',
                  ),
                  const SizedBox(height: 12),
                  // Cash Option
                  _buildPaymentMethodTile(
                    title: 'Cash',
                    subtitle: 'Marked as paid in person',
                    detail: 'No wallet deduction',
                    icon: Icons.payments_outlined,
                    isSelected: selectedMethod == 'Cash',
                    isEnabled: true,
                    onTap: () => setModalState(() => selectedMethod = 'Cash'),
                  ),
                  
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showConfirmation(index, selectedMethod);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: goldColor,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: Text('Confirm — ${selectedMethod.toLowerCase()} deduction', 
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel', style: TextStyle(color: Colors.white24, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  Widget _buildPaymentMethodTile({
    required String title,
    required String subtitle,
    required String detail,
    required IconData icon,
    required bool isSelected,
    required bool isEnabled,
    required VoidCallback onTap,
    String? note,
  }) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.4,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? goldColor.withValues(alpha: 0.05) : Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: isSelected ? goldColor : Colors.white.withValues(alpha: 0.05), width: 1.5),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: isSelected ? goldColor.withValues(alpha: 0.1) : Colors.black, borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: isSelected ? goldColor : Colors.white24, size: 22),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(subtitle, style: const TextStyle(color: Colors.white38, fontSize: 10)),
                    const SizedBox(height: 4),
                    Text(note ?? detail, style: TextStyle(color: note != null ? Colors.redAccent : goldColor, fontSize: 10, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              if (isSelected) const Icon(Icons.check_circle, color: goldColor, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmation(int index, String method) {
    final player = _players[index];
    setState(() {
      _players[index]['status'] = 'Attended';
      if (method == 'Wallet') {
        _players[index]['wallet'] -= player['fee'];
      }
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _ConfirmationReceipt(
        player: player['name'],
        game: widget.title,
        fee: player['fee'],
        method: method,
        prevBalance: player['wallet'] + (method == 'Wallet' ? player['fee'] : 0),
        newBalance: _players[index]['wallet'],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    double attendancePercentage = _attendedCount / _reservedCount;

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white70, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Back', style: TextStyle(color: Colors.white70, fontSize: 14)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 18),
            child: Text(widget.date, style: const TextStyle(color: goldColor, fontSize: 12, fontWeight: FontWeight.w900)),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                const SizedBox(height: 5),
                Text('${widget.location} • ${widget.time}', style: const TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildSummaryBox(_reservedCount.toString(), 'Reserved', Colors.white.withValues(alpha: 0.1)),
                const SizedBox(width: 10),
                _buildSummaryBox(_attendedCount.toString(), 'Attended', greenAccent.withValues(alpha: 0.1), textColor: greenAccent),
                const SizedBox(width: 10),
                _buildSummaryBox(_absentCount.toString(), 'Absent', Colors.redAccent.withValues(alpha: 0.1), textColor: Colors.redAccent),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: attendancePercentage,
                minHeight: 4,
                backgroundColor: Colors.white.withValues(alpha: 0.05),
                valueColor: const AlwaysStoppedAnimation(greenAccent),
              ),
            ),
          ),
          const SizedBox(height: 35),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('PLAYERS', style: TextStyle(color: Colors.white24, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
                Text('$_reservedCount RESERVED', style: const TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.w900)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              itemCount: _players.length,
              itemBuilder: (context, index) {
                final p = _players[index];
                bool isPending = p['status'] == 'Pending';

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 45, height: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(image: AssetImage(p['image']), fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 15)),
                            const SizedBox(height: 4),
                            if (isPending)
                              Text('Wallet: ${p['wallet']} cr · Fee: ${p['fee']} cr', style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.w600))
                            else if (p['status'] == 'Attended')
                              const Text('Attended · Fee processed', style: TextStyle(color: greenAccent, fontSize: 10, fontWeight: FontWeight.bold))
                            else
                              const Text('Cash paid · Fee: 20 cr', style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      if (isPending) ...[
                        _buildActionBtn('Attended', greenAccent, () => _showPaymentPopup(index)),
                        const SizedBox(width: 8),
                        _buildActionBtn('Absent', Colors.redAccent, () => _markAbsent(index), isOutline: true),
                      ] else
                        _buildStatusPill(p['status']),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PitchRatingView(title: widget.title))),
              style: ElevatedButton.styleFrom(
                backgroundColor: goldColor,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text('PROCEED TO PLAYER RATINGS', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, letterSpacing: 1)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryBox(String val, String label, Color bg, {Color textColor = Colors.white}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Text(val, style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.w900)),
            Text(label, style: TextStyle(color: textColor.withValues(alpha: 0.5), fontSize: 9, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionBtn(String label, Color color, VoidCallback onTap, {bool isOutline = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isOutline ? Colors.transparent : color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10),
          border: isOutline ? Border.all(color: color.withValues(alpha: 0.3)) : null,
        ),
        child: Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w900)),
      ),
    );
  }

  Widget _buildStatusPill(String status) {
    bool isAttended = status == 'Attended';
    Color color = isAttended ? greenAccent : Colors.redAccent;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(status, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w900)),
    );
  }
}

class _ConfirmationReceipt extends StatelessWidget {
  final String player;
  final String game;
  final int fee;
  final String method;
  final int prevBalance;
  final int newBalance;

  const _ConfirmationReceipt({
    required this.player,
    required this.game,
    required this.fee,
    required this.method,
    required this.prevBalance,
    required this.newBalance,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: greenAccent.withValues(alpha: 0.1), shape: BoxShape.circle),
                child: const Icon(Icons.check_rounded, color: greenAccent, size: 50),
              ),
              const SizedBox(height: 30),
              const Text('Attendance confirmed', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
              const SizedBox(height: 10),
              Text('$player · $game', style: const TextStyle(color: Colors.white38, fontSize: 14)),
              const SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                ),
                child: Column(
                  children: [
                    _receiptRow('Player', player),
                    _receiptRow('Game fee', '$fee credits', valColor: goldColor),
                    _receiptRow('Payment method', method, valColor: goldColor),
                    _receiptRow('Previous balance', '$prevBalance cr'),
                    const Divider(color: Colors.white10, height: 40),
                    _receiptRow('Remaining balance', '$newBalance cr', isBold: true),
                  ],
                ),
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: goldColor,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('DONE', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, letterSpacing: 2)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _receiptRow(String label, String val, {Color? valColor, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: isBold ? Colors.white : Colors.white38, fontSize: 14, fontWeight: isBold ? FontWeight.w900 : FontWeight.normal)),
          Text(val, style: TextStyle(color: valColor ?? Colors.white, fontSize: 14, fontWeight: isBold ? FontWeight.w900 : FontWeight.bold)),
        ],
      ),
    );
  }
}
