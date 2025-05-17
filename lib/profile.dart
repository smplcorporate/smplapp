import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MaterialApp(
    home: ProfileScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 10),
               Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey.shade300)],
              ),
              child: Center(
                child:    IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
              ),
            ),
          ),
                const Spacer(),
                 Center(
                   child: Text(
                    "Profile",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize:20 ,
                      color: Colors.black
                    ),
                                   ),
                 ),
                const Spacer(),
                const SizedBox(width: 40), // Balance spacing
              ],
            ),
            const SizedBox(height: 30),

            // Profile Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 55,
                      color: Color.fromARGB(255, 68, 128, 106),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          "Ankit Sharma",
                          style: GoogleFonts.inter(
                            color: Colors.black,
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "+91 1234567879",
                          style: TextStyle(color: Color.fromARGB(255, 126, 126, 126)),
                        ),
                        const SizedBox(height: 4),
                        ElevatedButton(
                          onPressed: () {
                            // Add edit profile logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 68, 128, 106),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.edit, size: 16, color: Colors.white),
                              const SizedBox(width: 6),
                              Text(
                                "Edit Profile",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Bottom Container with Fixed Height and Width
            Container(
              height: 530,
              width: 395,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  ListTile(
                    leading: const Icon(Icons.person,size: 30,
                        color: Color.fromARGB(255, 68, 128, 106)),
                    title: Text("My Profile",   style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),),
                  ),
                  ListTile(
                    leading: const Icon(Icons.badge_outlined,size: 30,
                        color: Color.fromARGB(255, 68, 128, 106)),
                    title: Text("KYC",style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),),
                  ),
                  ListTile(
                    leading: const Icon(Icons.history,size: 30,
                        color: Color.fromARGB(255, 68, 128, 106)),
                    title: Text("Transaction History",style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),),
                  ),
                  ListTile(
                    leading: const Icon(Icons.card_giftcard,size: 30,
                        color: Color.fromARGB(255, 68, 128, 106)),
                    title: Text("Cashback & Offers",style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),),
                  ),
                  ListTile(
                    leading: const Icon(Icons.notifications,size: 30,
                        color: Color.fromARGB(255, 68, 128, 106)),
                    title: Text("Notification",style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),),
                  ),
                  ListTile(
                    leading: const Icon(Icons.help,size: 30,
                        color: Color.fromARGB(255, 68, 128, 106)),
                    title: Text("Help & Support",style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings,size: 30,
                        color: Color.fromARGB(255, 68, 128, 106)),
                    title: Text("Setting",style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),),
                  ),
                  const SizedBox(height: 15),
                  const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color.fromARGB(255, 241, 241, 241)),
                      SizedBox(height: 10,),
                  ListTile(
                    leading: const Icon(Icons.logout,size: 30,
                        color: Color.fromARGB(255, 68, 128, 106)),
                    title: Text("Logout",style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
