import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:home/screen/businessloan.dart';
import 'package:home/screen/creditap1.dart';
import 'package:home/screen/creditbuilder.dart';
import 'package:home/screen/homeloan.dart';
import 'package:home/screen/insurancebank.dart';
import 'package:home/screen/openaccount.dart';
import 'package:home/screen/personalloan.dart';
 // If you use RechargeBillPage

class BankingService extends StatelessWidget {
  final List<SectionModel> sections = [
    SectionModel(
      title: "Banking",
      items: [
        IconLabel("Credit Card\nApply", "assets/credit.png"),
        IconLabel("Personal\nLoan", "assets/ploan.png"),
        IconLabel("Business\nLoan", "assets/bloan.png"),
        IconLabel("Home\nLoan", "assets/hloan.png"),
        IconLabel("Bank Account\nOpen", "assets/bank.png"),
        IconLabel("Insurance\nServices", "assets/eservice.png"),
        IconLabel("Mutual\nFund", "assets/mutul1.png"),
        IconLabel("Credit\nBuilder", "assets/crib.png"),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      appBar: AppBar(
        title: Text(
          "Banking Service",
          style: GoogleFonts.inter(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
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
        color: Colors.white,
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
                childAspectRatio: 0.85,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                final item = section.items[index];

                return GestureDetector(
                  onTap: () {
                    // Navigation logic
                    if (item.label.contains("Credit Card")) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => CreditCardApplyPage()),
                      );
                    } else if (item.label.contains("Personal")) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => PersonalLoanApplyPage()),
                      );
                    } else if (item.label.contains("Business")) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => BusinessLoanApplyPage()),
                      );
                    } else if (item.label.contains("Home")) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => HomeLoanApplyPage()),
                      );
                    } else if (item.label.contains("Bank Account")) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => OpenBankAccountScreen()),
                      );
                    } else if (item.label.contains("Insurance")) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => InsuranceApplyPage()),
                      );
                    } else if (item.label.contains("Mutual Fund")) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Mutual Fund screen not implemented.")),
                      );
                    } else if (item.label.contains("Builder")) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => CreditBuilderApplyPage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Tapped on ${item.label}")),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: const Color.fromARGB(255, 235, 235, 235)),
                        ),
                        child: Image.asset(
                          item.icon,
                          width: 40,
                          height: 40,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.broken_image,
                                size: 40, color: Colors.grey);
                          },
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.label,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
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
