import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/data/controller/lic.provider.dart';
import 'package:home/data/controller/pip.gas.provider.dart';
import 'package:home/data/model/electritysityModel.dart';
import 'package:home/screen/biller.dart';
import 'package:home/screen/home_page.dart';

import 'package:home/screen/order.details.page.dart';
import 'package:home/screen/summerysPages/fastagForm.page.dart';
import 'package:home/screen/summerysPages/insuranceForm.page.dart';
import 'package:home/screen/summerysPages/pipeGasFrom.page.dart'; // Make sure this file exists and accepts the accountNumber parameter





class PipeGasPage extends ConsumerStatefulWidget {
  const PipeGasPage({super.key});

  @override
  ConsumerState<PipeGasPage> createState() => _PipeGasPageState();
}

class _PipeGasPageState extends ConsumerState<PipeGasPage> {
    final Color buttonColor = const Color.fromARGB(255, 68, 128, 106);
  String billerName = '';
  String billerCode = '';
  String circleCode = '';
  @override
  Widget build(BuildContext context) {
    final electricityProvider = ref.watch(pipGasProvider);
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
                          "Pipe Gas",
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
                                          (_) => PipeGasForm(
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
                                          (_) => PipeGasForm(
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

  void showCircleBottomSheet(
    BuildContext context,
    List<CircleList> circles,
    Function(CircleList) onSelect,
    String billername,
  ) {
    final Color buttonColor = const Color.fromRGBO(68, 128, 106, 1);
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 375;
    final TextEditingController searchController = TextEditingController();
    String searchQuery = '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (_, controller) {
            return Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 243, 235),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Top drag handle
                        Container(
                          height: 5,
                          width: 50,
                          margin: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                        // Title with animation
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 10,
                          ),
                          child: AnimatedOpacity(
                            opacity: 1.0,
                            duration: Duration(milliseconds: 500),
                            child: Text(
                              billername,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 16),

                        // Search Field with modern design
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                              });
                            },

                            decoration: InputDecoration(
                              hintText: "Search circle...",
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              suffixIcon:
                                  searchQuery.isNotEmpty
                                      ? IconButton(
                                        icon: Icon(
                                          Icons.clear,
                                          color: Colors.grey.shade600,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            searchController.clear();
                                            searchQuery = '';
                                          });
                                        },
                                      )
                                      : null,
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                            ),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),

                        SizedBox(height: 16),

                        Container(
                          constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.59,
                          ),
                          child:
                              circles.isNotEmpty
                                  ? ListView.separated(
                                    controller: controller,
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    itemCount:
                                        circles
                                            .where(
                                              (circle) => circle.circleName
                                                  .toLowerCase()
                                                  .contains(
                                                    searchQuery.toLowerCase(),
                                                  ),
                                            )
                                            .length,
                                    separatorBuilder:
                                        (_, __) => Divider(
                                          color: Colors.grey.shade200,
                                          height: 1,
                                        ),
                                    itemBuilder: (context, index) {
                                      final filteredCircles =
                                          circles
                                              .where(
                                                (circle) => circle.circleName
                                                    .toLowerCase()
                                                    .contains(
                                                      searchQuery.toLowerCase(),
                                                    ),
                                              )
                                              .toList()
                                            ..sort(
                                              (a, b) => a.circleName
                                                  .toLowerCase()
                                                  .compareTo(
                                                    b.circleName.toLowerCase(),
                                                  ),
                                            );
                                      final circle = filteredCircles[index];

                                      return AnimatedOpacity(
                                        opacity: 1.0,
                                        duration: Duration(
                                          milliseconds: 300 + (index * 100),
                                        ),
                                        child: Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: ListTile(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 8,
                                                ),
                                            leading: CircleAvatar(
                                              backgroundColor: Colors.black
                                                  .withOpacity(0.1),
                                              child: Icon(
                                                Icons.location_on_rounded,
                                                color: Colors.black,
                                              ),
                                            ),
                                            title: Text(
                                              circle.circleName,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.pop(context);
                                              onSelect(circle);
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                  : Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.search_off,
                                          size: 50,
                                          color: Colors.grey.shade400,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          "No matching circles found.",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                        ),


                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Close',
                              style: TextStyle(
                                fontSize: 18 * scale,
                                color: Colors.white,
                              ),
                            ),
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
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {

      searchController.dispose();
    });
  }
}

class TransactionCard extends StatelessWidget {
  final OldBill transaction;

  const TransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (_) => PaymentDetailsScreen(trnxId: '${transaction.transId}'),
          ),
        );
      },
      child: Card(
        elevation: 0,
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Transaction Logo
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  transaction.transLogo,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          Icon(Icons.error, size: 50, color: Colors.grey),
                ),
              ),
              SizedBox(width: 16),
              // Transaction Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.serviceProvider,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Last Paid: ${transaction.transDate}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),

                    SizedBox(height: 4),
                    Text(
                      '${transaction.serviceAccount}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹${transaction.transAmount}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color:
                                transaction.transStatus == 'SUCCESS'
                                    ? Colors.green[100]
                                    : Colors.red[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            transaction.transStatus,
                            style: TextStyle(
                              fontSize: 12,
                              color:
                                  transaction.transStatus == 'SUCCESS'
                                      ? Colors.green[800]
                                      : Colors.red[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}