import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const UPIChatApp());

class UPIChatApp extends StatelessWidget {
  const UPIChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

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
      backgroundColor: const Color(0xFFEFF6EF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF6EF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () {},
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userName,
                style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
            Text(upiID,
                style: GoogleFonts.roboto(fontSize: 12, color: Colors.black54)),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.question_mark, color: Colors.green),
          ),
        ],
      ),
      body: Column(
        children: [
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Hi!"),
                  const SizedBox(height: 4),
                  const Text("👋"),
                  const SizedBox(height: 10),
                  // ElevatedButton(
                  //   onPressed: _sendAmount,
                  //   style: ElevatedButton.styleFrom(
                  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  //     backgroundColor: Colors.green,
                  //   ),
                  //   child: Text("Send ₹${_amountController.text.isEmpty ? '1' : _amountController.text}",
                  //       style: const TextStyle(color: Colors.white)),
                  // ),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                    height: 53,width: 375,
       
                decoration: BoxDecoration(     color: Colors.white,
                  borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.mic, color: Colors.grey),
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
                      const Icon(Icons.image_aspect_ratio,),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: _sendAmount,
                        child: const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.green,
                          child: Icon(Icons.send, color: Colors.white, size: 18),
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
