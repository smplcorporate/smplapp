import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GasBillPage extends StatelessWidget {
  final String accountNumber;

  GasBillPage({required this.accountNumber});

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
              // Centered title using Stack
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
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                      " Bharat Gas ",
                      style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    ),
                  ],
                ),
              ),

              // Billing card
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
                              'assets/bhgas.png',
                              height: 40,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Bharat Gas ', style:GoogleFonts.inter( fontSize: 17,  fontWeight: FontWeight.bold)),
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
                          children: const [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Customer Name'),    SizedBox(height: 5,),
                                Text('Bill Number'),    SizedBox(height: 5,),
                                Text('Bill Date'),    SizedBox(height: 5,),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Shreya Goyal'),    SizedBox(height: 5,),
                                Text('23876549-tdgklkmh'),    SizedBox(height: 5,),
                                Text('12-04-2024'),    SizedBox(height: 5,),
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
                              decoration: InputDecoration.collapsed(hintText: '₹900'),
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
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Proceed to pay',
                    style: TextStyle(fontSize: 18, color: Color.fromARGB(249, 240, 236, 236)),
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
