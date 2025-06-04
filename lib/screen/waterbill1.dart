import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/home_page.dart';
import 'package:home/screen/watelbill2.dart';



class BillerProvider {
  final String name;
  final String logo;

  BillerProvider({required this.name, required this.logo});
}

class WaterBill extends StatefulWidget {
  const WaterBill({Key? key}) : super(key: key);

  @override
  _WaterBillState createState() => _WaterBillState();
}

class _WaterBillState extends State<WaterBill> {
  List<BillerProvider> allBillers = [
    BillerProvider(name: 'Jaipur Municipal Corporation', logo: 'assets/jv.png'),
    BillerProvider(name: 'PHED- Rajasthan', logo: 'assets/av.png'),
    BillerProvider(name: 'Udaipur Municipal Corporation', logo: 'assets/jodhpur.png'),
    BillerProvider(name: 'Kota Nagar Nigam', logo: 'assets/bkesl.png'),
    BillerProvider(name: 'Bikaner Municipal Corpoation', logo: 'assets/jv.png'),
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    List<BillerProvider> filteredBillers = allBillers
        .where((biller) => biller.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(width * 0.5),
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
            padding: EdgeInsets.only(top: width * 0.03),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                   onTap: () {
              if (Navigator.of(context).canPop()) {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => HomePage()), // fallback
                );
              }
            },
                    child: Container(
                      height: width * 0.1,
                      width: width * 0.1,
                      padding: EdgeInsets.all(width * 0.01),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: width * 0.05,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Select Provider',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(width * 0.2),
            child: Padding(
              padding: EdgeInsets.fromLTRB(width * 0.04, 0, width * 0.04, width * 0.05),
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
                      vertical: width * 0.04,
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
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: width * 0.025,
              ),
              child: Text(
                'Billers in Rajasthan',
                style: GoogleFonts.inter(
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
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
                          fontSize: width * 0.035,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WaterBill2(), // Replace if needed
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
          ],
        ),
      ),
    );
  }
}
