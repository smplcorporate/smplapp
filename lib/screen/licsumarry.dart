import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/home_page.dart';
import 'package:home/screen/lic%20insurance.dart';

class BillingSummaryPage extends StatelessWidget {
  final String accountNumber;

  BillingSummaryPage({required this.accountNumber});

  final Color buttonColor = const Color.fromARGB(255, 68, 128, 106);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 375;

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 232, 243, 235),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 10 * scale),
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
                          child: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20 * scale),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "BILL Summary",
                        style: GoogleFonts.inter(
                          fontSize: 18 * scale,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Billing Card
              Padding(
                padding: EdgeInsets.all(16 * scale),
                child: Card(
                  elevation: 4,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12 * scale),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16 * scale),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header row with icon and account
                        Row(
                          children: [
                            Image.asset('assets/lic.png', height: 40 * scale),
                            SizedBox(width: 10 * scale),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'LIC Life Insurance',
                                    style: GoogleFonts.inter(
                                      fontSize: 15 * scale,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(accountNumber, style: GoogleFonts.inter(fontSize: 12 * scale)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20 * scale),

                        Text(
                          'Billing Details',
                          style: GoogleFonts.inter(
                            fontSize: 15 * scale,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10 * scale),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _labelText('Customer Name', scale),
                                _labelText('Bill Number', scale),
                                _labelText('Bill Date', scale),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _valueText('Shreya Goyal', scale),
                                _valueText('23876549-tdgklkmh', scale),
                                _valueText('12-04-2024', scale),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20 * scale),

                        // Amount Box
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 12 * scale),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 232, 243, 235),
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10 * scale),
                          ),
                          child: Center(
                            child: Text(
                              '₹2100',
                              style: TextStyle(
                                fontSize: 22 * scale,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
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
                                  MaterialPageRoute(builder: (_) => LoanAccountScreen()),
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

  Widget _labelText(String text, double scale) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6 * scale),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 11 * scale,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _valueText(String text, double scale) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6 * scale),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 11 * scale,
          color: Colors.black,
        ),
      ),
    );
  }
}
