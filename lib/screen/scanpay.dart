import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/sendpaymentsuccess.dart';
import 'package:home/screen/success.dart';

class ScanAndPayScreen extends StatefulWidget {
  @override
  _ScanAndPayScreenState createState() => _ScanAndPayScreenState();
}

class _ScanAndPayScreenState extends State<ScanAndPayScreen> {
  final TextEditingController amountController = TextEditingController();

  String recipientName = "Shreya Goyal";
  String recipientunmber = "9660050786";

  final Map<String, String> bankLogos = {
    "HDFC Bank": "assets/hdfc.png",
    "Bank of Baroda": "assets/bob.png",
    "Canara Bank": "assets/canara.png",
    "State Bank Of India": "assets/sbi.png",
  };
  String selectedBank = "State Bank Of India";

  void proceedToPay() {
    final amount = amountController.text.trim();
    if (amount.isEmpty || double.tryParse(amount) == null || double.parse(amount) <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid amount")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SendPaymentApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12, top: 8),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade300, blurRadius: 4),
                ],
              ),
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Scan & Pay",
          style: GoogleFonts.inter(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, right: 20, left: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                  child: Icon(Icons.person, color: Colors.white, size: 40),
                ),
                const SizedBox(height: 10),
                Text(
                  recipientName,
                  style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  recipientunmber,
                  style: GoogleFonts.inter(fontSize: 13, color: const Color.fromARGB(255, 179, 179, 179)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, right: 40, left: 40, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        bankLogos[selectedBank]!,
                        height: 20,
                      ),
                      const SizedBox(width: 6),
                      DropdownButton<String>(
                        value: selectedBank,
                        icon: const Icon(Icons.arrow_drop_down, color: Colors.black, size: 35),
                        style: GoogleFonts.inter(color: Colors.black, fontSize: 14),
                        underline: Container(),
                        dropdownColor: Colors.white,
                        items: bankLogos.keys.map((String bank) {
                          return DropdownMenuItem<String>(
                            value: bank,
                            child: Text(bank),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedBank = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 130),
                  child: TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      hintText: "Enter your amount",
                      hintStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 8),
                        child: Icon(Icons.currency_rupee, color: Colors.black, size: 24),
                      ),
                      prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                      ),
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                onPressed: proceedToPay,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  "Proceed to Pay",
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
