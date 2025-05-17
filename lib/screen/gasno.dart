import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/gasbill.dart';
import 'package:home/screen/licsumarry.dart'; // Make sure this file and class exist

class GasNumberScreen extends StatefulWidget {
  const GasNumberScreen({super.key, required String providerName});

  @override
  State<GasNumberScreen> createState() => _GasNumberScreenState();
}

class _GasNumberScreenState extends State<GasNumberScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isValid = false;

  void _validateInput(String input) {
    setState(() {
      _isValid = RegExp(r'^[0-9]{10}$').hasMatch(input); // Only 10 digits allowed
    });
  }

  void _submitAccount() {
    if (_isValid) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GasBillPage(accountNumber: _controller.text),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text("Please enter a valid 10-digit contact number."),
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
                        Navigator.pop(context);
                      },
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
                      " Bharat Gas ",
                      style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Registered Contact Number",   style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),),
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
                      keyboardType: TextInputType.number,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Please enter a valid 10-digit contact number",
                style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            const SizedBox(height: 10),
            if (!_isValid && _controller.text.isNotEmpty)
              const Text(
                "Please enter a valid 10-digit number",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: _submitAccount,
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Color.fromARGB(255, 68, 128, 106),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Text("Confirm", style: GoogleFonts.inter(fontSize: 23, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
