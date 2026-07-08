import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class ManagerBudgetPage extends StatelessWidget {
  const ManagerBudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('FINANCIAL OVERVIEW',
                          style: TextStyle(
                              color: goldColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2)),
                      Container(margin: const EdgeInsets.only(top: 4), height: 2, width: 140, color: goldColor.withOpacity(0.3)),
                    ],
                  ),
                  const SizedBox(height: 35),
                  _buildMainBalanceCard(),
                  const SizedBox(height: 50),
                  Container(height: 1, width: double.infinity, color: goldColor.withOpacity(0.2)),
                  const SizedBox(height: 50),
                  ... [
                    _buildTransactionItem('Sponsorship - Emirates', '+ ₹2.5L', true, '02 Jul'),
                    _buildTransactionItem('Kit Procurement', '- ₹45k', false, '30 Jun'),
                    _buildTransactionItem('Travel Expenses', '- ₹12k', false, '28 Jun'),
                    _buildTransactionItem('Academy Fees', '+ ₹85k', true, '25 Jun'),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(35),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(45),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('AVAILABLE BUDGET',
                          style: TextStyle(color: Colors.white60, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1)),
                      Container(height: 1, width: 100, color: Colors.white24, margin: const EdgeInsets.only(top: 2)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Column(
                    children: [
                      Text('₹4,20,000',
                          style: TextStyle(color: Colors.white, fontSize: 38, fontWeight: FontWeight.w900, decoration: TextDecoration.underline, decorationColor: Colors.white24)),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: goldColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(Icons.account_balance_wallet, color: goldColor, size: 34),
              ),
            ],
          ),
          const SizedBox(height: 45),
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCompactStat('INCOME', '₹5.2L', Colors.greenAccent),
                Container(width: 1, height: 40, color: Colors.white.withOpacity(0.05)),
                _buildCompactStat('EXPENSES', '₹1.0L', Colors.redAccent),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactStat(String label, String val, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
            Container(height: 1, width: 30, color: Colors.white10),
          ],
        ),
        const SizedBox(height: 8),
        Text(val, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.w900, decoration: TextDecoration.underline, decorationColor: color.withOpacity(0.3))),
      ],
    );
  }

  Widget _buildTransactionItem(String title, String amount, bool isIncome, String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isIncome ? Colors.green.withOpacity(0.05) : Colors.red.withOpacity(0.05),
            radius: 25,
            child: Icon(
              isIncome ? Icons.arrow_downward : Icons.arrow_upward,
              color: isIncome ? Colors.green.withOpacity(0.6) : Colors.red.withOpacity(0.6),
              size: 22,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, decorationColor: Colors.white12)),
                    Text(date, style: const TextStyle(color: Colors.white24, fontSize: 12, decoration: TextDecoration.underline, decorationColor: Colors.white10)),
                  ],
                ),
              ],
            ),
          ),
          Text(amount,
              style: TextStyle(
                  color: isIncome ? Colors.greenAccent : Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  decoration: TextDecoration.underline,
                  decorationColor: isIncome ? Colors.greenAccent.withOpacity(0.3) : Colors.white24)),
        ],
      ),
    );
  }
}
