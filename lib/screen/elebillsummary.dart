import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/config/sizes.dart';

class elebillsum extends StatelessWidget {
  final String accountNumber;

  elebillsum({required this.accountNumber});

  final Color buttonColor =  Color.fromARGB(255, 68, 128, 106);

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
              // Centered title with back button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: 40,width: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(Icons.arrow_back_ios_new, color: Colors.black,size: 21,),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "BILL Summary",
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
                              'assets/elect.png',
                              height: 40,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'JVVNL Bill Payment',
                                style: GoogleFonts.inter(fontSize: 16, color: Colors.black,fontWeight: FontWeight.bold)
                                ),
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
                                Text('Customer Name',style: GoogleFonts.inter(fontSize: 11, color: Colors.black,fontWeight: FontWeight.bold)),SizedBox(height: 5,),
                                Text('Bill Number',style: GoogleFonts.inter(fontSize: 11, color: Colors.black,fontWeight: FontWeight.bold)),SizedBox(height: 5,),
                                Text('Bill Date',style: GoogleFonts.inter(fontSize: 11, color: Colors.black,fontWeight: FontWeight.bold)),SizedBox(height: 5,),
                              ],
                            ),
                            SizedBox(height: 5,),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Shreya Goyal'),SizedBox(height: 5,),
                                Text('23876549-tdgklkmh'),SizedBox(height: 5,),
                                Text('12-04-2024'),SizedBox(height: 5,),
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
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration.collapsed(hintText: '₹1600'),
                              style: GoogleFonts.inter(fontSize:25, ),
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
                   style: GoogleFonts.inter(fontSize:22, color: Colors.white,)
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
