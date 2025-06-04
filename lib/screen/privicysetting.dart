import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacySettingsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  
      home: PrivacySettingsScreen(),
    );
  }
}

class PrivacySettingsScreen extends StatefulWidget {
  @override
  _PrivacySettingsScreenState createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool biometricAuth = false;
  bool appLock = false;
  bool twoFactorAuth = false;

  void saveChanges() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Changes Saved!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget buildCustomToggle({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onChanged(!value),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: 36,
              width: 54,
              padding: EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: value
                      ? const Color.fromARGB(255, 68, 128, 106)
                      : const Color.fromARGB(255, 220, 213, 213),
                  width: 1.5,
                ),
                color: Colors.white,
              ),
              child: Align(
                alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: value
                        ? const Color.fromARGB(255, 68, 128, 106)
                        : const Color.fromARGB(255, 220, 213, 213),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom Back Button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade400),
                    color: Colors.white,
                  ),
                  child: Icon(Icons.arrow_back_ios_new,
                      color: Colors.black, size: 20),
                ),
              ),
              SizedBox(height: 50),
              // Title Text
              Text(
                'Privacy Settings',
                style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 8),
              Text(
                'Decide what information you share and protect your data',
                style: TextStyle(color: Colors.black, fontSize: 13),
              ),
              SizedBox(height: 40),

              // Custom Toggles
              buildCustomToggle(
                label: 'Biometric Authentication',
                value: biometricAuth,
                onChanged: (val) => setState(() => biometricAuth = val),
              ),
              buildCustomToggle(
                label: 'App Lock',
                value: appLock,
                onChanged: (val) => setState(() => appLock = val),
              ),
              buildCustomToggle(
                label: 'Two-Factor Authentication',
                value: twoFactorAuth,
                onChanged: (val) => setState(() => twoFactorAuth = val),
              ),

              Spacer(),

              // Save Changes Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: StadiumBorder(),
                  ),
                  child: Text(
                    'Save Changes',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
