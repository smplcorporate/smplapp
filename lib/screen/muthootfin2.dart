import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/config/sizes.dart';

class MuthootSummaryPage extends StatelessWidget {
  final String accountNumber;

  MuthootSummaryPage({required this.accountNumber});

  final Color buttonColor = Color.fromARGB(255, 68, 128, 106);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 232, 243, 235),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back arrow and title (moved down)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20), // Increase the vertical padding here
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                      ),
                    ),
                    SizedBox(width: 10),
                    Center(
                      child: Text(
                        "Muthoot Finance",
                      style:GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 20)
                      ),
                    ),
                  ],
                ),
              ),

              // Card with billing details
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/mutooth.png',
                              height: 40,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Muthoot Finance', style:GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 17)),
                                Text(accountNumber),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                            Text(
                          'Billing Details',
                             style: GoogleFonts.inter(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Customer Name',           style:GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 11)),SizedBox(height: 5,),
                                Text('Bill Number',           style:GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 11)),SizedBox(height: 5,),
                                Text('Bill Date', style:GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 11)),SizedBox(height: 5,),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Shreya Goyal', style:GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 11)),SizedBox(height: 5,),
                                Text('23876549-tdgklkmh', style:GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 11)),SizedBox(height: 5,),
                                Text('12-04-2024', style:GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 11)),SizedBox(height: 5,),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: TextField(
                              decoration: InputDecoration.collapsed(hintText: '₹3100'),
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
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
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Payment Successful'),
                        content: const Text('Your payment has been successfully processed.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: const Text('OK'),
                          )
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  child: Text(
                    'Proceed to pay',
                    style: GoogleFonts.inter(fontSize: 22, color:Colors.white,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
