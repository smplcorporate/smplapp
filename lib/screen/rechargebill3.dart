import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:home/data/controller/mobilePrepaid.notifier.dart';
import 'package:home/data/model/checkCopoun.model.dart';
import 'package:home/data/model/mobileplanRes.model.dart';
import 'package:home/data/model/payNowMobilePrepaid.model.dart';

import 'package:home/screen/home_page.dart';
import 'package:home/screen/order.details.page.dart';
import 'package:home/screen/rechargebill.dart';
import 'package:home/screen/screen2.dart';
import 'package:home/screen/summerysPages/pipeGas.summery.page.dart';

class RechargePage3 extends ConsumerStatefulWidget {
  final PlanDatum plan;
  RechargePage3({Key? key, required this.plan}) : super(key: key);

  @override
  ConsumerState<RechargePage3> createState() => _RechargePage3State();
}

class _RechargePage3State extends ConsumerState<RechargePage3> {
  final Color buttonColor = const Color.fromARGB(255, 68, 128, 106);
  bool btnLoder = false;
  bool coupnApplyed = false;

  bool applyBtnLoder = false;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _mpinControllr = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final _coponKey = GlobalKey<FormState>();
  bool isInvalid = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _amountController.text = "${widget.plan.planAmount.toString()}";
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 375;
    final userBillerData = ref.read(billerProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 232, 243, 235),
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(
            left: 12 * scale,
            top: 8 * scale,
            bottom: 8 * scale,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black26, blurRadius: 4 * scale),
              ],
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 20 * scale,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 6 * scale),
          child: Text(
            'Recharge Bill',
            style: GoogleFonts.inter(
              fontSize: 18 * scale,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0 * scale),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(height: 16 * scale),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12 * scale),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8 * scale,
                        offset: Offset(0, 4 * scale),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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

                      SizedBox(height: 8 * scale),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Data: ${widget.plan.planAmount}",
                            style: GoogleFonts.inter(
                              fontSize: 12 * scale,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "validity: ${widget.plan.validity}",
                            style: GoogleFonts.inter(
                              fontSize: 12 * scale,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8 * scale),
                      Text(
                        "Plan Name: ${widget.plan.planName}",
                        style: GoogleFonts.inter(
                          fontSize: 12 * scale,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 12 * scale),
                      Text(
                        "${widget.plan.planDescription ?? ''}",
                        style: GoogleFonts.inter(
                          fontSize: 12 * scale,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 4.w, right: 4.w),
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
                                                userBillerData
                                                    .selectedBiller
                                                    ?.billerCode ??
                                                "",
                                            billerName:
                                                userBillerData
                                                    .selectedBiller
                                                    ?.billerName ??
                                                "",
                                            param1: userBillerData.number ?? "",
                                            transAmount: removeDotZero(
                                              _amountController.text,
                                            ),

                                            couponCode: _controller.text.trim(),
                                          ),
                                        );
                                    if (response.response.data['status'] ==
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
                                    coupnApplyed == false ? 'Apply' : 'Remove',
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
              padding: EdgeInsets.only(left: 4.w, right: 4.w),
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
                  FilteringTextInputFormatter.digitsOnly, // Only digits 0-9
                  LengthLimitingTextInputFormatter(6), //Enforce length limit
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
            Padding(
              padding: EdgeInsets.all(16.0 * scale),
              child: ElevatedButton(
                onPressed: () async {
                  if (btnLoder == false) {
                    if (_mpinControllr.text.trim().isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Enter mpin first",
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                      );
                    } else {
                      if (_controller.text.trim().isNotEmpty &&
                          coupnApplyed == false) {
                        Fluttertoast.showToast(
                          msg: "Please apply coupon code",
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                        );
                        return;
                      } else {
                        if (btnLoder == false) {
                          try {
                            setState(() {
                              btnLoder = true;
                            });
                            final api = APIStateNetwork(await createDio());
                            final response = await api.payMobileRecharge(
                              PaymentRequest(
                                ipAddress: "127.0.0.1",
                                macAddress: "Not found",
                                latitude: "27.033342",
                                longitude: "37.0342434",
                                billerCode:
                                    userBillerData.selectedBiller?.billerCode ??
                                    "",
                                billerName:
                                    userBillerData.selectedBiller?.billerName ??
                                    "",
                                param1: userBillerData.number ?? "",
                                transAmount: removeDotZero(
                                  _amountController.text.toString(),
                                ),
                                userMpin: _mpinControllr.text,
                                circleCode:
                                    userBillerData.selectedCircle?.circleId ??
                                    "",
                                param2: "",

                                couponCode:
                                    coupnApplyed == true
                                        ? _controller.text
                                        : "",
                              ),
                            );
                            if (response.response.data["status"] == false) {
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
                                      '${response.response.data["status_desc"]}',
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
                                                Theme.of(context).primaryColor,
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
                                      '${response.response.data['trans_status']}',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: Text(
                                      '${response.response.data["status_desc"]}',
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
                                                  (_) => PaymentDetailsScreen(
                                                    trnxId:
                                                        '${response.response.data['trans_id']}',
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'OK',
                                          style: GoogleFonts.inter(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          } on DioException {
                            setState(() {
                              btnLoder = false;
                            });
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
                          'Proceed to pay',
                          style: GoogleFonts.inter(
                            fontSize: 18 * scale,
                            color: Colors.white,
                          ),
                        )
                        : CircularProgressIndicator(color: Colors.white,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





// showDialog(
//                     context: context,
//                     builder: (ctx) {
//                       return AlertDialog(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         title: Text(
//                           'Payment Successful',
//                           style: GoogleFonts.inter(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         content: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               'Your payment has been successfully processed.',
//                               style: GoogleFonts.inter(),
//                               textAlign: TextAlign.center,
//                             ),
//                             SizedBox(height: 16 * scale),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 SizedBox(
//                                   height: 36 * scale,
//                                   width: 120 * scale,
//                                   child: ElevatedButton(
//                                     onPressed: () {
//                                       Navigator.of(ctx).pop();
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(builder: (_) => TransactionPage()),
//                                       );
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: buttonColor,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(20),
//                                       ),
//                                       padding: EdgeInsets.zero,
//                                     ),
//                                     child: Text(
//                                       'View Transaction',
//                                       style: GoogleFonts.inter(
//                                         fontSize: 12 * scale,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 36 * scale,
//                                   width: 120 * scale,
//                                   child: ElevatedButton(
//                                     onPressed: () {
//                                       Navigator.of(ctx).pop();
//                                       Navigator.pushAndRemoveUntil(
//                                         context,
//                                         MaterialPageRoute(builder: (_) => RechargeBillPage()),
//                                         (route) => false,
//                                       );
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: buttonColor,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(20),
//                                       ),
//                                       padding: EdgeInsets.zero,
//                                     ),
//                                     child: Text(
//                                       'Go to Services',
//                                       style: GoogleFonts.inter(
//                                         fontSize: 12 * scale,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   )