import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/biller.dart';
import 'package:home/screen/home_page.dart';

class EleBillSummary extends StatelessWidget {
  final String accountNumber;

  EleBillSummary({required this.accountNumber});

  final Color buttonColor = const Color.fromARGB(255, 68, 128, 106);

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
                    horizontal: 16.0 * scale, vertical: 10 * scale),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: 40 * scale,
                          width: 40 * scale,
                          padding: EdgeInsets.all(8 * scale),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(Icons.arrow_back_ios_new,
                              color: Colors.black, size: 21 * scale),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "BILL Summary",
                        style: GoogleFonts.inter(
                          fontSize: 16 * scale,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Card with billing details
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
                        Row(
                          children: [
                            Image.asset(
                              'assets/elect.png',
                              height: 40 * scale,
                            ),
                            SizedBox(width: 10 * scale),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'JVVNL Bill Payment',
                                  style: GoogleFonts.inter(
                                    fontSize: 14 * scale,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
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
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10 * scale),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _infoColumn(
                              ["Customer Name", "Bill Number", "Bill Date"],
                              scale,
                            ),
                            _infoColumn(
                              [
                                "Shreya Goyal",
                                "23876549-tdgklkmh",
                                "12-04-2024"
                              ],
                              scale,
                              alignRight: true,
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
                              decoration: const InputDecoration.collapsed(
                                  hintText: ''),
                              style: TextStyle(
                                fontSize: 22 * scale,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Spacer(),

              Padding(
                padding: EdgeInsets.all(16.0 * scale),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Payment Successful',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: Text(
                            'Your payment has been successfully processed.',
                            style: GoogleFonts.inter(),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Biller()),
                                  (route) => false,
                                );
                              },
                              child: Text(
                                'OK',
                                style: GoogleFonts.inter(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
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

  Widget _infoColumn(List<String> items, double scale,
      {bool alignRight = false}) {
    return Column(
      crossAxisAlignment:
          alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: items
          .map((item) => Padding(
                padding: EdgeInsets.only(bottom: 6 * scale),
                child: Text(
                  item,
                  style: GoogleFonts.inter(
                    fontSize: 11 * scale,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ))
          .toList(),
    );
  }
}
