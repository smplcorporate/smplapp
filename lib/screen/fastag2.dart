import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/fastag3.dart';
// Adjust if needed



class VehicleRegistrationScreen extends StatefulWidget {
  @override
  _VehicleRegistrationScreenState createState() =>
      _VehicleRegistrationScreenState();
}

class _VehicleRegistrationScreenState
    extends State<VehicleRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _vehicleController = TextEditingController();
  String? _errorText;

  bool isValidVehicleNumber(String input) {
    final regExp = RegExp(r'^[A-Z]{2}[0-9]{1,2}[A-Z]{1,3}[0-9]{1,4}$');
    return regExp.hasMatch(input);
  }

  void _validateAndSubmit() {
    final vehicleNumber = _vehicleController.text.trim().toUpperCase();

    if (vehicleNumber.isEmpty) {
      setState(() => _errorText = "Please enter a valid Vehicle number");
      return;
    }

    if (!isValidVehicleNumber(vehicleNumber)) {
      setState(() => _errorText = "Invalid format. Use e.g., DL8CAP1234");
      return;
    }

    setState(() => _errorText = null);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FastagSummary(accountNumber: vehicleNumber),
      ),
    );
  }

  @override
  void dispose() {
    _vehicleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 232, 243, 235),
        title: Text('ICICI Bank - FASTag',
            style: GoogleFonts.inter(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                'Vehicle Registration Number',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _vehicleController,
                decoration: InputDecoration(
                  hintText: "Enter your vehicle number",
                  errorText: _errorText,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                textCapitalization: TextCapitalization.characters,
              ),
              const SizedBox(height: 5),
              Text(
                'Please enter your vehicle number',
                style: GoogleFonts.inter(fontSize: 12, color: Colors.black),
              ),
              const SizedBox(height: 30),
              Text(
                'Instructions to Enter Vehicle Number:',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(height: 12),
              instructionBullet(
                  "Enter the vehicle number exactly as shown on the number plate."),
              instructionBullet(
                  "Format: DL8CAP1234 (no spaces or special characters)."),
              instructionBullet("Use only capital letters and numbers."),
              instructionBullet(
                  "Incorrect entry may result in failure to fetch vehicle details."),
              instructionBullet("Double-check the number before submitting."),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _validateAndSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    "Confirm",
                    style: GoogleFonts.inter(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget instructionBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ",
              style: GoogleFonts.inter(fontSize: 18, color: Colors.black)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
