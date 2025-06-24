import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:home/data/controller/fetchBills.provider.dart';
import 'package:home/data/model/fetchBill.model.dart';
import 'package:home/data/model/paynow.model.dart';
import 'package:home/screen/home_page.dart';
import 'package:home/screen/lender2.dart';

class MuthootSummaryPage extends ConsumerStatefulWidget {
  final String accountNumber;
  final String billerCode;
  final String billerName;

  MuthootSummaryPage({
    required this.accountNumber,
    required this.billerCode,
    required this.billerName,
  });

  @override
  ConsumerState<MuthootSummaryPage> createState() => _MuthootSummaryPageState();
}

class _MuthootSummaryPageState extends ConsumerState<MuthootSummaryPage> {
  final Color buttonColor = const Color.fromARGB(255, 68, 128, 106);
  late final FetchBodymodel fetchRequest;
  bool btnLoder = false;
  @override
  void initState() {
    super.initState();
    fetchRequest = FetchBodymodel(
      path: 'b2c_bills_loanrepayment',
      data: FetchBillModel(
        circleCode: "",
        ipAddress: "152.59.109.59",
        macAddress: "not found",
        latitude: "26.917979",
        longitude: "75.814593",
        billerCode: widget.billerCode,
        billerName: widget.billerName,
        param1: widget.accountNumber,
        param2: "",
        param3: "",
        param4: "",
        param5: "",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 375;
    final fetchBillerData = ref.watch(fetchBillDataProvider(fetchRequest));
    return Scaffold(
      body: fetchBillerData.when(
        data: (snap) {
          return Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 232, 243, 235),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0 * scale,
                      vertical: 20 * scale,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: EdgeInsets.all(8 * scale),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.black,
                                size: 18 * scale,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "${widget.billerName}",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 18 * scale,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Billing Card
                  Padding(
                    padding: EdgeInsets.all(16.0 * scale),
                    child: Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12 * scale),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0 * scale),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image + Name
                            Row(
                              children: [
                                // Image.asset(
                                //   'assets/mutooth.png',
                                //   height: 40 * scale,
                                // ),
                                SizedBox(width: 10 * scale),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.billerName,
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15 * scale,
                                      ),
                                    ),
                                    Text(
                                      widget.accountNumber,
                                      style: GoogleFonts.inter(
                                        fontSize: 13 * scale,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(height: 20 * scale),

                            Text(
                              'Billing Details',
                              style: GoogleFonts.inter(
                                fontSize: 15 * scale,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),

                            SizedBox(height: 10 * scale),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _infoLabel("Customer Name", scale),
                                    _infoLabel("Bill Number", scale),
                                    _infoLabel("Bill Date", scale),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    _infoValue("${snap.customerName}", scale),
                                    _infoValue("${snap.billNo}", scale),
                                    _infoValue("${snap.billDate}", scale),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(height: 20 * scale),

                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                vertical: 12 * scale,
                              ),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 232, 243, 235),
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10 * scale),
                              ),
                              child: Center(
                                child: TextField(
                                  controller: TextEditingController(
                                    text: '₹${snap.billAmount}',
                                  ),
                                  readOnly: true,
                                  showCursor: false,
                                  style: TextStyle(
                                    fontSize: 22 * scale,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.none,
                                  decoration: const InputDecoration.collapsed(
                                    hintText: '',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Proceed to Pay Button
                  Padding(
                    padding: EdgeInsets.all(16.0 * scale),
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          btnLoder = true;
                        });
                        final service = APIStateNetwork(await createDio());
                        final response = await service.payNow(
                          'b2c_bills_loanrepayment',
                          PayNowModel(
                            ipAddress: "152.59.109.59",
                            macAddress: "not found",
                            latitude: "26.917979",
                            longitude: "75.814593",
                            billerCode: widget.billerCode,
                            billerName: widget.billerName,
                            circleCode: "",
                            param1: widget.accountNumber,
                            param2: "",
                            param3: "",
                            param4: "",
                            param5: "",
                            customerName: snap.customerName ?? "",
                            billNo: snap.billNo,
                            dueDate: snap.dueDate,
                            billDate: snap.billDate,
                            billAmount: snap.billAmount.toString(),
                            returnTransid: snap.returnTransid.toString(),
                            returnFetchid: snap.returnFetchid,
                            returnBillid: snap.returnBillid,
                            couponCode: "",
                            userMpin: "123456",
                          ),
                        );
                        if (response.response.data["status"] == false) {
                          setState(() {
                            btnLoder = false;
                          });
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                title: Text(
                                  'Payment Faild',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    // color: const Color.fromARGB(255, 68, 128, 106),
                                  ),
                                ),
                                content: Text(
                                  '${response.response.data["status_desc"]}',
                                  style: GoogleFonts.inter(),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (_) => LenderSelectionScreen(),
                                        ),
                                        (route) => false,
                                      );
                                    },
                                    child: Text(
                                      'OK',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        // color: const Color.fromARGB(255, 68, 128, 106),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          setState(() {
                            btnLoder = false;
                          });
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                title: Text(
                                  'Payment Successful',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    // color: const Color.fromARGB(255, 68, 128, 106),
                                  ),
                                ),
                                content: Text(
                                  'Your payment has been successfully processed.',
                                  style: GoogleFonts.inter(),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (_) => LenderSelectionScreen(),
                                        ),
                                        (route) => false,
                                      );
                                    },
                                    child: Text(
                                      'OK',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        // color: const Color.fromARGB(255, 68, 128, 106),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25 * scale),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14 * scale),
                        minimumSize: Size(double.infinity, 45 * scale),
                      ),
                      child: btnLoder == true? CircularProgressIndicator(color: Colors.white,): Text(
                        'Proceed to pay',
                        style: GoogleFonts.inter(
                          fontSize: 18 * scale,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        error: (err, stack) {
          return Center(child: Text("$err"));
        },
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _infoLabel(String label, double scale) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6 * scale),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.bold,
          fontSize: 11 * scale,
        ),
      ),
    );
  }

  Widget _infoValue(String value, double scale) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6 * scale),
      child: Text(
        value,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 11 * scale,
        ),
      ),
    );
  }
}
