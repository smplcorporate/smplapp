import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(KYCApp());
}

class KYCApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KYC Verification',
      debugShowCheckedModeBanner: false,
      home: KYCVerificationScreen(),
    );
  }
}

class KYCVerificationScreen extends StatelessWidget {
  Widget kycCard({
    required String title,
    required String document,
    required String validity,
    required List<String> benefits,
    required VoidCallback? onTap,
    required bool isCompleted,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        border: Border.all(color: const Color.fromARGB(255, 166, 192, 173)),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and custom button
          Container(
            height: 55,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 212, 238, 219),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 68, 128, 106),
                  ),
                ),
                GestureDetector(
                  onTap: isCompleted ? null : onTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? const Color.fromARGB(255, 236, 250, 242)
                          : const Color.fromARGB(255, 68, 128, 106),
                      border: Border.all(
                        color: const Color.fromARGB(255, 68, 128, 106),
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      isCompleted ? 'Completed' : 'Get Start',
                      style: TextStyle(
                        color: isCompleted
                            ? const Color.fromARGB(255, 68, 128, 106)
                            : Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Required Document:',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    Text(
                      document,
                      style: GoogleFonts.inter(
                          fontSize: 12, color: Colors.black),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Validity:',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    Text(validity),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Benefits:',
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          ...benefits.map(
            (b) => Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 2),
              child: Text(
                '• $b',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: const Color.fromARGB(255, 68, 128, 106),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '* Select to change based on the bank\'s risk categorization',
              style: GoogleFonts.inter(
                fontSize: 11,
                color: const Color.fromARGB(255, 103, 103, 103),
              ),
            ),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 236, 226),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 223, 236, 226),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background container
          Positioned(
            top: screenHeight * 0.25,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            ),
          ),

          // Foreground scrollable content
          ListView(
            padding: const EdgeInsets.only(bottom: 30),
            children: [
              // Title and Image
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        'KYC Verification',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Image.asset(
                      'assets/kyc.png',
                      height: 97,
                      width: 155,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),

              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Verify your identity to unlock services and secure \ndigital transactions. It only takes a few minutes to\n complete.',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inter(
                    color: const Color.fromARGB(255, 130, 130, 130),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // KYC Cards
              kycCard(
                title: 'Mini KYC',
                document: 'Pan Card',
                validity: 'Lifetime',
                benefits: [
                  'Wallet Balance up to ₹10,000',
                  'Pay to merchants',
                ],
                isCompleted: false,
                onTap: () {
                  print('Mini KYC tapped');
                },
              ),
              kycCard(
                title: 'Full KYC',
                document: 'Pan Card',
                validity: 'Lifetime',
                benefits: [
                  'Wallet Balance up to ₹100,000',
                  'Pay to merchants',
                  'Send money to others',
                ],
                isCompleted: true,
                onTap: null,
              ),
              kycCard(
                title: 'Bank KYC',
                document: 'Pan Card',
                validity: 'Lifetime',
                benefits: [
                  'Wallet Balance up to ₹10,000',
                  'Pay to merchants',
                ],
                isCompleted: false,
                onTap: () {
                  print('Bank KYC tapped');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
