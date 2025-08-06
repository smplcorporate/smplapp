import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast;
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:home/data/controller/billerParam.notier.dart';
import 'package:home/data/controller/fetchBills.provider.dart';
import 'package:home/data/model/billerParam.model.dart';
import 'package:home/data/model/billerParms.req.model.dart';
import 'package:home/data/model/checkCopoun.model.dart';
import 'package:home/data/model/fetchBill.model.dart';
import 'package:home/data/model/paynow.model.dart';
import 'package:home/screen/licsumarry.dart';
import 'package:home/screen/elebillsummary.dart';
import 'package:home/screen/order.details.page.dart';
import 'package:home/screen/summerysPages/fastagSummery.page.dart' hide UpperCaseTextFormatter;
// Make sure this file exists

class FastagFormPage extends ConsumerStatefulWidget {
  final String circleCode;
  final String billerName;
  final String billerCode;
  const FastagFormPage({
    super.key,
    required this.billerName,
    required this.billerCode,
    required this.circleCode,
  });

  @override
  ConsumerState<FastagFormPage> createState() => _LoanAccountScreenState();
}

class _LoanAccountScreenState extends ConsumerState<FastagFormPage> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _mpinControllr = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isValid = false;
  bool applyBtnLoder = false;
  bool coupnApplyed = false;
  bool isInvalid = false;
  bool btnLoder = false;

  void _submitAccount() {
    if (_formKey.currentState!.validate()) {
      ref.read(paramsProvider.notifier).updateParam1(_parm1Controller.text);
      ref.read(paramsProvider.notifier).updateParam2(_parm2Controller.text);
      ref.read(paramsProvider.notifier).updateParam3(_parm3Controller.text);
      ref.read(paramsProvider.notifier).updateParam4(_parm4Controller.text);
      ref.read(paramsProvider.notifier).updateParam5(_parm5Controller.text);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => FastagSummeryPage(
                body: FetchBodymodel(
                  data: FetchBillModel(
                    ipAddress: "152.59.109.59",
                    macAddress: "not found",
                    latitude: "26.917979",
                    longitude: "75.814593",
                    circleCode: widget.circleCode,
                    billerCode: widget.billerCode,
                    billerName: widget.billerName,
                    param1: _parm1Controller.text,
                    param2: _parm2Controller.text,
                    param3: _parm3Controller.text,
                    param4: _parm4Controller.text,
                    param5: _parm5Controller.text,
                  ),
                  path: "b2c_bills_fastag",
                ),
              ),
        ),
      );
    } else {
      return;
    }
  }

  late final FetchBllerParam fetchBillerParam;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log("fastag form reacherd");
    fetchBillerParam = FetchBllerParam(
      path: "b2c_bills_fastag",
      data: BillerParamRequest(
        ipAddress: "152.59.109.59",
        macAddress: "not found",
        latitude: "26.917979",
        longitude: "26.917979",
        billerCode: widget.billerCode,
        billerName: widget.billerName,
      ),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    // Yaha aap kuch bhi kar sakte ho jaise alert dikhana, data save karna
    print("Back button dabaya gaya!");
    ref.read(paramsProvider.notifier).clearData();

    // Agar true return karoge to page pop ho jayega
    // Agar false return karoge to page wahi rahega
    return true;
  }

  TextEditingController _parm1Controller = TextEditingController();
  TextEditingController _parm2Controller = TextEditingController();
  TextEditingController _parm3Controller = TextEditingController();
  TextEditingController _parm4Controller = TextEditingController();
  TextEditingController _parm5Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _copounCodeKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final billerParam = ref.watch(fetchBillerParamProvider(fetchBillerParam));
    final params = ref.watch(paramsProvider);
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 232, 243, 235),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 232, 243, 235),
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 21,
                ),
              ),
            ),
          ),
          title: Text(
            widget.billerName,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: billerParam.when(
          data: (snap) {
            return SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: const Color.fromARGB(255, 232, 243, 235),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 48,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      if (snap.isParam1 == true) ...[
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color:
                                  _isValid || _parm1Controller.text.isEmpty
                                      ? Colors.grey.shade600
                                      : Colors.red,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _parm1Controller,

                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z0-9]'),
                                    ),
                                    LengthLimitingTextInputFormatter(
                                      15,
                                    ), // Enforce length limit
                                    UpperCaseTextFormatter(),
                                  ],
                                  decoration: InputDecoration(
                                    hintText: snap.param1.name,
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    ref
                                        .read(paramsProvider.notifier)
                                        .updateParam1(value);
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "This field is required";
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (snap.isParam2 == true) ...[
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color:
                                  _isValid || _parm2Controller.text.isEmpty
                                      ? Colors.grey.shade600
                                      : Colors.red,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _parm2Controller,

                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "This field is required";
                                    }
                                  },
                                  onChanged: (value) {
                                    ref
                                        .read(paramsProvider.notifier)
                                        .updateParam2(value);
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z0-9]'),
                                    ),
                                    LengthLimitingTextInputFormatter(
                                      15,
                                    ), // Enforce length limit
                                    UpperCaseTextFormatter(),
                                  ],
                                  decoration: InputDecoration(
                                    hintText: snap.param2.name,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (snap.isParam3 == true) ...[
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color:
                                  _isValid || _parm3Controller.text.isEmpty
                                      ? Colors.grey.shade600
                                      : Colors.red,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _parm3Controller,

                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "This field is required";
                                    }
                                  },
                                  onChanged: (value) {
                                    ref
                                        .read(paramsProvider.notifier)
                                        .updateParam3(value);
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z0-9]'),
                                    ),
                                    LengthLimitingTextInputFormatter(
                                      15,
                                    ), // Enforce length limit
                                    UpperCaseTextFormatter(),
                                  ],
                                  decoration: InputDecoration(
                                    hintText: snap.param3?.name,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (snap.isParam4 == true) ...[
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color:
                                  _isValid || _parm4Controller.text.isEmpty
                                      ? Colors.grey.shade600
                                      : Colors.red,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _parm4Controller,

                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "This field is required";
                                    }
                                  },
                                  onChanged: (value) {
                                    ref
                                        .read(paramsProvider.notifier)
                                        .updateParam4(value);
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z0-9]'),
                                    ),
                                    LengthLimitingTextInputFormatter(
                                      15,
                                    ), // Enforce length limit
                                    UpperCaseTextFormatter(),
                                  ],
                                  decoration: InputDecoration(
                                    hintText: snap.param4?.name,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (snap.isParam5 == true) ...[
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color:
                                  _isValid || _parm5Controller.text.isEmpty
                                      ? Colors.grey.shade600
                                      : Colors.red,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _parm5Controller,

                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "This field is required";
                                    }
                                  },
                                  onChanged: (value) {
                                    ref
                                        .read(paramsProvider.notifier)
                                        .updateParam5(value);
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z0-9]'),
                                    ),
                                    LengthLimitingTextInputFormatter(
                                      15,
                                    ), // Enforce length limit
                                    UpperCaseTextFormatter(),
                                  ],
                                  decoration: InputDecoration(
                                    hintText: snap.param5?.name,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (snap.fetchOption == false) ...[
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color:
                                  _isValid || _amountController.text.isEmpty
                                      ? Colors.grey.shade600
                                      : Colors.red,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _amountController,
                                  keyboardType:
                                      TextInputType
                                          .number, // Use number keyboard
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "This field is required";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    // Handle logic if needed
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'), // Only numbers allowed
                                    ),
                                    LengthLimitingTextInputFormatter(
                                      7,
                                    ), // Max 7 digits
                                  ],
                                  decoration: InputDecoration(
                                    hintText: "Amount",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Divider(),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.only(left: 0.w, right: 0.w),
                          child: Form(
                            key: _copounCodeKey,
                            child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            readOnly: coupnApplyed,
                                            controller: _controller,
                                            maxLength: 15,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                RegExp(r'[A-Za-z0-9]'),
                                              ),
                                              UpperCaseTextFormatter(),
                                              LengthLimitingTextInputFormatter(
                                                15,
                                              ),
                                            ],
                                            decoration: InputDecoration(
                                              hintText:
                                                  'Gift card or discount code',
                                              counterText: '',
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 14,
                                                  ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                borderSide: BorderSide(
                                                  color:
                                                      isInvalid
                                                          ? Colors.red
                                                          : Colors.grey,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                borderSide: BorderSide(
                                                  color:
                                                      isInvalid
                                                          ? Colors.red
                                                          : Colors.grey,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
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
                                              if (value == null ||
                                                  value.isEmpty) {
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
                                            if (_copounCodeKey.currentState!
                                                .validate()) {
                                              if (_controller.text.isNotEmpty ||
                                                  _controller.text
                                                      .trim()
                                                      .isNotEmpty) {
                                                if (_amountController
                                                        .text
                                                        .isNotEmpty ||
                                                    _amountController.text
                                                        .trim()
                                                        .isNotEmpty) {
                                                  if (_parm1Controller.text
                                                      .trim()
                                                      .isNotEmpty) {
                                                    if (coupnApplyed == false) {
                                                      setState(() {
                                                        applyBtnLoder = true;
                                                      });
                                                      final state =
                                                          APIStateNetwork(
                                                            await createDio(),
                                                          );
                                                      final response = await state.checkCoupnFastTag(
                                                        CheckCouponModel(
                                                          ipAddress:
                                                              "152.59.109.59",
                                                          macAddress:
                                                              "not found",
                                                          latitude: "26.917979",
                                                          longitude:
                                                              "75.814593",
                                                          billerCode:
                                                              widget.billerCode,
                                                          billerName:
                                                              widget.billerName,
                                                          param1:
                                                              _parm1Controller
                                                                  .text,
                                                          transAmount:
                                                              double.parse(
                                                                _amountController
                                                                    .text,
                                                              ).toInt().toString(),
                                                          couponCode:
                                                              _controller.text
                                                                  .trim(),
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
                                                        log("testing1");
                                                        Fluttertoast.showToast(
                                                          msg:
                                                              response
                                                                  .response
                                                                  .data['status_desc'],
                                                          backgroundColor:
                                                              Colors.black,
                                                          textColor:
                                                              Colors.white,
                                                        );
                                                      } else {
                                                        setState(() {
                                                          applyBtnLoder = false;
                                                          _controller.clear();
                                                        });
                                                        log("testing2");
                                                        Fluttertoast.showToast(
                                                          msg:
                                                              response
                                                                  .response
                                                                  .data['status_desc'],
                                                          backgroundColor:
                                                              Colors.black,
                                                          textColor:
                                                              Colors.white,
                                                        );
                                                      }
                                                    } else {
                                                      setState(() {
                                                        coupnApplyed = false;
                                                        _controller.clear();
                                                      });
                                                    }
                                                  } else {
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          "${snap.param1.name} is required",
                                                      backgroundColor:
                                                          Colors.black,
                                                      textColor: Colors.white,
                                                    );
                                                  }
                                                } else {
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        "Amount is required to apply Coupon code",
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                  );
                                                }
                                              } else {
                                                Fluttertoast.showToast(
                                                  msg:
                                                      "Coupon Code is required",
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                );
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
                                              borderRadius:
                                                  BorderRadius.circular(6),
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
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                        ),
                                      ],
                                    ),
                                    if (coupnApplyed == true) ...[
                                      SizedBox(
                                        height: 8,
                                      ),
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
                              ]
                                  ],
                                ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color:
                                _isValid || _mpinControllr.text.isEmpty
                                    ? Colors.grey.shade600
                                    : Colors.red,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                obscureText: true,
                                controller: _mpinControllr,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "This field is required";
                                  }
                                  if (value.length < 6) {
                                    return "MPIN must be at least 6 digits";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  // ref.read(paramsProvider.notifier).updateParam5(value);
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter
                                      .digitsOnly, // Only digits 0-9
                                  LengthLimitingTextInputFormatter(
                                    6,
                                  ), // Max 6 digits
                                ],
                                decoration: InputDecoration(
                                  hintText: "MPIN",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ],
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed:
                              snap.fetchOption == false
                                  ? paynow
                                  : _submitAccount,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              68,
                              128,
                              106,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                              snap.fetchOption == true? "Proceed" : "Proceed to Pay",
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          error: (err, stacl) {
            return Center(child: Text("$err"));
          },
          loading: () => Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  void paynow() async {
    if(_controller.text.isNotEmpty && coupnApplyed == false) {
      Fluttertoast.showToast(
        msg: "Please remove coupon code to proceed",
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }else{
      if (_formKey.currentState!.validate()) {
      setState(() {
        btnLoder = true;
      });
      final box = Hive.box('userdata');
      final mobile = box.get('@mobile');
      final service = APIStateNetwork(await createDio());
      final reponse = await service.payNow(
        'b2c_bills_fastag',
        PayNowModel(
          ipAddress: "152.59.109.59",
          macAddress: "not found",
          latitude: "26.917979",
          longitude: "75.814593",
          billerCode: widget.billerCode,
          billerName: widget.billerName,
          circleCode: widget.circleCode,
          param1: _parm1Controller.text,
          param2: _parm2Controller.text,
          param3: _parm3Controller.text,
          param4: _parm4Controller.text,
          param5: _parm5Controller.text,
          customerName: "",
          billNo: "",
          dueDate: "",
          billDate: "",
          billAmount: _amountController.text,
          returnTransid: "",
          returnFetchid: "",
          returnBillid: "",
            couponCode: coupnApplyed == true?  _controller.text.trim() : "",
          userMpin: "${_mpinControllr.text}",
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
                style: GoogleFonts.inter(fontWeight: FontWeight.bold),
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
                '${reponse.response.data['trans_status']}',
                style: GoogleFonts.inter(fontWeight: FontWeight.bold),
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
                            (_) => PaymentDetailsScreen(
                              trnxId: '${reponse.response.data['trans_id']}',
                            ),
                      ),
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
    }
    }
  }
}
