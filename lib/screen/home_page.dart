import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/creditap1.dart';
import 'package:home/profile.dart';
import 'package:home/rechargebill.dart';
import 'package:home/rechargeorbillpayment.dart';
import 'package:home/screen/biller.dart';
import 'package:home/screen/contact.dart';
import 'package:home/screen/dth1.dart';
import 'package:home/screen/lender2.dart';
import 'package:home/screen/lic%20insurance.dart';
import 'package:home/screen/notification2.dart';
import 'package:home/screen/openaccount.dart';
import 'package:home/screen/wallet.dart';
import 'package:home/screen/screen2.dart';

void main() => runApp(MaterialApp(home: HomePage()));

class HomePage extends StatelessWidget {
  Widget buildBanner(String path) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double height = MediaQuery.of(context).size.height * 0.23;
        return Container(
          margin: EdgeInsets.all(10),
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(path)),
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    );
  }

  Widget buildIconColumn(String label, IconData icon, double iconSize, double containerSize, BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (label == "Mobile") {
              Navigator.push(context, MaterialPageRoute(builder: (_) => contact()));
            } else if (label == "Wallet") {
              Navigator.push(context, MaterialPageRoute(builder: (_) => MyWalletPage()));
            } else if (label == "History") {
              Navigator.push(context, MaterialPageRoute(builder: (_) => TransactionPage()));
            }
          },
          child: Container(
            height: containerSize,
            width: containerSize,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 68, 128, 106),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, size: iconSize, color: Colors.white),
          ),
        ),
        SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: containerSize * 0.2,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildQuickActions(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double iconSize = width * 0.08;
    double containerSize = width * 0.13;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildIconColumn("Scan & Pay", Icons.qr_code, iconSize, containerSize, context),
          buildIconColumn("Mobile", Icons.person, iconSize, containerSize, context),
          buildIconColumn("Wallet", Icons.account_balance_wallet, iconSize, containerSize, context),
          buildIconColumn("History", Icons.history, iconSize, containerSize, context),
        ],
      ),
    );
  }

  Widget buildGridSection(
    List<List<String>> items,
    BuildContext context, {
    Color borderColor = const Color.fromARGB(255, 68, 128, 106),
    double borderRadius = 10,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            String label = items[index][0].replaceAll('\n', ' ').toLowerCase();

      if (label.contains("electricity")) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => Biller()));
} else if (label.contains("lic")) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => LoanAccountScreen()));
} else if (label.contains("acount")) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => OpenBankAccountScreen()));
} else if (label.contains("mobile")) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => RechargeBillPage()));
} else if (label.contains("dth")) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => Dth1()));
} else if (label.contains("loan")) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => LenderSelectionScreen()));
} else if (label.contains("credit")) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => CreditCardApplyPage()));
}

            
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(color: borderColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset(items[index][1]),
                ),
              ),
              SizedBox(height: 8),
              Text(
                items[index][0],
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 8,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: GestureDetector(
  onTap: () {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
  },
  child: CircleAvatar(
    backgroundColor: Colors.white, // Optional: set a background color
    radius: 20, // Adjust the size
    child: Icon(
      Icons.person,
      color: Color.fromARGB(255, 51, 129, 53),
      size: 24,
    ),
  ),
),

                title: Text(
                  "Ankit Sharma",
                  style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("+91 8890236723"),
                trailing: IconButton(
                  icon: Icon(Icons.notifications, color: Color.fromARGB(255, 51, 129, 53)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationScreen2()));
                  },
                ),
              ),
              buildBanner("assets/banner.png"),
              buildQuickActions(context),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Recharge & Bill Payments",
                        style: GoogleFonts.inter(color: Colors.black, fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => RechargeOrBill()));
                      },
                      child: Text("See All",
                          style: GoogleFonts.inter(
                              color: Color.fromARGB(255, 68, 128, 106), fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 22),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: buildGridSection([
                  ["Mobile\n Recharge", "assets/mre.png"],
                  ["Electricity \nBill", "assets/elect.png"],
                  ["FASTag \nRecharge", "assets/fastag1.jpeg"],
                  ["Insurance \nLIC", "assets/lic1.png"],
                  ["DTH \nRecharge", "assets/dth.png"],
                  ["Water Bill \npayment", "assets/water1.png"],
                  ["Loan\nPayment", "assets/emi.png"],
                  ["Credit Card \nBill", "assets/creditb.png"],
                ], context),
              ),
              buildBanner("assets/banner.png"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Banking / Loan Services",
                        style: GoogleFonts.inter(color: Colors.black, fontWeight: FontWeight.bold)),
                    Text("See All",
                        style: GoogleFonts.inter(
                            color: Color.fromARGB(255, 68, 128, 106), fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal:22,vertical: 22),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: buildGridSection([
                  ["Credit Card\n Apply", "assets/credit.png"],
                  ["Personal\n Loan", "assets/ploan.png"],
                  ["Business \n Loan", "assets/bloan.png"],
                  ["Home\n Loan", "assets/hloan.png"],
                  ["Bank acount\nOpen", "assets/bank.png"],
                  ["Insurance \nServices", "assets/eservice.png"],
                  ["Mutual \nFund", "assets/mutul1.png"],
                  ["Credit\n Builder", "assets/crib.png"],
                ], context, borderColor: const Color.fromARGB(255, 235, 235, 235), borderRadius: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
