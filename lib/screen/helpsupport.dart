import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(HelpSupportApp());

class HelpSupportApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HelpSupportPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HelpSupportPage extends StatefulWidget {
  @override
  _HelpSupportPageState createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
  TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> faqs = [
    {"question": "How do I add money to my wallet?", "answer": "Go to the wallet section and click 'Add Money'."},
    {"question": "What should I do if a transaction fails?", "answer": "Check your bank statement or contact support."},
    {"question": "How can I view my transaction history?", "answer": "Go to 'Transactions' in the menu."},
    {"question": "How do I update my KYC details?", "answer": "Visit the KYC section and follow instructions."},
    {"question": "How can I set up biometric authentication for security?", "answer": "Enable it in security settings."},
    {"question": "How can I contact customer support?", "answer": "Use the chat or call us from the support page."},
    {"question": "What are the charges for transferring\nmoney?", "answer": "Charges may apply depending on the amount."},
    {"question": "What are the charges for transferring\nmoney?", "answer": "Please check the fee structure in settings."},
    {"question": "What are the charges for transferring\nmoney?", "answer": "It varies based on the payment method."},
  ];

  List<bool> expandedList = [];

  @override
  void initState() {
    super.initState();
    expandedList = List.filled(faqs.length, false);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredFaqs = faqs
        .where((faq) => faq["question"]!
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 232, 243, 235),
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 10,
        title: Stack(
          children: [
            const SizedBox(width: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  'Help & Support',
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Need Help? We’ve Got You Covered!",
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 4),
            Text(
              "Find quick answers to your questions or get personalized support when you need it.",
              style: GoogleFonts.inter(color: Colors.black, fontSize: 13,fontWeight:FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Help',
                  helperStyle: GoogleFonts.inter(fontSize: 13, color: Colors.black),
                  prefixIcon: const Icon(Icons.search, size: 30),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: filteredFaqs.length,
                itemBuilder: (context, index) {
                  final faqIndex = faqs.indexOf(filteredFaqs[index]);
                  return Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(horizontal: 0),
                      title: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          filteredFaqs[index]['question']!,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      trailing: Icon(
                        expandedList[faqIndex]
                            ? Icons.add
                            : Icons.add,
                        color: Colors.black,
                        size: 26,
                      ),
                      initiallyExpanded: expandedList[faqIndex],
                      onExpansionChanged: (expanded) {
                        setState(() {
                          expandedList[faqIndex] = expanded;
                        });
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              filteredFaqs[index]['answer']!,
                              style: GoogleFonts.inter(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
