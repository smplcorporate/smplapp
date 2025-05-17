import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AccountOpenConfirmation5(),
    );
  }
}

class AccountOpenConfirmation5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 232, 243, 235),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(width: 12, height: 10),
                    Center(
                    child: Text(
                      'Open Bank Account',
                      style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                    ],
                  ),
                  const SizedBox(height: 45),

                  // Step Indicators under title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      stepCircle(1),
                      stepCircle(2),
                      stepCircle(3),
                      stepCircle(4),
                    ],
                  ),
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
  height: 250,
),
                    // const SizedBox(height: 10),
                    Text(
                      'Account Open Request Received',
                  style: GoogleFonts.inter(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Congratulations User! Your account with Your Bank is \nnow active',
                      textAlign: TextAlign.center,
                     style: GoogleFonts.inter(fontSize: 13,color: const Color.fromARGB(255, 134, 134, 134)),
                    ),
                    const SizedBox(height: 100),
                    ElevatedButton(
                       style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              elevation: 5,
                            ),
                      onPressed: () {
                        // Navigate to the home screen using Navigator.push
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()), // HomePage is the next page
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          'Go to home',
             style: GoogleFonts.inter(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
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

  Widget stepCircle(int stepNumber) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor:Color.fromARGB(255, 68, 128, 106),
          radius: 14,
          child: Text(
            '$stepNumber',
            style: const TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
        const SizedBox(height: 4),
        Text('Step $stepNumber', style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}

// HomePage Widget: This is the screen you navigate to when the "Go to home" button is pressed

