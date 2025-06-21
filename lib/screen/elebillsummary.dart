import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:home/data/controller/fetchBills.provider.dart';
import 'package:home/data/model/checkCopoun.model.dart';
import 'package:home/data/model/fetchBill.model.dart';
import 'package:home/data/model/paynow.model.dart';
import 'package:home/screen/biller.dart';
import 'package:home/screen/waterbill3.dart';
import 'package:intl/intl.dart';

class EleBillSummary extends ConsumerStatefulWidget {
  final String billerCode;
  final String billerName;
  final String accountNumber;

  EleBillSummary({
    required this.accountNumber,
    required this.billerCode,
    required this.billerName,
  });

  @override
  ConsumerState<EleBillSummary> createState() => _EleBillSummaryState();
}

class _EleBillSummaryState extends ConsumerState<EleBillSummary> {
  final Color buttonColor = const Color.fromARGB(255, 68, 128, 106);
  late final FetchBodymodel fetchRequest;
  final TextEditingController _controller = TextEditingController();
  bool isInvalid = false;

  bool btnLoder = false;
  final TextEditingController _couponController = TextEditingController();
  String _couponMessage = '';
  double _discount = 0.0;

  void _applyCoupon() async {
    // Dummy check
  }

  @override
  void initState() {
    super.initState();
    fetchRequest = FetchBodymodel(
      path: 'b2c_bills_electricity',
      data: FetchBillModel(
        ipAddress: "152.59.109.59",
        macAddress: "not found",
        latitude: "26.917979",
        longitude: "75.814593",
        billerCode: widget.billerName,
        billerName: widget.billerCode,
        param1: widget.accountNumber,
        param2: "",
        param3: "",
        param4: "",
        param5: "",
      ),
    );
  }

  bool applyBtnLoder = false;

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

                  // Card with billing details
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
                                //   'assets/elect.png',
                                //   height: 40 * scale,
                                // ),
                                SizedBox(width: 10 * scale),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      truncateString(
                                        widget.billerName,
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
                                    snap.customerName ?? "No name",
                                    snap.billNo.toString(),
                                    formattedDate,
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
                                child: TextField(
                                  controller: TextEditingController(
                                    text: '₹${snap.billAmount ?? ""}',
                                  ),
                                  readOnly: true,
                                  showCursor: false,
                                  decoration: const InputDecoration.collapsed(
                                    hintText: '',
                                  ),
                                  style: TextStyle(
                                    fontSize: 22 * scale,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 18.w, right: 18.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'Gift card or discount code',
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                  color: isInvalid ? Colors.red : Colors.grey,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                  color: isInvalid ? Colors.red : Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                  color: isInvalid ? Colors.red : Colors.black,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              applyBtnLoder = true;
                            });
                            final state = APIStateNetwork(await createDio());
                            final response = await state.checkCoupn(
                              CheckCouponModel(
                                ipAddress: "152.59.109.59",
                                macAddress: "not found",
                                latitude: "26.917979",
                                longitude: "75.814593",
                                billerCode: widget.billerName,
                                billerName: widget.billerCode,
                                param1: widget.accountNumber,
                                transAmount: double.parse(snap.billAmount ?? "0.00").toInt().toString(),
                                couponCode: _controller.text.trim(),
                              ),
                            );
                            if(response.response.data['status'] == true){
                              setState(() {
                                applyBtnLoder = false;
                              });
                              ref.refresh(fetchBillDataProvider(fetchRequest));
                              Fluttertoast.showToast(msg: response.response.data['status_desc'], backgroundColor: Colors.black, textColor: Colors.white);
                            }else{
                              setState(() {
                                applyBtnLoder = false;
                              });
                              Fluttertoast.showToast(msg: response.response.data['status_desc'], backgroundColor: Colors.black, textColor: Colors.white);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: applyBtnLoder == true? CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ) : Text(
                            'Apply',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  Padding(
                    padding: EdgeInsets.all(16.0 * scale),
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          btnLoder = true;
                        });
                        final service = APIStateNetwork(await createDio());
                        final reponse = await service.payNow(
                          'b2c_bills_electricity',
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
                                          builder: (_) => Biller(),
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
                                          builder: (_) => Biller(),
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
          return Center(child: Text("$err"));
        },
        loading: () => Center(child: CircularProgressIndicator()),
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
