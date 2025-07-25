import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/data/controller/loanRepayment.provider.dart';
import 'package:home/screen/biller.dart';
import 'package:home/screen/home_page.dart';
import 'package:home/screen/muthoothfin.dart'; // Replace with correct path

class LenderSelectionScreen extends ConsumerStatefulWidget {
  @override
  _LenderSelectionScreenState createState() => _LenderSelectionScreenState();
}

class _LenderSelectionScreenState extends ConsumerState<LenderSelectionScreen> {
  bool showFilter = false;
  bool filterApplied = false;
  String selectedFilter = '';

  final List<String> lenders = [
    'Muthoot Finance',
    'Bajaj Finance',
    'DMI Finance',
    'Bajaj Finance',
    'DMI Finance',
    'HDFC Finance',
  ];

  final Map<String, String> lenderLogos = {
    'Muthoot Finance': 'assets/mutooth.png',
    'Bajaj Finance': 'assets/baj.png',
    'DMI Finance': 'assets/dmi.png',
    'HDFC Finance': 'assets/hdfc1.png',
  };

  final List<String> filters = [
    'Gold Loan',
    'Home Loan',
    'Bank',
    'Small finance Bank',
    'Consumer Loan',
    'Vehicle Loan',
    'Other',
  ];
  final Color buttonColor = const Color.fromARGB(255, 68, 128, 106);
  String billerName = '';
  String billerCode = '';
  String circleCode = '';
  @override
  Widget build(BuildContext context) {
    final loan = ref.watch(loanRepaynentProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 375;
        final width = MediaQuery.of(context).size.width;
            final searchQuery = ref.watch(searchQueryProvider);
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
                            'Select your Lender',
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

                loan.when(
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
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.03,
                          ),
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
                                      (context) => MuthootFinScreen(
                                        circleCode: circleCode, billerName:  billerName, billerCode:  billerCode,
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
                                      (context) => MuthootFinScreen(
                                        circleCode: circleCode, billerName:  billerName, billerCode:  billerCode,
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
                                  borderRadius: BorderRadius.circular(
                                    25 * scale,
                                  ),
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
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        ),
      );
  }
}



// Stack(
//             children: [
//               Container(color: const Color.fromARGB(255, 232, 243, 235)),

//               if (showFilter)
//                 AnimatedOpacity(
//                   duration: const Duration(milliseconds: 300),
//                   opacity: 0.3,
//                   child: Container(color: Colors.black),
//                 ),

//               Column(
//                 children: [
//                   const SizedBox(height: 150),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: TextField(
//                             decoration: InputDecoration(
//                               hintText: 'Search by lender',
//                               prefixIcon: const Icon(Icons.search, size: 30),
//                               filled: true,
//                               fillColor: Colors.white,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide.none,
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide.none,
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide.none,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               showFilter = true;
//                             });
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: const Icon(
//                               Icons.filter_list,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Expanded(
//                     child: ListView.builder(
//                       padding: const EdgeInsets.all(12),
//                       itemCount: snap.billersList.length,
//                       itemBuilder: (context, index) {
//                         final lender = snap.billersList[index];
//                         return Container(
//                           margin: const EdgeInsets.only(bottom: 12),
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(12),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black12,
//                                 blurRadius: 4,
//                                 offset: const Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           child: ListTile(
//                             contentPadding: EdgeInsets.zero,
//                             // leading: Image.asset(
//                             //  'assets/default.png',
//                             //   width: 30,
//                             //   height: 30,
//                             // ),
//                             title: Text(
//                               lender.billerName,
//                               style: GoogleFonts.inter(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             onTap: () {
                             
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder:
//                                       (context) => MuthootFinScreen(
//                                         accountNumber: '123456789012', billerName:  snap.billersList[index].billerName.toString(), billerCode:  snap.billersList[index].billerCode.toString(),
//                                       ),
//                                 ),
//                               );
//                             },
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),

//               // Filter Bottom Sheet
//               // AnimatedPositioned(
//               //   duration: const Duration(milliseconds: 500),
//               //   curve: Curves.easeInOut,
//               //   bottom: showFilter ? 0 : -350,
//               //   left: 0,
//               //   right: 0,
//               //   child: Container(
//               //     padding: const EdgeInsets.all(16),
//               //     decoration: const BoxDecoration(
//               //       color: Color.fromARGB(255, 225, 246, 236),
//               //       boxShadow: [
//               //         BoxShadow(
//               //           color: Colors.black26,
//               //           blurRadius: 10,
//               //           offset: Offset(0, -2),
//               //         ),
//               //       ],
//               //       borderRadius: BorderRadius.vertical(
//               //         top: Radius.circular(20),
//               //       ),
//               //     ),
//               //     child: Column(
//               //       mainAxisSize: MainAxisSize.min,
//               //       children: [
//               //         Wrap(
//               //           spacing: 8,
//               //           runSpacing: 8,
//               //           children:
//               //               filters.map((filter) {
//               //                 final isSelected = selectedFilter == filter;
//               //                 return ChoiceChip(
//               //                   label: Text(
//               //                     filter,
//               //                     style: TextStyle(
//               //                       color:
//               //                           isSelected
//               //                               ? Colors.white
//               //                               : Colors.black,
//               //                     ),
//               //                   ),
//               //                   selected: isSelected,
//               //                   selectedColor: const Color.fromARGB(
//               //                     255,
//               //                     68,
//               //                     128,
//               //                     106,
//               //                   ),
//               //                   backgroundColor: const Color.fromARGB(
//               //                     255,
//               //                     232,
//               //                     243,
//               //                     235,
//               //                   ),
//               //                   showCheckmark: false,
//               //                   onSelected: (bool selected) {
//               //                     setState(() {
//               //                       selectedFilter = selected ? filter : '';
//               //                     });
//               //                   },
//               //                 );
//               //               }).toList(),
//               //         ),
//               //         const SizedBox(height: 20),
//               //         // SizedBox(
//               //         //   width: double.infinity,
//               //         //   child: ElevatedButton(
//               //         //     onPressed: () {
//               //         //       if (selectedFilter.isNotEmpty) {
                              
//               //         //       } else {
//               //         //         ScaffoldMessenger.of(context).showSnackBar(
//               //         //           const SnackBar(
//               //         //             content: Text(
//               //         //               'Please select a filter to proceed.',
//               //         //             ),
//               //         //           ),
//               //         //         );
//               //         //       }

//               //         //       setState(() {
//               //         //         showFilter = false;
//               //         //         filterApplied = true;
//               //         //       });
//               //         //     },
//               //         //     style: ElevatedButton.styleFrom(
//               //         //       backgroundColor: const Color.fromARGB(
//               //         //         255,
//               //         //         68,
//               //         //         128,
//               //         //         106,
//               //         //       ),
//               //         //       padding: const EdgeInsets.symmetric(vertical: 14),
//               //         //     ),
//               //         //     child: Text(
//               //         //       'Apply Filter',
//               //         //       style: GoogleFonts.inter(
//               //         //         color: Colors.white,
//               //         //         fontSize: 15,
//               //         //       ),
//               //         //     ),
//               //         //   ),
//               //         // ),
//               //       ],
//               //     ),
//               //   ),
//               // ),
//             ],
//           )