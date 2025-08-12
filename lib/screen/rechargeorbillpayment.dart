import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/biller.dart';
import 'package:home/screen/dth1.dart';
import 'package:home/screen/fastag1.dart';
import 'package:home/screen/landline/landline.page.dart';
import 'package:home/screen/lender2.dart';
import 'package:home/screen/lic insurance.dart';
import 'package:home/screen/rechargebill.dart';
import 'package:home/screen/selectgas.dart';
import 'package:home/screen/summerysPages/boardBand.page.dart';
import 'package:home/screen/summerysPages/pipeGas.page.dart';
import 'package:home/screen/waterbill1.dart';


class RechargeOrBill extends StatelessWidget {
  final List<SectionModel> sections = [
    SectionModel(
      title: "Recharges",
      items: [
        IconLabel("Mobile Recharge", "assets/mre.png"),
        IconLabel("DTH Recharge", "assets/dth.png"),
        IconLabel("FASTag Recharge", "assets/fastag.png"),
        IconLabel("NCMC Recharge", "assets/ncmc.png"),
        IconLabel("Cable TV Recharge", "assets/cabletv.png"),
        IconLabel("Metro Recharge", "assets/metro.png"),
      ],
    ),
    SectionModel(
      title: "Utilities & Bill Payment",
      items: [
        IconLabel("Electricity Bill", "assets/ele.png"),
        IconLabel("Water Bill", "assets/water1.png"),
        IconLabel("Book Gas Cylinder", "assets/gbook.png"),
        IconLabel("Loan/EMI Payment", "assets/emi.png"),
        IconLabel("Insurance / LIC", "assets/lic.png"),
        IconLabel("Credit Card Bill", "assets/creditb.png"),
        IconLabel("Mobile Postpaid", "assets/mpostpaid.png"),
        IconLabel("Broadband", "assets/landline.png"),
        IconLabel("Piped Gas", "assets/pergas.png"),
        IconLabel("Prepaid Meter", "assets/pmeter.png"),
        IconLabel("Education Fees", "assets/educationfees.png"),
        IconLabel("Rental", "assets/rent.png"),
        IconLabel("Landline", "assets/icons8-landline-66.png"),
      ],
    ),
    SectionModel(
      title: "Housing & Society",
      items: [
        IconLabel("Municipal Tax", "assets/muncipaltax.png"),
        IconLabel("Club & Association", "assets/club.png"),
        IconLabel("Apartments", "assets/apart.png"),
      ],
    ),
    SectionModel(
      title: "Other Services",
      items: [
        IconLabel("Hospital & Pathology", "assets/hospital.png"),
        IconLabel("Donation", "assets/donation.png"),
        IconLabel("Devotion", "assets/deption.png"),
        IconLabel("NPS Contribution", "assets/nps.png"),
        IconLabel("Deposit", "assets/deposit.png"),
        IconLabel("Subscription", "assets/sub.png"),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      appBar: AppBar(
        title: Text(
          "Recharge & Bill Payments",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 232, 243, 235),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 18,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 232, 243, 235), // Outer green background
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          itemCount: sections.length,
          itemBuilder: (context, index) {
            return SectionWidget(section: sections[index]);
          },
        ),
      ),
    );
  }
}

class SectionWidget extends StatelessWidget {
  final SectionModel section;

  const SectionWidget({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, // White card inside green background
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 68, 128, 106),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              section.title,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: section.items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.9,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                final item = section.items[index];

                return GestureDetector(
                  onTap: () {
                    if (item.label == "Mobile Recharge") {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => RechargeBillPage()));
                    } else if (item.label == "DTH Recharge") {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => Dth1()));
                    } else if (item.label == "Electricity Bill") {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => Biller()));
                    } else if (item.label == "Insurance / LIC") {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => InusrencePage()));
                    } else if (item.label == "Loan/EMI Payment") {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => LenderSelectionScreen()));
                    } else if (item.label == "Water Bill") {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => WaterBill()));
                    }  else if (item.label == "Book Gas Cylinder") {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => SelectGasProviderScreen()));
                    }  else if (item.label == "FASTag Recharge") {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => FastagScreen()));
                    } else if(item.label == "Piped Gas"){
                       Navigator.push(context, MaterialPageRoute(builder: (_) => PipeGasPage()));
                    } else if(item.label == "Broadband"){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => BoardBansPage()));
                    }else if(item.label == "Landline"){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => LandlinePage()));
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Tapped on ${item.label}")),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 50,width: 50,
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color.fromARGB(255, 235, 235, 235),),
                        ),
                        child: Image.asset(
                          item.icon,
                          width: 40,
                          height: 40,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.broken_image, size: 40, color: Colors.grey);
                          },
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.label,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(fontSize: 8, 
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SectionModel {
  final String title;
  final List<IconLabel> items;

  SectionModel({required this.title, required this.items});
}

class IconLabel {
  final String label;
  final String icon;

  IconLabel(this.label, this.icon);
}
