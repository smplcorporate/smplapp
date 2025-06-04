import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/config/sizes.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 375; // Base width for scaling

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      body: SafeArea(
        child: Column(
          children: [
            // Header with steps
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 20 * scale),
              width: double.infinity,
              color: const Color.fromARGB(255, 232, 243, 235),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 40 * scale,
                          height: 40 * scale,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios_new, size: 20 * scale),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Open Bank Account',
                          style: GoogleFonts.inter(
                            fontSize: 18 * scale,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30 * scale),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      stepCircle(1, scale),
                      stepCircle(2, scale),
                      stepCircle(3, scale),
                      stepCircle(4, scale),
                    ],
                  ),
                ],
              ),
            ),

            // Main content with scroll support
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 10 * scale),
                child: Container(
                  margin: EdgeInsets.only(top: 20 * scale, bottom: 20 * scale),
                  padding: EdgeInsets.all(12 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12 * scale),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 6 * scale,
                        spreadRadius: 2 * scale,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/ok1.png',
                        width: 200 * scale,
                        height: 250 * scale,
                      ),
                      SizedBox(height: 20 * scale),
                      Text(
                        'Account Open Request Received',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 18 * scale,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10 * scale),
                      Text(
                        'Congratulations User! Your account with Your Bank is \nnow active',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 13 * scale,
                          color: const Color.fromARGB(255, 134, 134, 134),
                        ),
                      ),
                      SizedBox(height: 60 * scale), // Reduced to make room on small screens
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 30 * scale, vertical: 12 * scale),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25 * scale),
                          ),
                          elevation: 5,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        child: Text(
                          'Go to home',
                          style: GoogleFonts.inter(
                            fontSize: 16 * scale,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height:height,)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget stepCircle(int stepNumber, double scale) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 68, 128, 106),
          radius: 14 * scale,
          child: Text(
            '$stepNumber',
            style: TextStyle(fontSize: 12 * scale, color: Colors.white),
          ),
        ),
        SizedBox(height: 4 * scale),
        Text('Step $stepNumber', style: TextStyle(fontSize: 10 * scale)),
      ],
    );
  }
}
