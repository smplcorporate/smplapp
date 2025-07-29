import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:home/screen/bankingservice.dart';
import 'package:home/screen/biller.dart';
import 'package:home/screen/businessloan.dart';
import 'package:home/screen/cashbackoffer.dart';
import 'package:home/screen/creditap1.dart';
import 'package:home/screen/creditbuilder.dart';
import 'package:home/screen/dth1.dart';
import 'package:home/screen/fastag1.dart';
import 'package:home/screen/homeloan.dart';
import 'package:home/screen/insurancebank.dart';
import 'package:home/screen/invitefriend.dart';
import 'package:home/screen/lender2.dart';
import 'package:home/screen/lic insurance.dart';
import 'package:home/screen/notification2.dart';
import 'package:home/screen/openaccount.dart';
import 'package:home/screen/personalloan.dart';
import 'package:home/screen/profile.dart';
import 'package:home/screen/qrcode.dart';
import 'package:home/screen/rechargebill.dart';
import 'package:home/screen/rechargeorbillpayment.dart';
import 'package:home/screen/summerysPages/fastagBiller.page.dart';
import 'package:home/screen/wallet.dart';
import 'package:home/screen/screen2.dart';
import 'package:home/screen/waterbill1.dart';

class HomePage extends StatelessWidget {
  Widget buildBanner(String path) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double height = MediaQuery.of(context).size.height * 0.23;
        return Container(
          margin: EdgeInsets.all(8),
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(path)),
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    );
  }

  Widget buildAssetIconColumn(
    String label,
    String assetPath,
    double containerSize,
    BuildContext context,
  ) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              height: 90,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      assetPath,
                      height: 40,
                      width: 40,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNewOptions(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double containerSize = width * 0.22;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildAssetIconColumn(
            "APES\nWithdrawal",
            "assets/apes.png",
            containerSize,
            context,
          ),
          buildAssetIconColumn(
            "mATM\nWithdrawal",
            "assets/matm.png",
            containerSize,
            context,
          ),
          buildAssetIconColumn(
            "Business UPI\nSoundbox",
            "assets/upi.png",
            containerSize,
            context,
          ),
        ],
      ),
    );
  }

  Widget buildIconColumn(
    String label,
    IconData icon,
    double iconSize,
    double containerSize,
    BuildContext context,
  ) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (label == "Mobile") {
              // Navigator.push(context, MaterialPageRoute(builder: (_) => ContactApp()));
            } else if (label == "Wallet") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MyWalletPage()),
              );
            } else if (label == "History") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TransactionPage()),
              );
            } else if (label == "Scan & Pay") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ScanPayScreen()),
              );
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
        SizedBox(height: 5),
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
          buildIconColumn(
            "Scan & Pay",
            Icons.qr_code,
            iconSize,
            containerSize,
            context,
          ),
          buildIconColumn(
            "Mobile",
            Icons.person,
            iconSize,
            containerSize,
            context,
          ),
          buildIconColumn(
            "Wallet",
            Icons.account_balance_wallet,
            iconSize,
            containerSize,
            context,
          ),
          buildIconColumn(
            "History",
            Icons.history,
            iconSize,
            containerSize,
            context,
          ),
        ],
      ),
    );
  }

  Widget buildGridSection(
    List<List<String>> items,
    BuildContext context, {
    Color borderColor = const Color.fromARGB(255, 235, 235, 235),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Biller()),
              );
            } else if (label.contains("lic")) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => InusrencePage()),
              );
            } else if (label.contains("acount")) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => OpenBankAccountScreen()),
              );
            } else if (label.contains("mobile")) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RechargeBillPage()),
              );
            } else if (label.contains("dth")) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Dth1()),
              );
            } else if (label.contains("credit")) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CreditCardApplyPage()),
              );
            } else if (label.contains("water bill")) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => WaterBill()),
              );
            } else if (label.contains("fastag")) {
              log("Fastag");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FastTagBillerPage()),
              );
            } else if (label.contains("personal")) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PersonalLoanApplyPage()),
              );
            } else if (label.contains("business")) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BusinessLoanApplyPage()),
              );
            } else if (label.contains("home")) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HomeLoanApplyPage()),
              );
            } else if (label.contains("insurance")) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => InsuranceApplyPage()),
              );
            } else if (label.contains("Builder")) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CreditBuilderApplyPage()),
              );
            } else if (label.contains("loan")) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LenderSelectionScreen()),
              );
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

  Widget buildCashbackAndReferContainers(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double containerPadding = width * 0.04;
    double containerMargin = width * 0.025;
    double containerBorderRadius = 12;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: containerMargin,
        vertical: containerMargin,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CashbackOffersPage()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Container(
                  padding: EdgeInsets.all(containerPadding),
                  // Remove margin here to avoid extra left space
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 206, 231, 213),
                    border: BoxBorder.all(
                      color: Color.fromARGB(255, 68, 128, 106),
                    ),
                    borderRadius: BorderRadius.circular(containerBorderRadius),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cashback",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          "assets/Cashback.png",
                          height: width * 0.18,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: containerMargin), // spacing between containers
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => InviteFriendsScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  padding: EdgeInsets.all(containerPadding),
                  // Remove margin here as well
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 206, 231, 213),
                    border: BoxBorder.all(
                      color: Color.fromARGB(255, 68, 128, 106),
                    ),
                    borderRadius: BorderRadius.circular(containerBorderRadius),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Refer & Earn",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          "assets/refer.png",
                          height: width * 0.18,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double bannerHeight = MediaQuery.of(context).size.height * 0.23;
    final box = Hive.box("userdata");
    final name = box.get("@name");
    final mobile = box.get("@mobile");

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ProfileScreen()),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 51, 129, 53),
                      size: 24,
                    ),
                  ),
                ),
                title: Text(
                  name,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text("+91 $mobile"),
                trailing: IconButton(
                  icon: Icon(
                    Icons.notifications,
                    size: 30,
                    color: Color.fromARGB(255, 51, 129, 53),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => NotificationScreen2()),
                    );
                  },
                ),
              ),
              buildBanner("assets/banner.png"),
              buildQuickActions(context),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.065,
                  vertical: width * 0.025,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Transactional Services",
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              buildNewOptions(context),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.065,
                  vertical: width * 0.012,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recharge & Bill Payments",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => RechargeOrBill()),
                        );
                      },
                      child: Text(
                        "See All",
                        style: GoogleFonts.inter(
                          color: Color.fromARGB(255, 68, 128, 106),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.055),
                padding: EdgeInsets.all(width * 0.035),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: buildGridSection([
                  ["Mobile\n Recharge", "assets/mre.png"],
                  ["Electricity \nBill", "assets/ele.png"],
                  ["FASTag \nRecharge", "assets/fastag1.jpeg"],
                  ["Insurance \nLIC", "assets/lic1.png"],
                  ["DTH \nRecharge", "assets/dth.png"],
                  ["Water Bill \npayment", "assets/water1.png"],
                  ["Loan\nPayment", "assets/emi.png"],
                  ["Credit Card \nBill", "assets/creditb.png"],
                ], context),
              ),
              SizedBox(height: 20),
              buildCashbackAndReferContainers(context),

              // Reduced vertical padding in banner margin to reduce spacing
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ), // smaller vertical margin here
                child: buildBanner("assets/banner.png"),
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.065,
                  vertical: width * 0.012,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Banking / Loan Services",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => BankingService()),
                        );
                      },
                      child: Text(
                        "See All",
                        style: GoogleFonts.inter(
                          color: Color.fromARGB(255, 68, 128, 106),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.055),
                padding: EdgeInsets.all(width * 0.035),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: buildGridSection(
                  [
                    ["Credit Card\n Apply", "assets/credit.png"],
                    ["Personal\n Loan", "assets/ploan.png"],
                    ["Business \n Loan", "assets/bloan.png"],
                    ["Home\n Loan", "assets/hloan.png"],
                    ["Bank acount\nOpen", "assets/bank.png"],
                    ["Insurance \nServices", "assets/eservice.png"],
                    ["Mutual \nFund", "assets/mutul1.png"],
                    ["Credit\n Builder", "assets/crib.png"],
                  ],
                  context,
                  borderColor: const Color.fromARGB(255, 235, 235, 235),
                  borderRadius: 12,
                ),
              ),
              SizedBox(height: width * 0.05),
              Container(
                width: 380,
                height: 550,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/pym.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12), // Optional styling
                ),
              ),
              SizedBox(height: width * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
