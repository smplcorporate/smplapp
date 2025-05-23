import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final String userName = "Shreya Goyal";
  final String upiID = "9875967348";

  final TextEditingController _amountController = TextEditingController();

  void _sendAmount() {
    final amount = _amountController.text.trim();
    if (amount.isNotEmpty) {
      print("₹$amount sent!");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("₹$amount sent!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 236, 226),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
    backgroundColor: const Color.fromARGB(255, 223, 236, 226),
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 12, right: 12),
            child: Row(
              children: [
                // Circular Back Button
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 12),

                // Name and UPI ID
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        upiID,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: const Color.fromARGB(255, 179, 179, 179),
                        ),
                      ),
                    ],
                  ),
                ),

                // Question mark icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 68, 128, 106),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: const Icon(Icons.question_mark, color: Colors.white, size: 20),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                // "Hi 👋" bubble
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: const Text("Hi!   👋"),
                ),
                const SizedBox(width: 10),
                // Send Button in its own container
                ElevatedButton(
                  onPressed: _sendAmount,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    "Send ₹${_amountController.text.isEmpty ? '1' : _amountController.text}",
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 60,
                width: 375,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Icon(Icons.mic,size: 28, color: Color.fromARGB(255, 68, 128, 106),),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Enter amount or Chat",
                            border: InputBorder.none,
                          ),
                          onChanged: (val) => setState(() {}),
                        ),
                      ),
                      const Icon(Icons.image,color: Color.fromARGB(255, 68, 128, 106),),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: _sendAmount,
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundColor: Color.fromARGB(255, 68, 128, 106),
                          child: Icon(Icons.send, color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
