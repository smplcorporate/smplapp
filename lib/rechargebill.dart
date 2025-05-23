import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/rechargebill2.dart';

void main() {
  runApp(MaterialApp(
    home: RechargeBillPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class RechargeBillPage extends StatelessWidget {
  final List<Map<String, String>> contacts = List.generate(
    8,
    (index) => {
      'name': 'Shreya Goyal',
      'number': '9875867346',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 232, 243, 235),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Recharge Bill',
          style: GoogleFonts.inter(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
   leading: Padding(
  padding: const EdgeInsets.only(left: 20),
  child: GestureDetector(
    onTap: () {
      Navigator.pop(context); // This pops the current screen and goes back to the previous one
    },
    child: Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
      ),
    ),
  ),
),

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Box
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.black, size: 30),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search by Biller',
                          hintStyle: GoogleFonts.inter(
                            fontSize: 17,
                            color: Color(0xFF9E9E9E),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(bottom: 10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Recent Bill Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Recent Bill",
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Image.asset("assets/airtel.png", height: 30),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Airtel",
                              style: GoogleFonts.inter(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                          Text("9875867346",
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: Color(0xFFB3B3B3),
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Contact List
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 3),
                    leading: const CircleAvatar(
                      radius: 30,
                      backgroundColor: Color.fromARGB(255, 68, 128, 106),
                      child: Icon(Icons.person, color: Colors.white, size: 30),
                    ),
                    title: Text(
                      contact['name']!,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      contact['number']!,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Color(0xFFB3B3B3),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RechargePlansPage(
                         
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


