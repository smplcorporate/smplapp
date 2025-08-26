import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:home/data/controller/billerParam.notier.dart';
import 'package:home/data/controller/fetchBills.provider.dart';
import 'package:home/data/model/checkCopoun.model.dart';
import 'package:home/data/model/fetchBill.model.dart';
import 'package:home/data/model/payNowMobilePrepaid.model.dart';
import 'package:home/data/model/paynow.model.dart';
import 'package:home/screen/elebillsummary.dart';
import 'package:home/screen/order.details.page.dart';
import 'package:home/screen/waterbill1.dart';
import 'package:intl/intl.dart';

class MobilePrepaid3 extends ConsumerStatefulWidget {
  final FetchBodymodel body;

  MobilePrepaid3({Key? key, required this.body}) : super(key: key);

  @override
  ConsumerState<MobilePrepaid3> createState() => _MobilePrepaid3State();
}

class _MobilePrepaid3State extends ConsumerState<MobilePrepaid3> {
  final Color buttonColor = const Color.fromARGB(255, 68, 128, 106);

  late final FetchBodymodel fetchRequest;
  late final FetchBllerParam fetchBillerParam;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _mpinControllr = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final _coponKey = GlobalKey<FormState>();
  bool btnLoder = false;
  @override
  void initState() {
    super.initState();
  }

  bool coupnApplyed = false;

  bool applyBtnLoder = false;
  bool isInvalid = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 375;
    final String formattedDate = DateFormat(
      'dd-MM-yyyy',
    ).format(DateTime.now());
    final params = ref.watch(paramsProvider);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 243, 235),
      body: Form(
        key: _formKey,
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 232, 243, 235),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
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
                            "Bill Summary",
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
                  // Padding(
                  //   padding: EdgeInsets.all(16.0 * scale),
                  //   child: Card(
                  //     color: Colors.white,
                  //     elevation: 4,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(12 * scale),
                  //     ),
                  //     child: Padding(
                  //       padding: EdgeInsets.all(16.0 * scale),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Row(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               SizedBox(width: 10 * scale),
                  //               Expanded(
                  //                 // Makes the text wrap properly within available space
                  //                 child: Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text(
                  //                       truncateString(
                  //                         fetchRequest.data.billerName,
                  //                         300,
                  //                         addEllipsis: true,
                  //                       ),
                  //                       softWrap: true,
                  //                       overflow: TextOverflow.visible,
                  //                       style: GoogleFonts.inter(
                  //                         fontSize: 14 * scale,
                  //                         color: Colors.black,
                  //                         fontWeight: FontWeight.bold,
                  //                       ),
                  //                     ),
                  //                     const SizedBox(height: 4),
                  //                     Text(
                  //                       fetchRequest.data.param1,
                  //                       softWrap: true,
                  //                       overflow: TextOverflow.visible,
                  //                       style: GoogleFonts.inter(
                  //                         fontSize: 13 * scale,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           Padding(
                  //             padding: EdgeInsets.only(left: 12),
                  //             child: Column(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               crossAxisAlignment:
                  //                   CrossAxisAlignment.start,
                  //               children: [
                  //                 if (params.param2.isNotEmpty)
                  //                   _buildDetailRow(params.param2, ""),
                  //                 if (params.param3.isNotEmpty)
                  //                   _buildDetailRow(params.param3, ""),
                  //                 if (params.param4.isNotEmpty)
                  //                   _buildDetailRow(params.param4, ""),
                  //                 if (params.param5.isNotEmpty)
                  //                   _buildDetailRow(params.param5, ""),
                  //               ],
                  //             ),
                  //           ),
                  //           SizedBox(height: 20 * scale),
                  //           Text(
                  //             'Billing Details',
                  //             style: GoogleFonts.inter(
                  //               fontSize: 15 * scale,
                  //               color: Colors.black,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //           SizedBox(height: 10 * scale),

                  //           Row(
                  //             mainAxisAlignment:
                  //                 MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               _infoColumn([
                  //                 if (snap.customerName != null ||
                  //                     snap.customerName!.isNotEmpty)
                  //                   "Customer Name",
                  //                 if (snap.billNo.isNotEmpty) "Bill Number",
                  //                 if (snap.billDate.isNotEmpty) "Bill Date",
                  //                 if (snap.dueDate.trim().isNotEmpty) ...[
                  //                   "Bill Due Date",
                  //                 ],
                  //               ], scale),
                  //               _infoColumn(
                  //                 [
                  //                   if (snap.customerName != null ||
                  //                       snap.customerName!.isNotEmpty)
                  //                     snap.customerName ?? "No name",
                  //                   if (snap.billNo.isNotEmpty)
                  //                     snap.billNo.toString(),
                  //                   if (snap.billDate.isNotEmpty)
                  //                     snap.billDate,
                  //                   if (snap.dueDate.trim().isNotEmpty) ...[
                  //                     snap.dueDate.toString(),
                  //                   ],
                  //                 ],
                  //                 scale,
                  //                 alignRight: true,
                  //               ),
                  //             ],
                  //           ),
                  //           SizedBox(height: 20 * scale),
                  //           Container(
                  //             width: double.infinity,
                  //             padding: EdgeInsets.symmetric(
                  //               vertical: 12 * scale,
                  //             ),
                  //             decoration: BoxDecoration(
                  //               color: const Color.fromARGB(
                  //                 255,
                  //                 232,
                  //                 243,
                  //                 235,
                  //               ),
                  //               border: Border.all(
                  //                 color: Colors.grey.shade300,
                  //               ),
                  //               borderRadius: BorderRadius.circular(
                  //                 10 * scale,
                  //               ),
                  //             ),
                  //             child: Center(
                  //               child: TextField(
                  //                 controller: TextEditingController(
                  //                   text: '₹${snap.billAmount ?? ""}',
                  //                 ),
                  //                 readOnly: true,
                  //                 showCursor: false,
                  //                 decoration:
                  //                     const InputDecoration.collapsed(
                  //                       hintText: '',
                  //                     ),
                  //                 style: TextStyle(
                  //                   fontSize: 22 * scale,
                  //                   fontWeight: FontWeight.bold,
                  //                   color: Colors.black,
                  //                 ),
                  //                 textAlign: TextAlign.center,
                  //                 keyboardType: TextInputType.none,
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // _buildBillDetailsParamCard(params),
                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 23 * scale),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 232, 243, 235),
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10 * scale),
                    ),
                    child: Center(
                      child: TextField(
                        controller: _amountController,
                        readOnly: false,
                        showCursor: true,
                        decoration: const InputDecoration.collapsed(
                          hintText: '',
                        ),
                        style: TextStyle(
                          fontSize: 22 * scale,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 18.w, right: 18.w),
                    child: Form(
                      key: _coponKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  readOnly: coupnApplyed,
                                  controller: _controller,
                                  maxLength: 15, // Max length 15 characters
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[A-Za-z0-9]'),
                                    ),
                                    UpperCaseTextFormatter(),
                                    LengthLimitingTextInputFormatter(15),
                                  ],
                                  decoration: InputDecoration(
                                    hintText: 'Gift card or discount code',
                                    counterText: '', // Hide character counter
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 14,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                        color:
                                            isInvalid
                                                ? Colors.red
                                                : Colors.grey,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                        color:
                                            isInvalid
                                                ? Colors.red
                                                : Colors.grey,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                        color:
                                            isInvalid
                                                ? Colors.red
                                                : Colors.black,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Code is required";
                                    }
                                    if (value.length < 5) {
                                      return "Minimum 5 characters required";
                                    }
                                    if (value.length > 15) {
                                      return "Maximum 15 characters allowed";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () async {
                                  if (applyBtnLoder == false) {
                                    if (_coponKey.currentState!.validate()) {
                                      if (_controller.text.isEmpty ||
                                          _controller.text.trim().isEmpty) {
                                        Fluttertoast.showToast(
                                          msg: "Coupon code is required",
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                        );
                                      } else {
                                        if (coupnApplyed == false) {
                                          setState(() {
                                            applyBtnLoder = true;
                                          });
                                          final state = APIStateNetwork(
                                            await createDio(),
                                          );
                                          final response = await state
                                              .checkCoupnMobilePrepaid(
                                                CheckCouponModel(
                                                  ipAddress: "152.59.109.59",
                                                  macAddress: "not found",
                                                  latitude: "26.917979",
                                                  longitude: "75.814593",
                                                  billerCode:
                                                      fetchRequest
                                                          .data
                                                          .billerCode,
                                                  billerName:
                                                      fetchRequest
                                                          .data
                                                          .billerName,
                                                  param1:
                                                      fetchRequest.data.param1,
                                                  transAmount:
                                                      double.parse(
                                                        " 0.00" ?? "0.00",
                                                      ).toInt().toString(),
                                                  couponCode:
                                                      _controller.text.trim(),
                                                ),
                                              );
                                          if (response
                                                  .response
                                                  .data['status'] ==
                                              true) {
                                            setState(() {
                                              applyBtnLoder = false;
                                              coupnApplyed = true;
                                            });
                                            log("Trsing1");

                                            Fluttertoast.showToast(
                                              msg:
                                                  response
                                                      .response
                                                      .data['status_desc'],
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                            );
                                          } else {
                                            setState(() {
                                              applyBtnLoder = false;
                                              _controller.clear();
                                            });
                                            log("Trsing2");
                                            Fluttertoast.showToast(
                                              msg:
                                                  response
                                                      .response
                                                      .data['status_desc'],
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                            );
                                          }
                                        } else {
                                          setState(() {
                                            coupnApplyed = false;
                                            _controller.clear();
                                          });
                                        }
                                      }
                                    }
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
                                child:
                                    applyBtnLoder == true
                                        ? CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2.5,
                                        )
                                        : Text(
                                          coupnApplyed == false
                                              ? 'Apply'
                                              : 'Remove',
                                          style: TextStyle(color: Colors.white),
                                        ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          if (coupnApplyed == true) ...[
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20),
                              ),

                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 6,
                                  right: 6,
                                  top: 2,
                                  bottom: 2,
                                ),
                                child: Text(
                                  "Coupon Applied",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.only(left: 18.w, right: 18.w),
                    child: TextFormField(
                      obscureText: true,
                      controller: _mpinControllr,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }
                        if (value.length < 6) {
                          return "MPIN must be at least 6 digits";
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // Only digits 0-9
                        LengthLimitingTextInputFormatter(
                          6,
                        ), //Enforce length limit
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter your mpin',
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

                  SizedBox(height: 16),

                  Padding(
                    padding: EdgeInsets.all(16.0 * scale),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (btnLoder == false) {
                          if (_controller.text.isNotEmpty &&
                              coupnApplyed == false) {
                            Fluttertoast.showToast(
                              msg: "Please apply coupon code first",
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                            );
                          } else {
                            if (_formKey.currentState!.validate()) {
                              if (_mpinControllr.text.isEmpty ||
                                  _mpinControllr.text == "") {
                                Fluttertoast.showToast(
                                  msg: "Mpin is required",
                                  textColor: Colors.white,
                                  backgroundColor: Colors.red,
                                );
                              } else {
                                setState(() {
                                  btnLoder = true;
                                });
                                final box = Hive.box('userdata');
                                final mobile = box.get('@mobile');
                                final service = APIStateNetwork(
                                  await createDio(),
                                );
                                // final reponse = await service.payNow(
                                //   'b2c_prepaid_dth',
                                //   PayNowModel(
                                //     ipAddress: "152.59.109.59",
                                //     macAddress: "not found",
                                //     latitude: "26.917979",
                                //     longitude: "75.814593",
                                //     billerCode: fetchRequest.data.billerCode,
                                //     billerName: fetchRequest.data.billerName,
                                //     circleCode: fetchRequest.data.circleCode,
                                //     param1: fetchRequest.data.param1,
                                //     param2: fetchRequest.data.param2,
                                //     param3: fetchRequest.data.param3,
                                //     param4: fetchRequest.data.param4,
                                //     param5: fetchRequest.data.param5,
                                //     customerName: snap.customerName ?? "",
                                //     billNo: snap.billNo,
                                //     dueDate: snap.dueDate,
                                //     billDate: snap.billDate,
                                //     billAmount: snap.billAmount.toString(),
                                //     returnTransid:
                                //         snap.returnTransid.toString(),
                                //     returnFetchid: snap.returnFetchid,
                                //     returnBillid: snap.returnBillid,
                                //     couponCode:
                                //         coupnApplyed == true
                                //             ? _controller.text.trim()
                                //             : "",
                                //     userMpin: "${_mpinControllr.text}",
                                //   ),
                                // );
                                final reponse = await service.payMobileRecharge(
                                  PaymentRequest(
                                    ipAddress: "127.0.0.1",
                                    macAddress: "Not found",
                                    latitude: "27.033342",
                                    longitude: "37.0342434",
                                    billerCode: widget.body.data.billerCode,
                                    billerName: widget.body.data.billerName,
                                    param1: widget.body.data.param1,
                                    transAmount: _amountController.text,
                                    userMpin: _mpinControllr.text,
                                    circleCode: widget.body.data.circleCode,
                                    param2: "",

                                    couponCode:
                                        coupnApplyed == true
                                            ? _controller.text
                                            : "",
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
                                          '',
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
                                            },
                                            child: Text(
                                              'OK',
                                              style: GoogleFonts.inter(
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).primaryColor,
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
                                          '${reponse.response.data['trans_status']}',
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
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (
                                                        _,
                                                      ) => PaymentDetailsScreen(
                                                        trnxId:
                                                            '${reponse.response.data['trans_id']}',
                                                      ),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              'OK',
                                              style: GoogleFonts.inter(
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                            }
                          }
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
                                'Proceed to Pay',
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
          ),
        ),
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

_buildDetailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(top: 1.5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: Text(label, style: TextStyle(color: Colors.grey[900])),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    ),
  );
}
