import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/dth2.dart';
import 'package:home/screen/home_page.dart';
import 'package:home/screen/openaccount2.dart';

class Bank {
  final String name;
  final String logo;

  Bank({required this.name, required this.logo});
}

class Dth1 extends StatefulWidget {
  const Dth1({Key? key}) : super(key: key);

  @override
  _Dth1State createState() => _Dth1State();
}

class _Dth1State extends State<Dth1> {
  List<Bank> allBanks = [
    Bank(name: 'Airtel Digitl TV', logo: 'assets/airt.png'),
    Bank(name: 'TaTa Sky ', logo: 'assets/tatad.png'),
    Bank(name: 'D2H', logo: 'assets/d2h.png'),
    Bank(name: 'Sun Direct', logo: 'assets/sund.png'),
    Bank(name: 'Releince Enterment', logo: 'assets/relienced.png'),
    Bank(name: 'Dish TV', logo: 'assets/dishtv.png'),
  
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Bank> filteredBanks = allBanks
        .where((bank) =>
            bank.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return SafeArea(
      child: Scaffold(
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
              padding: const EdgeInsets.only(top: 22),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                         Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => HomePage(), // 🔁 Replace this with your actual destination widget
    ),
  );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.black, size: 23),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Select Provider',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 18,
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
                      hintText: 'Search by Biller',
                      prefixIcon: const Icon(Icons.search, size: 30),
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
        body: Container(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredBanks.length,
                  itemBuilder: (context, index) {
                    final bank = filteredBanks[index];
                    return Column(
                      children: [
                        ListTile(
                          leading:
                              Image.asset(bank.logo, height: 50, width: 40),
                          title: Text(
                            bank.name,
                            style: GoogleFonts.inter(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Dth2(providerName: '',)),
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
        ),
      ),
    );
  }
}
