import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// MPIN Settings Screen: Set or Change MPIN
class MPINSettingsScreen extends StatefulWidget {
  const MPINSettingsScreen({super.key});

  @override
  _MPINSettingsScreenState createState() => _MPINSettingsScreenState();
}

class _MPINSettingsScreenState extends State<MPINSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mpinController = TextEditingController();
  final _confirmMpinController = TextEditingController();

  @override
  void dispose() {
    _mpinController.dispose();
    _confirmMpinController.dispose();
    super.dispose();
  }

  void _saveMPIN() {
    if (_formKey.currentState!.validate()) {
      // Save MPIN logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('MPIN saved successfully')),
      );
      // You can navigate back or reset fields here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set / Change MPIN", style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        backgroundColor:Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _mpinController,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 4,
                decoration: InputDecoration(
                  labelText: "Enter MPIN",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) return "Please enter MPIN";
                  if (val.length != 4) return "MPIN must be 4 digits";
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _confirmMpinController,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 4,
                decoration: InputDecoration(
                  labelText: "Confirm MPIN",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) return "Please confirm MPIN";
                  if (val != _mpinController.text) return "MPIN does not match";
                  return null;
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveMPIN,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Save MPIN", style: GoogleFonts.inter( color:Colors.white,fontSize:  16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// MPIN Forgot Password Screen
class MPINForgotPasswordScreen extends StatefulWidget {
  const MPINForgotPasswordScreen({super.key});

  @override
  _MPINForgotPasswordScreenState createState() => _MPINForgotPasswordScreenState();
}

class _MPINForgotPasswordScreenState extends State<MPINForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _submitResetRequest() {
    if (_formKey.currentState!.validate()) {
      // Add forgot MPIN logic here (e.g. send OTP to phone)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP sent to ${_phoneController.text}')),
      );
      // Navigate to OTP verify or MPIN reset screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot MPIN", style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 68, 128, 106),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Enter your registered phone number to reset MPIN",
                style: GoogleFonts.inter(fontSize: 16),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) return "Please enter phone number";
                  if (!RegExp(r'^\+?\d{10,13}$').hasMatch(val)) return "Enter valid phone number";
                  return null;
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitResetRequest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Send OTP", style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// MPIN Verify Screen (optional)
class MPINVerifyScreen extends StatefulWidget {
  const MPINVerifyScreen({super.key});

  @override
  _MPINVerifyScreenState createState() => _MPINVerifyScreenState();
}

class _MPINVerifyScreenState extends State<MPINVerifyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mpinController = TextEditingController();

  @override
  void dispose() {
    _mpinController.dispose();
    super.dispose();
  }

  void _verifyMPIN() {
    if (_formKey.currentState!.validate()) {
      // Verify MPIN logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('MPIN verified successfully')),
      );
      // Navigate forward or unlock features
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify MPIN", style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 68, 128, 106),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _mpinController,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 4,
                decoration: InputDecoration(
                  labelText: "Enter MPIN",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) return "Please enter MPIN";
                  if (val.length != 4) return "MPIN must be 4 digits";
                  return null;
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _verifyMPIN,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Verify", style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
