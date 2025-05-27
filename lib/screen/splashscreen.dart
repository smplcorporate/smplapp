import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:home/screen/home_page.dart';
import 'package:home/sinupui.dart';

class PaymentIntroScreen extends StatefulWidget {
  @override
  _PaymentIntroScreenState createState() => _PaymentIntroScreenState();
}

class _PaymentIntroScreenState extends State<PaymentIntroScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller for the slide-in animation
    _controller = AnimationController(
      duration: const Duration(seconds: 7),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(1, 0), // Start off-screen to the right
      end: Offset.zero, // End at the center
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Start the animation when the screen is loaded
    _controller.forward();
    final box = Hive.box('userdata');
   final token = box.get('@token');
    // Start splash screen timer to navigate after 5 seconds
    Future.delayed(Duration(seconds: 8), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => token == null?  PaymentApp() : HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when it's not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Decorative background circles
          Positioned(
            top: 180,
            left: 30,
            child: Circle(
              color: const Color.fromARGB(255, 68, 128, 106),
              size: 20,
            ),
          ),
          Positioned(
            top: 200,
            left: -40,
            child: Circle(
              color: const Color.fromARGB(255, 68, 128, 106),
              size: 80,
            ),
          ),
          Positioned(
            top: 350,
            left: 45,
            child: Circle(
              color: const Color.fromARGB(255, 68, 128, 106),
              size: 14,
            ),
          ),
          Positioned(
            top: 480,
            left: 180,
            child: Circle(
              color: const Color.fromARGB(255, 68, 128, 106),
              size: 14,
            ),
          ),
          Positioned(
            top: 280,
            right: 60,
            child: Circle(
              color: const Color.fromARGB(255, 68, 128, 106),
              size: 14,
            ),
          ),
          Positioned(
            bottom: 390,
            right: -30,
            child: Circle(
              color: const Color.fromARGB(255, 68, 128, 106),
              size: 80,
            ),
          ),
          Positioned(
            bottom: 470,
            right: 50,
            child: Circle(
              color: const Color.fromARGB(255, 68, 128, 106),
              size: 15,
            ),
          ),

          // Main content with nested circles behind image
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(height: 70),
                    Image.asset('assets/group.png', height: 350),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  "Pay Smart. Live Easy.",
                  style: GoogleFonts.inter(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Experience effortless payments with speed,\nsecurity, and peace of mind — anytime,\nanywhere.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(color: Colors.black, fontSize: 15),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),

          // Success image animation
          Positioned(
            right: 0,
            top: 40,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return SlideTransition(
                  position: _slideAnimation,
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/success.png',
                          width: 300,
                          height: 300,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom Elevated Button
          // Positioned(
          //   bottom: 40, // Position button 40px from the bottom
          //   left: 30,  // Center the button horizontally
          //   right: 30,
          //   child: ElevatedButton(
          //     onPressed: () {
          //       // Define what happens when the button is pressed
          //       print("Button Pressed!");
          //     },
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: const Color.fromARGB(255, 68, 128, 106),  // Set background color to black
          //       padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 20), // Vertical padding
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(25), // Rounded corners
          //       ),
          //       textStyle: const TextStyle(
          //         fontSize: 18, // Text size
          //         fontWeight: FontWeight.bold, // Text bold
          //       ),
          //     ),
          //     child: const Text(
          //       "Get Started", // Text on the button
          //       style: TextStyle(color: Colors.white), // Text color white
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

// Circle widget
class Circle extends StatelessWidget {
  final Color color;
  final double size;

  const Circle({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

// Next Screen (After Splash)
