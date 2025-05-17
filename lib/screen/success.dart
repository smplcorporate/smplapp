import 'package:flutter/material.dart';
import 'package:home/screen/home_page.dart';

void main() {
  runApp(BankBalanceApp());
}

class BankBalanceApp extends StatelessWidget {
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
  double _balance = 0;

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Image.asset(
            'assets/done.png', // ✅ Path must match pubspec.yaml
            width: 180,
            height: 180,
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Bank balance fetched successfully",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance, color: Colors.blue),
            SizedBox(width: 5),
            Text("State Bank of India", style: TextStyle(fontSize: 14)),
          ],
        ),
        SizedBox(height: 10),
        Text(
          "₹${_balance.toStringAsFixed(2)}",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 250),
        ElevatedButton(
          onPressed: () {
            // Navigate to a new screen when Done button is pressed
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()), // HomeScreen is the new screen
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[400],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60),
            ),
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          ),
          child: Text("Done", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}


