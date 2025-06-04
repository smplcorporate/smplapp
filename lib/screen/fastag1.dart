import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/fastag2.dart';

import 'package:home/screen/home_page.dart';
import 'package:home/screen/openaccount2.dart'; // Rename this if needed

class FastagProvider {
  final String name;
  final String logo;

  FastagProvider({required this.name, required this.logo});
}

class FastagScreen extends StatefulWidget {
  const FastagScreen({Key? key}) : super(key: key);

  @override
  _FastagScreenState createState() => _FastagScreenState();
}

class _FastagScreenState extends State<FastagScreen> {
  List<FastagProvider> allProviders = [
    FastagProvider(name: 'ICICI Bank FASTag', logo: 'assets/icici.png'),
    FastagProvider(name: 'SBI Bank FASTag', logo: 'assets/sbi.png'),
    FastagProvider(name: 'HDFC Bank FASTag', logo: 'assets/hdfc.png'),
    FastagProvider(name: 'Bank of Baroda Ban FASTagk', logo: 'assets/bob.png'),
    FastagProvider(name: 'Yes Bank FASTag', logo: 'assets/yesbank.png'),
    FastagProvider(name: 'Kotak Mahindra Bank FASTag', logo: 'assets/kotak.png'),
    FastagProvider(name: 'Canara Bank FASTag', logo: 'assets/canara.png'),
    FastagProvider(name: 'Muthoot Bank FASTag', logo: 'assets/mutooth.png'),
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredProviders = allProviders
        .where((provider) =>
            provider.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    final width = MediaQuery.of(context).size.width;

    return 
      Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(180),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 232, 243, 235),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top:16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child:  Container(
          height: 40,
          width: 40,
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
            color: Colors.black,
            onPressed: () {
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => HomePage(), // 🔁 Replace this with your actual destination widget
    ),
  );// Add your navigation logic
            },
          ),
        ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'FASTag Recharge',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: SizedBox(
                  height: 70,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search by FASTag Provider',
                      prefixIcon: const Icon(Icons.search, size: 28),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 20),
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
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Text(
                  'All Provider',
                  style: GoogleFonts.inter(
                    fontSize: width * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredProviders.length,
                itemBuilder: (context, index) {
                  final provider = filteredProviders[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: Image.asset(provider.logo, height: 50, width: 40),
                        title: Text(
                          provider.name,
                          style: GoogleFonts.inter(
                            fontSize: width * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => VehicleRegistrationScreen(), // Rename if needed
                            ),
                          );
                        },
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 221, 221, 221),
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      );
  
  }
}
