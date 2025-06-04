import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/openaccount4.dart';

class OpenBankAccountPage extends StatefulWidget {
  const OpenBankAccountPage({super.key});

  @override
  State<OpenBankAccountPage> createState() => _OpenBankAccountPageState();
}

class _OpenBankAccountPageState extends State<OpenBankAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

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
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 232, 243, 235),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
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
                        style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold),
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

                buildTextField("Full Name", fullNameController, validator: (value) {
                  if (value == null || value.isEmpty) return "Please enter full name";
                  return null;
                }),

                buildTextField(
                  "Mobile Number",
                  mobileNumberController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Please enter mobile number";
                    if (value.length != 10) return "Mobile number must be exactly 10 digits";
                    return null;
                  },
                ),

                buildTextField("Email", emailController, keyboardType: TextInputType.emailAddress, validator: (value) {
                  if (value == null || value.isEmpty) return "Please enter email";
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return "Enter valid email";
                  return null;
                }),

                buildTextField("Address", addressController, validator: (value) {
                  if (value == null || value.isEmpty) return "Please enter address";
                  return null;
                }),

                buildTextField(
                  "Date Of Birth",
                  dobController,
                  hintText: "DD/MM/YYYY",
                  readOnly: true,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Please select DOB";
                    return null;
                  },
                ),

                const SizedBox(height: 45),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const OpenBankAccountPage4()),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                        elevation: 5,
                      ),
                      child: Text("Next", style: GoogleFonts.inter(color: Colors.white, fontSize: 18)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
    bool readOnly = false,
    String? Function(String?)? validator,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            readOnly: readOnly,
            validator: validator,
            maxLength: maxLength,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              counterText: '', // hide character counter
              hintText: hintText,
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: Colors.white,
              border: const OutlineInputBorder(),
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
          backgroundColor: isGreen ? const Color.fromARGB(255, 68, 128, 106) : Colors.white,
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
