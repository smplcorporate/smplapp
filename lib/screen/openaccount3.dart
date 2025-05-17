import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/openaccount4.dart';


class OpenBankAccountPage extends StatelessWidget {
  OpenBankAccountPage({super.key});

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController aadhaarController = TextEditingController();
  final TextEditingController panController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text = "${picked.day.toString().padLeft(2, '0')}/"
          "${picked.month.toString().padLeft(2, '0')}/"
          "${picked.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
          color: const Color.fromARGB(255, 232, 243, 235),
          ),
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Stack(
                children: [
                  // Back arrow with Navigator pop
                  GestureDetector(
                       onTap: () {
                      Navigator.pop(context);
                    }, // Go back to the previous screen
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Center(
                    child: Text(
                      'Open Bank Account',
                      style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  stepCircle("Step 1"),
                  stepCircle("Step 2"),
                  stepCircle("Step 3", isGreen: true),
                  stepCircle("Step 4"),
                ],
              ),
              const SizedBox(height: 30),
             Text("Account Details", style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              buildTextField("Full Name", fullNameController),
              buildTextField("Mobile Number", mobileNumberController),
              buildTextField("Aadhaar number", aadhaarController),
              buildTextField("Pan Number", panController),
              buildTextField("Date Of Birth", dobController, hintText: "DD/MM/YYYY", suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context),
              )),
              const SizedBox(height: 45),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the next screen when Next is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OpenBankAccountPage4()), // Replace with the next screen
                      );
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
                    child: Text("Next",style: GoogleFonts.inter(color: Colors.white,fontSize: 19),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Updated TextField method that places labels above the input field
  Widget buildTextField(String label, TextEditingController controller,
      {String? hintText, Widget? suffixIcon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label above the text field
          Text(
            label,
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget stepCircle(String text, {bool isGreen = false}) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: isGreen ? Color.fromARGB(255, 68, 128, 106) : Colors.white,
          child: Text(
            text.split(' ')[1],
            style: TextStyle(color: isGreen ? Colors.white : Colors.black),
          ),
        ),
        const SizedBox(height: 5),
        Text(text),
      ],
    );
  }
}
