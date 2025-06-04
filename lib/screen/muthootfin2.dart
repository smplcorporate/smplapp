import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/home_page.dart';
import 'package:home/screen/lender2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MuthootSummaryPage(accountNumber: 'ACC123456789'),
    );
  }
}

class MuthootSummaryPage extends StatelessWidget {
  final String accountNumber;
  final Color buttonColor = const Color.fromARGB(255, 68, 128, 106);

  MuthootSummaryPage({required this.accountNumber});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 375;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 232, 243, 235),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.0 * scale, vertical: 20 * scale),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(8 * scale),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(Icons.arrow_back_ios_new,
                              color: Colors.black, size: 18 * scale),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Muthoot Finance",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 18 * scale,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Billing Card
              Padding(
                padding: EdgeInsets.all(16.0 * scale),
                child: Card(
                  color: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12 * scale),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0 * scale),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image + Name
                        Row(
                          children: [
                            Image.asset(
                              'assets/mutooth.png',
                              height: 40 * scale,
                            ),
                            SizedBox(width: 10 * scale),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Muthoot Finance',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15 * scale,
                                  ),
                                ),
                                Text(accountNumber,
                                    style: GoogleFonts.inter(
                                        fontSize: 13 * scale)),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 20 * scale),

                        Text(
                          'Billing Details',
                          style: GoogleFonts.inter(
                            fontSize: 15 * scale,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        SizedBox(height: 10 * scale),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _infoLabel("Customer Name", scale),
                                _infoLabel("Bill Number", scale),
                                _infoLabel("Bill Date", scale),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _infoValue("Shreya Goyal", scale),
                                _infoValue("23876549-tdgklkmh", scale),
                                _infoValue("12-04-2024", scale),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 20 * scale),

                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 12 * scale),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 232, 243, 235),
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10 * scale),
                          ),
                          child: Center(
                            child: TextField(
                              controller: TextEditingController(text: '₹2100'),
                              readOnly: true,
                              showCursor: false,
                              style: TextStyle(
                                fontSize: 22 * scale,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.none,
                              decoration:
                                  const InputDecoration.collapsed(hintText: ''),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Proceed to Pay Button
             
             Padding(
                padding: EdgeInsets.all(16.0 * scale),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          title: Text(
                            'Payment Successful',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              // color: const Color.fromARGB(255, 68, 128, 106),
                            ),
                          ),
                          content: Text(
                            'Your payment has been successfully processed.',
                            style: GoogleFonts.inter(),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (_) => LenderSelectionScreen()),
                                  (route) => false,
                                );
                              },
                              child: Text(
                                'OK',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  // color: const Color.fromARGB(255, 68, 128, 106),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25 * scale),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14 * scale),
                    minimumSize: Size(double.infinity, 45 * scale),
                  ),
                  child: Text(
                    'Proceed to pay',
                    style: GoogleFonts.inter(
                      fontSize: 18 * scale,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoLabel(String label, double scale) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6 * scale),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.bold,
          fontSize: 11 * scale,
        ),
      ),
    );
  }

  Widget _infoValue(String value, double scale) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6 * scale),
      child: Text(
        value,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 11 * scale,
        ),
      ),
    );
  }
}
