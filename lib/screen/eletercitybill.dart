import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/licsumarry.dart';
import 'package:home/screen/elebillsummary.dart';
 // Make sure this file exists

class Eletercitybill extends StatefulWidget {
  const Eletercitybill({super.key});

  @override
  State<Eletercitybill> createState() => _LoanAccountScreenState();
}

class _LoanAccountScreenState extends State<Eletercitybill> {
  final TextEditingController _controller = TextEditingController();
  bool _isValid = false;

  void _validateInput(String input) {
    setState(() {
      _isValid = RegExp(r'^\d{12}$').hasMatch(input);
    });
  }

  void _submitAccount() {
    if (_isValid) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => elebillsum(accountNumber: _controller.text,)),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text("Please enter a valid 12-digit loan account number."),
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
                              height: 40,width: 40,
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.arrow_back_ios_new, color: Colors.black,size: 21,),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Ajmer Vidyut vitrain Nigam \nLimited",
                      style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            Text("K Number", style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w600)),
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
            const Text("Please enter a valid 12-digit number", style: TextStyle(color: Colors.black, fontSize: 16)),
            const SizedBox(height: 10),
            if (!_isValid && _controller.text.isNotEmpty)
              const Text(
                "Please enter a valid 12-digit K number",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: _submitAccount,
                style: ElevatedButton.styleFrom(
                  backgroundColor:  const Color.fromARGB(255, 68, 128, 106),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Text("Confirm", style: GoogleFonts.inter(fontSize: 25, color: Colors.white)),
              ),
            ),
          ],
        )
      ),
    );
  }
}
