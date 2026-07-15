import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);
const Color greenAccent = Color(0xFF2ECC71);

class PlayerReceiptPage extends StatelessWidget {
  final String player;
  final String game;
  final int fee;
  final String method;
  final int prevBalance;
  final int newBalance;

  const PlayerReceiptPage({
    super.key,
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
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(color: greenAccent.withValues(alpha: 0.1), shape: BoxShape.circle),
                child: const Icon(Icons.check_rounded, color: greenAccent, size: 60),
              ),
              const SizedBox(height: 30),
              const Text('Spot Reserved!', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900)),
              const SizedBox(height: 10),
              Text('Your reservation for $game is confirmed.', style: const TextStyle(color: Colors.white38, fontSize: 14), textAlign: TextAlign.center),
              const SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 20, offset: const Offset(0, 10))
                  ]
                ),
                child: Column(
                  children: [
                    _receiptRow('Player Name', player),
                    _receiptRow('Match', game),
                    _receiptRow('Reservation Fee', '$fee cr', valColor: goldColor),
                    _receiptRow('Payment Method', method, valColor: goldColor),
                    const Divider(color: Colors.white10, height: 40),
                    _receiptRow('Previous Balance', '$prevBalance cr'),
                    _receiptRow('Updated Balance', '$newBalance cr', isBold: true, valColor: greenAccent),
                  ],
                ),
              ),
              const SizedBox(height: 80),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: goldColor,
                  minimumSize: const Size(double.infinity, 65),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('BACK TO GAMES', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, letterSpacing: 2)),
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
