import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/home_page.dart';

class GasBillPage extends StatelessWidget {
  final String accountNumber;

  GasBillPage({required this.accountNumber});

  final Color buttonColor = const Color.fromARGB(255, 68, 128, 106);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 375; // base width used for scaling

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 232, 243, 235),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with back button and title
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16 * scale, vertical: 10 * scale),
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
                        "Bharat Gas",
                        style: GoogleFonts.inter(
                          fontSize: 20 * scale,
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
                  elevation: 4,
                  color: Colors.white,
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
                              'assets/bhgas.png',
                              height: 40 * scale,
                            ),
                            SizedBox(width: 10 * scale),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bharat Gas',
                                  style: GoogleFonts.inter(
                                    fontSize: 17 * scale,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(accountNumber,
                                    style:
                                        GoogleFonts.inter(fontSize: 13 * scale)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20 * scale),
                        Text(
                          'Billing Details',
                          style: GoogleFonts.inter(
                              fontSize: 16 * scale,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
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

              // Pay Button
               Padding(
                padding: EdgeInsets.all(16.0 * scale),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierColor: Colors.black.withOpacity(0.3),
                      builder: (ctx) {
                        return Center(
                          child: Dialog(
                            backgroundColor: Colors.transparent,
                            insetPadding: EdgeInsets.all(20 * scale),
                            child: Container(
                              constraints: BoxConstraints(
                                 minHeight: 350 * scale,
                           maxHeight: 350 * scale,
                           minWidth: 300 * scale,
                           maxWidth: 300 * scale,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20 * scale),
                              ),
                              padding: EdgeInsets.all(24 * scale),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Payment Successful',
                                    style: GoogleFonts.inter(
                                      fontSize: 16 * scale,
                                      fontWeight: FontWeight.bold,
                                      color:const Color.fromARGB(
                                                  255, 68, 128, 106),
                                    ),
                                  ),
                                  SizedBox(height: 12 * scale),
                                  Text(
                                    'Your payment has been\nsuccessfully processed.',
                                    style:GoogleFonts.inter(
                                      fontSize: 12 * scale,
                                      color: Colors.black,
                                    ),
                                  ),

                                  SizedBox(height: 16 * scale),

                                  // Image below the text
                                  Center(
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(12 * scale),
                                      child: Image.asset(
                                        'assets/done.png',
                                        // height: 105 * scale,
                                        // width: 110 * scale,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),

                                  const Spacer(),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                    ElevatedButton(
  onPressed: () {
    Navigator.of(ctx).pop(); // Close dialog
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => HomePage()), // Replace with actual home page widget
      (route) => false,
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 68, 128, 106),
    foregroundColor: Colors.black,
    padding: EdgeInsets.symmetric(
      horizontal: 30 * scale,
      vertical: 4 * scale,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16 * scale),
      side: const BorderSide(
        color: Color.fromARGB(255, 68, 128, 106),
      ),
    ),
  ),
  child: Text(
    'OK',
    style: GoogleFonts.inter(
      color: Colors.white,
      fontSize: 18 * scale,
      fontWeight: FontWeight.bold,
    ),
  ),
),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
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

  Widget _infoLabel(String text, double scale) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6 * scale),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 11 * scale,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _infoValue(String text, double scale) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6 * scale),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 11 * scale,
        ),
      ),
    );
  }
}
