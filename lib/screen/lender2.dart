import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/home_page.dart';
import 'package:home/screen/muthoothfin.dart'; // Replace with correct path

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Select Lender UI',
      home: LenderSelectionScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LenderSelectionScreen extends StatefulWidget {
  @override
  _LenderSelectionScreenState createState() => _LenderSelectionScreenState();
}

class _LenderSelectionScreenState extends State<LenderSelectionScreen> {
  bool showFilter = false;
  bool filterApplied = false;
  String selectedFilter = '';

  final List<String> lenders = [
    'Muthoot Finance',
    'Bajaj Finance',
    'DMI Finance',
    'Bajaj Finance',
    'DMI Finance',
    'HDFC Finance',
  ];

  final Map<String, String> lenderLogos = {
    'Muthoot Finance': 'assets/mutooth.png',
    'Bajaj Finance': 'assets/baj.png',
    'DMI Finance': 'assets/dmi.png',
    'HDFC Finance': 'assets/hdfc1.png',
  };

  final List<String> filters = [
    'Gold Loan',
    'Home Loan',
    'Bank',
    'Small finance Bank',
    'Consumer Loan',
    'Vehicle Loan',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: false, // Hide default back button
          backgroundColor: const Color.fromARGB(255, 232, 243, 235),
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 40, left: 15, right: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
     Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => HomePage(), // 🔁 Replace this with your actual destination widget
    ),
  );
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Center(
                    child: Text(
                      'Select Your Lender',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 40), // Balance spacing
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 232, 243, 235),
          ),

          if (showFilter)
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: 0.3,
              child: Container(color: Colors.black),
            ),

          Column(
            children: [
              const SizedBox(height: 150),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search by lender',
                          prefixIcon: const Icon(Icons.search, size: 30),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showFilter = true;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.filter_list, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: lenders.length,
                  itemBuilder: (context, index) {
                    final lender = lenders[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset(
                          lenderLogos[lender] ?? 'assets/default.png',
                          width: 30,
                          height: 30,
                        ),
                        title: Text(
                          lender,
                          style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          setState(() {
                            showFilter = true;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          // Filter Bottom Sheet
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            bottom: showFilter ? 0 : -350,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 225, 246, 236),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: filters.map((filter) {
                      final isSelected = selectedFilter == filter;
                      return ChoiceChip(
                        label: Text(
                          filter,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: const Color.fromARGB(255, 68, 128, 106),
                        backgroundColor: const Color.fromARGB(255, 232, 243, 235),
                        showCheckmark: false,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedFilter = selected ? filter : '';
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedFilter.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MuthootFinScreen(accountNumber: '123456789012'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please select a filter to proceed.')),
                          );
                        }

                        setState(() {
                          showFilter = false;
                          filterApplied = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        'Apply Filter',
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
