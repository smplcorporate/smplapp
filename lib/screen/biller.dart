import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/eletercitybill.dart';
import 'package:home/screen/home_page.dart';

class BillerProvider {
  final String name;
  final String logo;

  BillerProvider({required this.name, required this.logo});
}

class Biller extends StatefulWidget {
  const Biller({Key? key}) : super(key: key);

  @override
  _BillerState createState() => _BillerState();
}

class _BillerState extends State<Biller> {
  List<BillerProvider> allBillers = [
    BillerProvider(name: 'Jaipur Vidyut Vitran Nigam (JVVNL)', logo: 'assets/jv.png'),
    BillerProvider(name: 'Ajmer Vidyut Vitran Nigam (AVVNL)', logo: 'assets/av.png'),
    BillerProvider(name: 'Jodhpur Vidyut Vitran Nigam (JDVVNL)', logo: 'assets/jodhpur.png'),
    BillerProvider(name: 'Bikaner Vidyut vitrain Nigam Limited', logo: 'assets/bkesl.png'),
    BillerProvider(name: 'UIT Udaipur', logo: 'assets/jv.png'),
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    List<BillerProvider> filteredBillers = allBillers
        .where((biller) => biller.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      body: SafeArea(
        child: Column(
          children: [
            // Custom header with back button and title
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: width * 0.04,
              ),
              child: Row(
                children: [
                  GestureDetector(
               onTap: () {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => HomePage(), // 🔁 Replace this with your actual destination widget
    ),
  );
},

                    child: Container(
                      height: width * 0.1,
                      width: width * 0.1,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: width * 0.05,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Select Provider',
                        style: GoogleFonts.inter(
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.1), // For balance with leading icon
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: SizedBox(
                height: width * 0.15,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by Biller',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: width * 0.03,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),
            ),

            // Billers list
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: width * 0.025,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Billers in Rajasthan',
                  style: GoogleFonts.inter(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: width * 0.05),
                itemCount: filteredBillers.length,
                itemBuilder: (context, index) {
                  final biller = filteredBillers[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: Image.asset(
                          biller.logo,
                          height: width * 0.12,
                          width: width * 0.1,
                          fit: BoxFit.contain,
                        ),
                        title: Text(
                          biller.name,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.038,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Eletercitybill(),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        child: const Divider(
                          color: Color.fromARGB(255, 221, 221, 221),
                          thickness: 1,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
