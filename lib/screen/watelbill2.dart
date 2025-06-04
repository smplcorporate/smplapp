import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/elebillsummary.dart';
import 'package:home/screen/waterbill3.dart';


class WaterBill2 extends StatefulWidget {
  const WaterBill2({super.key});

  @override
  State<WaterBill2> createState() => _WaterBill2State();
}

class _WaterBill2State extends State<WaterBill2> {
  final TextEditingController _controller = TextEditingController();
  bool _isValid = true; // Start as true to avoid red border initially
  String? _errorText;

  void _validateInput(String input) {
    final isValidCID = RegExp(r'^[a-zA-Z0-9]{10}$').hasMatch(input);
    setState(() {
      _isValid = isValidCID;
      _errorText = isValidCID ? null : "Please enter a valid 10-character CID code";
    });
  }

  void _submitAccount() {
    final cidCode = _controller.text.trim();
    if (RegExp(r'^[a-zA-Z0-9]{10}$').hasMatch(cidCode)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WaterBill3(accountNumber: cidCode),
        ),
      );
    } else {
      setState(() {
        _isValid = false;
        _errorText = "Please enter a valid 10-character CID code";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 232, 243, 235),
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
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 40,
                        width: 40,
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                          size: 21,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "PHED - Rajasthan",
                      style: GoogleFonts.inter(
                        fontSize: 15,
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
              "CID Code",
              style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: _isValid ? Colors.grey.shade600 : Colors.red,
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
                      maxLength: 10,
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
              "Please enter a valid 10-character CID code",
              style: TextStyle(
                color: _isValid ? Colors.black : Colors.red,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 60,
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
          ],
        ),
      ),
    );
  }
}
