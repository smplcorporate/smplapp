import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/muthootfin2.dart'; // Ensure this file exists

class MuthootFinScreen extends StatefulWidget {
  final String billerName;
  final String billerCode;
  const MuthootFinScreen({super.key, required String circleCode, required this.billerName, required this.billerCode});

  @override
  State<MuthootFinScreen> createState() => _MuthootFinScreenState();
}

class _MuthootFinScreenState extends State<MuthootFinScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isValid = false;

  void _validateInput(String input) {
    setState(() {
      _isValid = RegExp(r'^[a-zA-Z0-9]{12}$').hasMatch(input);
    });
  }

  void _submitAccount() {
    if (_isValid) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MuthootSummaryPage(accountNumber: _controller.text, billerCode: '${widget.billerCode}', billerName: '${widget.billerName}',),
        ),
      );
    } else {
      // Using light dim color instead of black overlay
      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: "Dismiss",
        barrierColor: const Color.fromARGB(180, 232, 243, 235), // light greenish dim
        pageBuilder: (_, __, ___) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text("Please enter a valid 12 digit number."),
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
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      body: SafeArea(
        child: Column(
          children: [
            // Header with back and title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                      widget.billerName,
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

            // Form content in scrollable area
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Loan Number",
                        style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: _isValid || _controller.text.isEmpty
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Please enter a valid 12 digit number",
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (!_isValid && _controller.text.isNotEmpty)
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Please enter a valid 12-digit number",
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),

            // Confirm button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitAccount,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 68, 128, 106),
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
            ),
          ],
        ),
      ),
    );
  }
}
