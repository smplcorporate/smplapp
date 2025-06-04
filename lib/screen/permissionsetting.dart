import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PermissionsSettingsScreen extends StatefulWidget {
  @override
  _PermissionsSettingsScreenState createState() => _PermissionsSettingsScreenState();
}

class _PermissionsSettingsScreenState extends State<PermissionsSettingsScreen> {
  bool locationAccess = false;
  bool cameraAccess = false;
  bool microphoneAccess = false;
  bool contactsAccess = false;
  bool storageAccess = false;

  void _managePermissions() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Permissions updated."),
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
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
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

              // Title
              Text(
                "Permissions Settings",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Control what your app can access for a safer experience.",
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),

              // Toggles
              buildCustomToggle(
                label: "Location Access",
                value: locationAccess,
                onChanged: (val) => setState(() => locationAccess = val),
              ),
              buildCustomToggle(
                label: "Camera Access",
                value: cameraAccess,
                onChanged: (val) => setState(() => cameraAccess = val),
              ),
              buildCustomToggle(
                label: "Microphone Access",
                value: microphoneAccess,
                onChanged: (val) => setState(() => microphoneAccess = val),
              ),
              buildCustomToggle(
                label: "Contacts Access",
                value: contactsAccess,
                onChanged: (val) => setState(() => contactsAccess = val),
              ),
              buildCustomToggle(
                label: "Storage Access",
                value: storageAccess,
                onChanged: (val) => setState(() => storageAccess = val),
              ),

              Spacer(),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _managePermissions,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: StadiumBorder(),
                  ),
                  child: Text(
                    "Manage Permissions",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
