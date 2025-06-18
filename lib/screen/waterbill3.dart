import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:home/data/controller/fetchBills.provider.dart';
import 'package:home/data/model/fetchBill.model.dart';
import 'package:home/data/model/paynow.model.dart';
import 'package:home/screen/waterbill1.dart';
import 'package:intl/intl.dart';

class WaterBill3 extends ConsumerStatefulWidget {
  final String billerName;
  final String bilerCode;
  final String accountNumber;

  WaterBill3({
    required this.accountNumber,
    required this.billerName,
    required this.bilerCode,
  });

  @override
  ConsumerState<WaterBill3> createState() => _WaterBill3State();
}

class _WaterBill3State extends ConsumerState<WaterBill3> {
  final Color buttonColor = const Color.fromARGB(255, 68, 128, 106);

  late final FetchBodymodel fetchRequest;
  bool btnLoder = false;
  @override
  void initState() {
    super.initState();
    fetchRequest = FetchBodymodel(
      path: 'b2c_bills_water',
      data: FetchBillModel(
        ipAddress: "152.59.109.59",
        macAddress: "not found",
        latitude: "26.917979",
        longitude: "75.814593",
        billerCode: widget.billerName,
        billerName: widget.bilerCode,
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
    final String formattedDate = DateFormat(
      'dd-MM-yyyy',
    ).format(DateTime.now());
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
                      vertical: 10 * scale,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height: 40 * scale,
                              width: 40 * scale,
                              padding: EdgeInsets.all(8 * scale),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.black,
                                size: 21 * scale,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "BILL Summary",
                            style: GoogleFonts.inter(
                              fontSize: 16 * scale,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
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
                            Row(
                              children: [
                                // Image.asset(
                                //   'assets/av.png',
                                //   height: 40 * scale,
                                // ),
                                SizedBox(width: 10 * scale),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      truncateString(
                                        widget.bilerCode,
                                        26,
                                        addEllipsis: true,
                                      ),

                                      style: GoogleFonts.inter(
                                        fontSize: 14 * scale,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
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
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10 * scale),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _infoColumn([
                                  "Customer Name",
                                  "Bill Number",
                                  "Bill Date",
                                ], scale),
                                _infoColumn(
                                  [
                                    "${snap.customerName ?? "No Name"}", // You can replace these with actual response values: snap.customerName etc.
                                    "${snap.billNo}",
                                    "$formattedDate",
                                  ],
                                  scale,
                                  alignRight: true,
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
                                child: Text(
                                  '₹${snap.billAmount ?? 0}', // Replace with: '₹${snap.amount}'
                                  style: TextStyle(
                                    fontSize: 22 * scale,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Payment Button
                  Padding(
                    padding: EdgeInsets.all(16.0 * scale),
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          btnLoder = true;
                        });
                        final service = APIStateNetwork(await createDio());
                        final reponse = await service.payNow(
                          'b2c_bills_water',
                          PayNowModel(
                            ipAddress: "152.59.109.59",
                            macAddress: "not found",
                            latitude: "26.917979",
                            longitude: "75.814593",
                            billerCode: widget.billerName,
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
                        if (reponse.response.data["status"] == false) {
                          setState(() {
                            btnLoder = false;
                          });
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Payment Faild',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: Text(
                                  '${reponse.response.data["status_desc"]}',
                                  style: GoogleFonts.inter(),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => WaterBill(),
                                        ),
                                        (route) => false,
                                      );
                                    },
                                    child: Text(
                                      'OK',
                                      style: GoogleFonts.inter(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
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
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Payment Successful',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: Text(
                                  '${reponse.response.data["status_desc"]}',
                                  style: GoogleFonts.inter(),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => WaterBill(),
                                        ),
                                        (route) => false,
                                      );
                                    },
                                    child: Text(
                                      'OK',
                                      style: GoogleFonts.inter(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
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
                      child:
                          btnLoder == false
                              ? Text(
                                'Proceed to pay',
                                style: GoogleFonts.inter(
                                  fontSize: 18 * scale,
                                  color: Colors.white,
                                ),
                              )
                              : Center(
                                child: CircularProgressIndicator(
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
          return Center(child: Text("Error: $err"));
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _infoColumn(
    List<String> items,
    double scale, {
    bool alignRight = false,
  }) {
    return Column(
      crossAxisAlignment:
          alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children:
          items
              .map(
                (item) => Padding(
                  padding: EdgeInsets.only(bottom: 6 * scale),
                  child: Text(
                    item,
                    style: GoogleFonts.inter(
                      fontSize: 11 * scale,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
              .toList(),
    );
  }
}

String truncateString(String text, int maxLength, {bool addEllipsis = true}) {
  if (text.length <= maxLength) {
    return text;
  }

  // Agar ellipsis add karna hai to uske liye jagah chhodi jayegi
  return addEllipsis
      ? text.substring(0, maxLength - 3) + '...'
      : text.substring(0, maxLength);
}
