import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationSettingsScreen extends StatefulWidget {
  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool pushNotifications = true;
  bool transactionAlerts = true;
  bool promotionalMessages = false;
  bool soundVibration = true;

  void _saveChanges() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Notification preferences saved")),
    );
  }

  Widget _buildToggle(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.black)),
             Container(
                height: 34,
                width: 55,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: Border.all(
              
               color: value
        ? const Color.fromARGB(255, 68, 128, 106) // Green when ON
        : Colors.transparent,                    // No border when OFF
    width: 2,
                    // Show green border when ON, transparent when OFF
                  
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Switch(
                  activeColor: const Color.fromARGB(255, 68, 128, 106),
                  inactiveThumbColor:const Color.fromARGB(255, 220, 213, 213),
                  activeTrackColor: Colors.white,
                  inactiveTrackColor: Colors.white,
                  focusColor: const Color.fromARGB(255, 68, 128, 106),
                  hoverColor: const Color.fromARGB(255, 68, 128, 106),
                 value: value,
            onChanged: onChanged,
                 
                ),
              ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,border: Border.all(color: const Color.fromARGB(255, 240, 240, 240))
              ),
              child: Icon(Icons.arrow_back_ios, color: Colors.black),
            ),
          ),
        ),
        title: Text(
          "",
          style: GoogleFonts.inter(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notification",
              style: GoogleFonts.inter(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 6),
            Text(
              "Manage how you receive alerts and stay connected.",
              style: GoogleFonts.inter(color: Colors.black,fontSize: 13),
            ),
            SizedBox(height: 24),
            _buildToggle("Push Notifications", pushNotifications,
                (val) => setState(() => pushNotifications = val)),
            _buildToggle("Transaction Alerts", transactionAlerts,
                (val) => setState(() => transactionAlerts = val)),
            _buildToggle("Promotional Messages", promotionalMessages,
                (val) => setState(() => promotionalMessages = val)),
            _buildToggle("Sound & Vibration", soundVibration,
                (val) => setState(() => soundVibration = val)),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 68, 128, 106),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Save Changes',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
   