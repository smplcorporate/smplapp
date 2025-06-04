import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/openaccount.dart';
import 'package:home/screen/openaccount3.dart'; // Assuming OpenBankAccountPage is defined here

class OpenAccount2 extends StatefulWidget {
  @override
  _OpenAccount2State createState() => _OpenAccount2State();
}

class _OpenAccount2State extends State<OpenAccount2> {
  final List<String> accountTypes = ['Saving Account',];
  String? selectedAccountType;

  @override
  void initState() {
    super.initState();
    selectedAccountType = accountTypes[0]; // Default selection
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 232, 243, 235),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Updated AppBar-like Row
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.arrow_back_ios,
                            size: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Open Bank Account',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:
                    List.generate(4, (index) => _buildStepIndicator(index + 1)),
              ),
              const SizedBox(height: 30),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        'Select Account Type',
                        style: GoogleFonts.inter(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        children: accountTypes.map((type) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 6.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedAccountType = type;
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black54,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Center(
                                      child: selectedAccountType == type
                                          ? Container(
                                              width: 12,
                                              height: 12,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromARGB(
                                                    255, 68, 128, 106),
                                              ),
                                            )
                                          : null,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    type,
                                    style: GoogleFonts.inter(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedAccountType != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Selected: $selectedAccountType')),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OpenBankAccountPage()),
                      );
                    }
                  },
                 style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255,  68, 128, 106), // Change button background color
    foregroundColor: Colors.white, // Text/icon color
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Button size
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18), // Rounded corners
    ),
    elevation: 5, // Shadow depth
  ),
                  child:  Text('Next',
                      style: GoogleFonts.inter(color: Colors.white,fontSize: 19)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator(int step) {
    return Column(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: step == 2
              ? const Color.fromARGB(255, 68, 128, 106)
              : Colors.grey[300],
          child: Text(
            '$step',
            style: const TextStyle(color: Colors.black),
          ),
        ),
        const SizedBox(height: 4),
        Text('Step $step', style:  GoogleFonts.inter(fontSize: 12)),
      ],
    );
  }
}
