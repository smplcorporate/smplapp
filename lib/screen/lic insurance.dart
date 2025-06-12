import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/home_page.dart';
import 'package:home/screen/licsumarry.dart'; // Make sure this file exists and accepts the accountNumber parameter

class LoanAccountScreen extends StatefulWidget {
  const LoanAccountScreen({super.key});

  @override
  State<LoanAccountScreen> createState() => _LoanAccountScreenState();
}

class _LoanAccountScreenState extends State<LoanAccountScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isValid = false;

  void _validateInput(String input) {
    setState(() {
      _isValid = RegExp(
        r'^[a-zA-Z0-9]{12}$',
      ).hasMatch(input); // Updated regex for 12 alphanumeric characters
    });
  }

  void _submitAccount() {
    if (_isValid) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => BillingSummaryPage(
                accountNumber: _controller.text,
              ), // Pass input to next page
        ),
      );
    } else {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text("Invalid Input"),
              content: const Text(
                "Please enter a valid 12-character alphanumeric loan account number.",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("OK"),
                ),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: const Color.fromARGB(255, 232, 243, 235),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    HomePage(), // 🔁 Replace this with your actual destination widget
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "LIC Insurance",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            Text(
              "Loan Account Number",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color:
                      _isValid || _controller.text.isEmpty
                          ? Colors.grey.shade600
                          : Colors.red,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      maxLength: 12,
                      decoration: const InputDecoration(
                        counterText: "",
                        border: InputBorder.none,
                      ),
                      onChanged: _validateInput,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Please enter a valid 12 digit loan number",
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 10),
            if (!_isValid && _controller.text.isNotEmpty)
              const Text(
                "Please enter a valid 12-digit Loan number",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: _submitAccount,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 68, 128, 106),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Confirm",
                  style: GoogleFonts.inter(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
