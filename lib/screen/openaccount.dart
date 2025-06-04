import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/openaccount2.dart';

class Bank {
  final String name;
  final String logo;

  Bank({required this.name, required this.logo});
}

class OpenBankAccountScreen extends StatefulWidget {
  const OpenBankAccountScreen({Key? key}) : super(key: key);

  @override
  _OpenBankAccountScreenState createState() => _OpenBankAccountScreenState();
}

class _OpenBankAccountScreenState extends State<OpenBankAccountScreen> {
  List<Bank> allBanks = [
    Bank(name: 'SBI Bank', logo: 'assets/sbi.png'),
    Bank(name: 'HDFC Bank', logo: 'assets/hdfc.png'),
    Bank(name: 'Bank of Baroda Bank', logo: 'assets/bob.png'),
    Bank(name: 'Yes Bank', logo: 'assets/yesbank.png'),
    Bank(name: 'Kotak Mahindra Bank', logo: 'assets/kotak.png'),
    Bank(name: 'Canara Bank', logo: 'assets/canara.png'),
    Bank(name: 'Muthoot Bank', logo: 'assets/mutooth.png'),
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
                        Navigator.pop(context);
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
                      'Open Bank Account',
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
                      hintText: 'Search by Bank',
                      prefixIcon: const Icon(Icons.search,size: 30,),
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Text(
                    'Select Bank',
                    style: GoogleFonts.inter(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
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
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => OpenAccount2()),
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
