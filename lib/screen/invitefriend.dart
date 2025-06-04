import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InviteFriendsScreen extends StatelessWidget {
  final List<Map<String, String>> suggestions = [
    {"name": "Shreya Goyal", "phone": "9875867346"},
    {"name": "Shreya Goyal", "phone": "9875867346"},
    {"name": "Shreya Goyal", "phone": "9875867346"},
  ];

  void _inviteViaWhatsApp(String phone) async {
    final message = Uri.encodeFull(
        "Hey! Join this awesome app and get rewards. Use my referral!");
    final url = "https://wa.me/$phone?text=$message";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // Use a base width to scale font sizes and paddings
    final baseWidth = width < 400 ? width : 400;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: baseWidth * 0.03),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: baseWidth * 0.1,
              width: baseWidth * 0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: const Color.fromARGB(255, 240, 240, 240),
                ),
              ),
              child: Icon(Icons.arrow_back_ios_new,
                  color: Colors.black, size: baseWidth * 0.05),
            ),
          ),
        ),
        title: Text(
          "Invite Friends",
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: baseWidth * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: height * 0.025),
          SizedBox(
            height: height * 0.3,
            child: Image.asset(
              'assets/invite.png',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: height * 0.01),
          Text(
            "Share the Love, Earn the Rewards!",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: baseWidth * 0.055,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: baseWidth * 0.075,
              vertical: height * 0.015,
            ),
            child: Text(
              "Refer your friends and get rewarded for every new\n user you bring.",
              style: GoogleFonts.inter(
                fontSize: baseWidth * 0.035,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => _inviteViaWhatsApp(""),
            icon: Icon(
              FontAwesomeIcons.whatsapp,
              color: Colors.white,
              size: baseWidth * 0.07,
            ),
            label: Text(
              "Invite Friend",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: baseWidth * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 72, 135, 66),
              padding: EdgeInsets.symmetric(
                horizontal: baseWidth * 0.15,
                vertical: height * 0.015,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(baseWidth * 0.07),
              ),
            ),
          ),
          SizedBox(height: height * 0.04),
          
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: baseWidth * 0.075),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Suggestion",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: baseWidth * 0.05,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final user = suggestions[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: baseWidth * 0.05,
                    vertical: height * 0.008,
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: baseWidth * 0.075,
                      backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: baseWidth * 0.1,
                      ),
                    ),
                    title: Text(
                      user["name"]!,
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: baseWidth * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      user["phone"]!,
                      style: GoogleFonts.inter(
                        color: const Color.fromARGB(255, 179, 179, 179),
                        fontSize: baseWidth * 0.03,
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () => _inviteViaWhatsApp(user["phone"]!),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: baseWidth * 0.04,
                          vertical: height * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 194, 230, 190),
                          border: Border.all(
                            color: const Color.fromARGB(255, 72, 135, 66),
                          ),
                          borderRadius: BorderRadius.circular(baseWidth * 0.05),
                        ),
                        child: Text(
                          "Invite",
                          style: GoogleFonts.inter(
                            color: const Color.fromARGB(255, 72, 135, 66),
                            fontSize: baseWidth * 0.037,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
