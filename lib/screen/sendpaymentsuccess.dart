import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/home_page.dart';

void main() {
  runApp(SendPaymentApp());
}

class SendPaymentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BalanceScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BalanceScreen extends StatefulWidget {
  @override
  _BalanceScreenState createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  bool _isFetched = false;
  double _balance = 1640.00;

  @override
  void initState() {
    super.initState();
    fetchBalance();
  }

  Future<void> fetchBalance() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate API delay
    setState(() {
      _isFetched = true;
      _balance = 1640.00;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Center(
        child: _isFetched ? buildSuccessView(context) : CircularProgressIndicator(),
      ),
    );
  }

  Widget buildSuccessView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/done.png',
            width: 180,
            height: 180,
          ),
          SizedBox(height: 20),
          Text(
            "Payment successfully",
            style: GoogleFonts.inter(fontSize: 15,color: const Color.fromARGB(255, 5, 158, 111),
            // fontWeight: FontWeight.bold
            
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/sbi1.png',
                width: 20,
                height: 20,
              ),
              SizedBox(width: 5),
              Text('State Bank of India',style: GoogleFonts.inter(color: Colors.black,fontSize: 13),
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(
            "₹${_balance.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 30), // move button slightly up from bottom
            child: SizedBox(
              width: 350, // wider button
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
                child: Text("Done", style:GoogleFonts.inter(fontSize: 18,color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
