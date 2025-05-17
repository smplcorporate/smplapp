import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreditCardApplyPage3(),
    );
  }
}

class CreditCardApplyPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 232, 243, 235),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Top section with gradient and steps
            Container(
              
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              width: double.infinity,
              decoration: const BoxDecoration(
        color: const Color.fromARGB(255, 232, 243, 235),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      // Circular back button
                      Container(
                           width: 40,
                          height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, size: 22),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(width: 12, height: 30),
                    Center(
                    child: Text(
                      'Credit Card Apply',
                      style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                    ],
                  ),
                  // const SizedBox(height: 45),

                  // Step Indicators under title
               
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Main content inside a container
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                
                child: Column(
              
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  Image.asset(
                       'assets/ok1.png', // replace with your actual asset path
                          width: 200,
                      height: 200,
                        ),
                    // const SizedBox(height: 10),
                    Text(
                      'Application Submitted!',
                  style: GoogleFonts.inter(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20,),
                    // const SizedBox(height: 10),
                    Text(
                    'Thank you. Your credit card application has \nbeen submitted successfully.\nWe\'ll notify you once your card is approved\n and ready.',
                      textAlign: TextAlign.center,
                     style: GoogleFonts.inter(
                      //  fontWeight: FontWeight.bold, 
                       fontSize: 13,color:Colors.black),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                       style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                           
                            ),
                      onPressed: () {
                        // Navigate to the home screen using Navigator.push
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()), // HomePage is the next page
                        );
                      },
                      child: Container(
                        height: 50,width: 180,decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Text(
                            'Explore More Options',
                                       style: GoogleFonts.inter(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}