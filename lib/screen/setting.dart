import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Import your other screens accordingly:

import 'package:home/screen/changepasswordpage.dart';
import 'package:home/screen/mpinchange.dart';
import 'package:home/screen/myprofile.dart';
import 'package:home/screen/notifictionsetting.dart';
import 'package:home/screen/permissionsetting.dart';
import 'package:home/screen/privicysetting.dart';
import 'package:home/screen/securitysetting.dart';

// Stub MPIN Settings Screen (replace with your actual screen)



class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SettingsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool permissionEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              "Setting",
              style: GoogleFonts.inter(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 10.0),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade400),
                  color: Colors.white,
                ),
                child: Icon(Icons.arrow_back_ios_new, color: Colors.black),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Icon(Icons.person_outline, color: Colors.black, size: 30),
              SizedBox(width: 8),
              Text(
                "Account",
                style: GoogleFonts.inter(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),

          settingsTile("Edit Profile", MyProfileScreen()),
          settingsTile("Changed Password", ChangePasswordScreen()),

          // Added MPIN option here
          settingsTile("MPIN Settings",MPINSettingsScreen()),

          settingsTile("Notification Preferences", NotificationSettingsScreen()),
          settingsTile("Privacy Settings", PrivacySettingsScreen()),
          settingsTile("Security Settings", SecuritySettingsScreen()),

          SizedBox(height: 24),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PermissionsSettingsScreen()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Permission",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Location Access, Camera Access",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: const Color.fromARGB(255, 134, 134, 134),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 34,
                  width: 55,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: permissionEnabled
                          ? const Color.fromARGB(255, 68, 128, 106)
                          : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Switch(
                    activeColor: const Color.fromARGB(255, 68, 128, 106),
                    inactiveThumbColor: const Color.fromARGB(255, 220, 213, 213),
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.white,
                    value: permissionEnabled,
                    onChanged: (val) {
                      setState(() {
                        permissionEnabled = val;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget settingsTile(String title, Widget screen) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 25,
        color: Colors.black,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
    );
  }
}
