import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:home/screen/home_page.dart';
import 'package:home/screen/rechargebill.dart';
import 'package:home/screen/screen2.dart';

class RechargePage3 extends StatelessWidget {
  RechargePage3({Key? key}) : super(key: key);

  final Color buttonColor = const Color.fromARGB(255, 68, 128, 106);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 375;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 232, 243, 235),
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 12 * scale, top: 8 * scale, bottom: 8 * scale),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4 * scale)],
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20 * scale),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 6 * scale),
          child: Text(
            'Recharge Bill',
            style: GoogleFonts.inter(
              fontSize: 18 * scale,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0 * scale),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 16 * scale),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12 * scale),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8 * scale,
                        offset: Offset(0, 4 * scale),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "₹199",
                        style: GoogleFonts.inter(
                          fontSize: 23 * scale,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8 * scale),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Data: 1.5GB/day",
                            style: GoogleFonts.inter(
                              fontSize: 12 * scale,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "validity: 28 Days",
                            style: GoogleFonts.inter(
                              fontSize: 12 * scale,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8 * scale),
                      Text(
                        "Voice: Unlimited",
                        style: GoogleFonts.inter(fontSize: 12 * scale, color: Colors.grey),
                      ),
                      SizedBox(height: 12 * scale),
                      Text(
                        "Don't miss. Recharge with ₹199 Plan to get 20% upto Rs. 200 cashback from Jio Music.",
                        style: GoogleFonts.inter(fontSize: 12 * scale, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Your payment has been successfully processed.',
                              style: GoogleFonts.inter(),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16 * scale),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height: 36 * scale,
                                  width: 120 * scale,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (_) => TransactionPage()),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: buttonColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Text(
                                      'View Transaction',
                                      style: GoogleFonts.inter(
                                        fontSize: 12 * scale,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 36 * scale,
                                  width: 120 * scale,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (_) => RechargeBillPage()),
                                        (route) => false,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: buttonColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Text(
                                      'Go to Services',
                                      style: GoogleFonts.inter(
                                        fontSize: 12 * scale,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
    );
  }
}
