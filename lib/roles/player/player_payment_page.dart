import 'package:flutter/material.dart';
import 'player_receipt_page.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);

class PlayerPaymentPage extends StatefulWidget {
  final String title;
  final String date;
  final String time;
  final String location;
  final int fee;

  const PlayerPaymentPage({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    this.fee = 20,
  });

  @override
  State<PlayerPaymentPage> createState() => _PlayerPaymentPageState();
}

class _PlayerPaymentPageState extends State<PlayerPaymentPage> {
  String _selectedMethod = 'Wallet';
  final int _walletBalance = 120;

  @override
  Widget build(BuildContext context) {
    bool hasBalance = _walletBalance >= widget.fee;

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white70),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Confirm Reservation', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Game Info Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60, height: 60,
                    decoration: BoxDecoration(
                      color: goldColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(Icons.sports_soccer, color: goldColor, size: 30),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 4),
                        Text('${widget.date} • ${widget.time}', style: const TextStyle(color: Colors.white38, fontSize: 12)),
                        Text(widget.location, style: const TextStyle(color: Colors.white38, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            const Text('PAYMENT METHOD', style: TextStyle(color: Colors.white24, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
            const SizedBox(height: 15),

            // Wallet Option
            _buildPaymentMethodTile(
              title: 'Wallet Balance',
              subtitle: 'Pay using your in-app credits',
              detail: 'Balance: $_walletBalance cr → ${_walletBalance - widget.fee} cr after',
              icon: Icons.account_balance_wallet_outlined,
              isSelected: _selectedMethod == 'Wallet',
              isEnabled: hasBalance,
              onTap: () => setState(() => _selectedMethod = 'Wallet'),
              note: hasBalance ? null : 'insufficient balance — please top up',
            ),
            const SizedBox(height: 12),
            // Cash Option
            _buildPaymentMethodTile(
              title: 'Pay at Pitch',
              subtitle: 'Cash payment to the organiser',
              detail: 'Marked as reserved (unpaid)',
              icon: Icons.payments_outlined,
              isSelected: _selectedMethod == 'Cash',
              isEnabled: true,
              onTap: () => setState(() => _selectedMethod = 'Cash'),
            ),

            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: goldColor.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: goldColor.withValues(alpha: 0.1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total to Pay', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                  Text('${widget.fee} credits', style: const TextStyle(color: goldColor, fontSize: 20, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PlayerReceiptPage(
                    player: 'James Doe',
                    game: widget.title,
                    fee: widget.fee,
                    method: _selectedMethod,
                    prevBalance: _walletBalance,
                    newBalance: _selectedMethod == 'Wallet' ? _walletBalance - widget.fee : _walletBalance,
                  )),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: goldColor,
                minimumSize: const Size(double.infinity, 65),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text('CONFIRM RESERVATION', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, letterSpacing: 1)),
            ),
          ],
        ),
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
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: isSelected ? goldColor.withValues(alpha: 0.05) : surfaceColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: isSelected ? goldColor : Colors.white.withValues(alpha: 0.03), width: 1.5),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: isSelected ? goldColor.withValues(alpha: 0.1) : Colors.black, borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: isSelected ? goldColor : Colors.white24, size: 24),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                    Text(subtitle, style: const TextStyle(color: Colors.white38, fontSize: 11)),
                    const SizedBox(height: 6),
                    Text(note ?? detail, style: TextStyle(color: note != null ? Colors.redAccent : (isSelected ? goldColor : Colors.white24), fontSize: 11, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              if (isSelected) const Icon(Icons.check_circle, color: goldColor, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}
