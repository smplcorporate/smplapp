import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/eletercitybill.dart';

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
    BillerProvider(name: 'Jodhpur Vidyut Vitran Nigam (JDVVNL)', logo: 'assets/jv.png'),
    BillerProvider(name: 'Rajasthan Water Supply & Sewerage Board', logo: 'assets/jv.png'),
    BillerProvider(name: 'BSNL Rajasthan', logo: 'assets/jv.png'),
    BillerProvider(name: 'Rajasthan Housing Board', logo: 'assets/jv.png'),
    BillerProvider(name: 'UIT Udaipur', logo: 'assets/jv.png'),
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<BillerProvider> filteredBillers = allBillers
        .where((biller) =>
            biller.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
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
            padding: const EdgeInsets.only(top: 18),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 21,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Select Provider',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 20,
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
                    prefixIcon: const Icon(Icons.search),
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
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                'Billers in Rajasthan',
                style: GoogleFonts.inter(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredBillers.length,
              itemBuilder: (context, index) {
                final biller = filteredBillers[index];
                return Column(
                  children: [
                    ListTile(
                      leading:
                          Image.asset(biller.logo, height: 50, width: 40),
                      title: Text(biller.name,style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 17),),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Eletercitybill()),
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
