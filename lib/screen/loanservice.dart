import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoanServicesScreen extends StatelessWidget {
  const LoanServicesScreen({super.key});

  final List<Map<String, String>> loanTypes = const [
    {
      'title': 'Personal Loan',
      'subtitle': 'Quick funds for your needs with\n flexible repayment options.',
      'icon': 'assets/personalloan.png',
    },
    {
      'title': 'Business Loan',
      'subtitle': 'Quick funds for your needs with\n flexible repayment options.',
      'icon': 'assets/bunaiseloan.png',
    },
    {
      'title': 'Education Loan',
      'subtitle': 'Quick funds for your needs with\n flexible repayment options.',
      'icon': 'assets/educationloan.png',
    },
    {
      'title': 'Car Loan',
      'subtitle': 'Quick funds for your needs with \nflexible repayment options.',
      'icon': 'assets/carloan.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 232, 243, 235),
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Loan Services',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 232, 243, 235),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: loanTypes.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = loanTypes[index];
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Image.asset(item['icon']!, width: 40, height: 40),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['title']!,
                          style:GoogleFonts.inter(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(item['subtitle']!,
                       style:GoogleFonts.inter(
                        color: Colors.black,
                               fontSize: 14)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
