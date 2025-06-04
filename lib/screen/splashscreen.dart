import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/sinupui.dart';


class PaymentIntroScreen extends StatefulWidget {
  @override
  _PaymentIntroScreenState createState() => _PaymentIntroScreenState();
}

class _PaymentIntroScreenState extends State<PaymentIntroScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  bool isTimerCompleted = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();

    // Timer that completes after 5 seconds
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        isTimerCompleted = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Decorative background circles
          Positioned(top: 180, left: 30, child: Circle(color: const Color.fromARGB(255, 68, 128, 106), size: 20)),
          Positioned(top: 200, left: -40, child: Circle(color: const Color.fromARGB(255, 68, 128, 106), size: 80)),
          Positioned(top: 350, left: 45, child: Circle(color: const Color.fromARGB(255, 68, 128, 106), size: 14)),
          Positioned(top: 400, left: 180, child: Circle(color: const Color.fromARGB(255, 68, 128, 106), size: 14)),
          Positioned(top: 220, right: 90, child: Circle(color: const Color.fromARGB(255, 68, 128, 106), size: 14)),
          Positioned(bottom: 400, right: -30, child: Circle(color: const Color.fromARGB(255, 68, 128, 106), size: 80)),
          Positioned(bottom: 460, right: 50, child: Circle(color: const Color.fromARGB(255, 68, 128, 106), size: 15)),

          // Main content
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/group.png',
                        height: 260,
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  Text(
                    "Pay Smart. Live Easy.",
                    style: GoogleFonts.inter(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
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
          ),

          // Success image animation inside a circular container
          Positioned(
            right: 0,
            top: 20,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent, // Keeps the background transparent
                      image: DecorationImage(
                        image: AssetImage('assets/success3.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Get Started Button
          Positioned(
            bottom: 40,
            left: 30,
            right: 30,
            child: ElevatedButton(
              onPressed: isTimerCompleted
                  ? () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => OnboardingScreen()),
                      );
                    }
                  : null, // Disabled until timer is done
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text(
                "Get Started",
                style: TextStyle(
                  color: isTimerCompleted ? Colors.white : Colors.white.withOpacity(0.6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Circle Widget
class Circle extends StatelessWidget {
  final Color color;
  final double size;

  const Circle({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
