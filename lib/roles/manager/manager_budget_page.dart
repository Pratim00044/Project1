import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF1A1A1A);
const Color accentBlue = Color(0xFF007CFE);
const Color accentGreen = Color(0xFF38EF7D);
const Color accentRed = Color(0xFFF12711);

class ManagerBudgetPage extends StatelessWidget {
  const ManagerBudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: goldColor.withOpacity(0.05),
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                _buildNewHeader(context),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        _buildHeroBalance(),
                        const SizedBox(height: 30),
                        _buildQuickStatsRow(),
                        const SizedBox(height: 40),
                        _buildSectionLabel('BUDGET ALLOCATION'),
                        const SizedBox(height: 15),
                        _buildAllocationScroll(),
                        const SizedBox(height: 40),
                        _buildSectionHeader('RECENT ACTIVITY', 'VIEW ALL'),
                        const SizedBox(height: 15),
                        _buildModernTransactionList(),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Positioned(
            bottom: 30,
            right: 25,
            child: _buildFloatingAction(),
          ),
        ],
      ),
    );
  }

  Widget _buildNewHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
            ),
          ),
          const Column(
            children: [
              Text('TREASURY', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
              Text('FISCAL YEAR 24', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: const Icon(Icons.insights_rounded, color: goldColor, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroBalance() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(35),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1C1C1C), Color(0xFF0D0D0D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(45),
        border: Border.all(color: goldColor.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20, offset: const Offset(0, 10))
        ],
      ),
      child: Column(
        children: [
          const Text('CURRENT LIQUIDITY', style: TextStyle(color: goldColor, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
          const SizedBox(height: 15),
          const Text('₹4,20,000', 
            style: TextStyle(
              color: Colors.white, 
              fontSize: 52, 
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
            )
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: accentGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.trending_up_rounded, color: accentGreen, size: 14),
                SizedBox(width: 5),
                Text('+12.5% vs last month', style: TextStyle(color: accentGreen, fontSize: 10, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatsRow() {
    return Row(
      children: [
        _buildStatCard('INFLOW', '₹5.2L', accentGreen),
        const SizedBox(width: 15),
        _buildStatCard('OUTFLOW', '₹1.0L', accentRed),
      ],
    );
  }

  Widget _buildStatCard(String label, String val, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white.withOpacity(0.03)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
            const SizedBox(height: 8),
            Text(val, style: TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(text, style: const TextStyle(color: Colors.white24, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5));
  }

  Widget _buildSectionHeader(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.white24, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
        Text(action, style: const TextStyle(color: goldColor, fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildAllocationScroll() {
    final categories = [
      {'name': 'KITS', 'icon': Icons.sports_soccer, 'amount': '₹45k', 'color': accentBlue},
      {'name': 'TRAVEL', 'icon': Icons.directions_bus_rounded, 'amount': '₹12k', 'color': Colors.purpleAccent},
      {'name': 'STAFF', 'icon': Icons.badge_rounded, 'amount': '₹1.2L', 'color': Colors.orangeAccent},
      {'name': 'ACADEMY', 'icon': Icons.school_rounded, 'amount': '₹85k', 'color': accentGreen},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: categories.map((cat) => Container(
          width: 120,
          margin: const EdgeInsets.only(right: 15),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: (cat['color'] as Color).withOpacity(0.2)),
          ),
          child: Column(
            children: [
              Icon(cat['icon'] as IconData, color: cat['color'] as Color, size: 28),
              const SizedBox(height: 15),
              Text(cat['name'] as String, style: const TextStyle(color: Colors.white38, fontSize: 9, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(cat['amount'] as String, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900)),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildModernTransactionList() {
    return Column(
      children: [
        _buildModernTxItem('EMIRATES SPONSOR', '+ ₹2.5L', true, 'Inflow', '02 JUL'),
        _buildModernTxItem('KIT PROCUREMENT', '- ₹45k', false, 'Equipment', '30 JUN'),
        _buildModernTxItem('ACADEMY FEES', '+ ₹85k', true, 'Registration', '25 JUN'),
        _buildModernTxItem('GROUND RENT', '- ₹22k', false, 'Operations', '22 JUN'),
      ],
    );
  }

  Widget _buildModernTxItem(String title, String amount, bool isIncome, String category, String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: surfaceColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.02)),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isIncome ? accentGreen.withOpacity(0.05) : accentRed.withOpacity(0.05),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              isIncome ? Icons.add_chart_rounded : Icons.pie_chart_outline_rounded,
              color: isIncome ? accentGreen : accentRed,
              size: 24,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('$category • $date', style: const TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Text(amount, 
            style: TextStyle(
              color: isIncome ? accentGreen : Colors.white, 
              fontSize: 15, 
              fontWeight: FontWeight.w900
            )
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingAction() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: goldColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: goldColor.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))
        ],
      ),
      child: const Icon(Icons.add_rounded, color: Colors.black, size: 32),
    );
  }
}
