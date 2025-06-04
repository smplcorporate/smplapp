import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SecuritySettingsScreen extends StatefulWidget {
  @override
  _SecuritySettingsScreenState createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  bool faceIDEnabled = false;

  void _saveSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Security settings updated'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget buildCustomToggle({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return GestureDetector(
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
              Text(
                "Security Settings",
                style:GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
              ),
              SizedBox(height: 8),
              Text(
                "Add an extra layer of protection to keep your account safe.",
                style: TextStyle(color:Colors.black, fontSize: 13),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Enable Face ID / Fingerprint",
                      style: GoogleFonts.inter(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold
                      )),
                  buildCustomToggle(
                    value: faceIDEnabled,
                    onChanged: (val) {
                      setState(() => faceIDEnabled = val);
                    },
                  ),
                ],
              ),
              Spacer(),
              // SizedBox(
              //   width: double.infinity,
              //   child: ElevatedButton(
              //     onPressed: _saveSettings,
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: const Color.fromARGB(255, 68, 128, 106),
              //       padding: EdgeInsets.symmetric(vertical: 15),
              //       shape: StadiumBorder(),
              //     ),
              //     child: Text(
              //       "Save Changes",
              //       style:GoogleFonts.inter(
              //         fontWeight: FontWeight.bold,
              //         fontSize: 20,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
