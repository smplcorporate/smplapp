import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/data/controller/landline.provider.dart';

import 'package:home/screen/home_page.dart';
import 'package:home/screen/landline/landlineForm.page.dart';
import 'package:home/screen/summerysPages/fastagBiller.page.dart';

import 'package:home/screen/summerysPages/pipeGasFrom.page.dart';

class LandlinePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<LandlinePage> createState() => _LandlinePageState();
}

class _LandlinePageState extends ConsumerState<LandlinePage> {
      final Color buttonColor = const Color.fromARGB(255, 68, 128, 106);
  String billerName = '';
  String billerCode = '';
  String circleCode = '';
  @override
  Widget build(BuildContext context) {
        final electricityProvider = ref.watch(landlineProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final width = MediaQuery.of(context).size.width;
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 375;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
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
                          MaterialPageRoute(builder: (context) => HomePage()),
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
                          "Landline",
                          style: GoogleFonts.inter(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.1),
                  ],
                ),
              ),

      
              electricityProvider.when(
                data: (snapshot) {
                  final filteredList =
                      snapshot.billersList
                          .where(
                            (biller) => biller.billerName
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase()),
                          )
                          .toList();

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (snapshot.circleList != null) ...[
                        SizedBox(height: 30.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.03,
                          ),
                          child: BillerCircleDropDown(
                            billers: snapshot.circleList!,
                            callBack: (value) {
                              circleCode = value.circleId;
                            },
                          ),
                        ),
                      ],

                      SizedBox(height: 5.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                        child: CustomSearchableDropdown(
                          billers: snapshot.billersList,
                          callBack: (value) {
                            billerCode = value.billerCode;
                            billerName = value.billerName;
                          },
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        color: Color.fromARGB(255, 232, 243, 235),
                        child: Padding(
                          padding: EdgeInsets.all(16.0 * scale),
                          child: ElevatedButton(
                            onPressed: () {
                              if (snapshot.isCircle == false) {
                                if (billerCode != "" && billerName != "") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => LandlineFormPage(
                                            circleCode: circleCode,
                                            billerName: '${billerName}',
                                            billerCode: '${billerCode}',
                                          ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        "Select Provider",
                                        style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                if (billerCode != "" &&
                                    billerName != "" &&
                                    circleCode != "") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => LandlineFormPage(
                                            circleCode: circleCode,
                                            billerName: '${billerName}',
                                            billerCode: '${billerCode}',
                                          ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        "Select Provider & Circle",
                                        style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25 * scale),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 14 * scale,
                              ),
                              minimumSize: Size(double.infinity, 45 * scale),
                            ),
                            child: Text(
                              'Continue',
                              style: GoogleFonts.inter(
                                fontSize: 18 * scale,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      if (snapshot.oldBills.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.05,
                            vertical: width * 0.025,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Recent Bills',
                              style: GoogleFonts.inter(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      if (snapshot.oldBills.isNotEmpty)
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                            bottom: width * 0.05,
                            right: width * 0.02,
                            left: width * 0.02,
                          ),
                          itemCount: snapshot.oldBills.length > 3 ? 2 : 1,
                          itemBuilder: (context, index) {
                            final transaction = snapshot.oldBills[index];
                            return TransactionCard(transaction: transaction);
                          },
                        ),
                    ],
                  );
                },
                error: (err, stack) {
                  return Center(child: Text("$err, $stack"));
                },
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}