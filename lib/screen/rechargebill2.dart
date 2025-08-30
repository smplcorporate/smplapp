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
import 'package:home/data/controller/mobilePlan.provider.dart';
import 'package:home/data/controller/mobilePrepaid.notifier.dart';
import 'package:home/data/controller/mobilePrepaid.provider.dart';
import 'package:home/data/model/billerParms.req.model.dart';
import 'package:home/data/model/checkCopoun.model.dart';
import 'package:home/data/model/fetchBill.model.dart';
import 'package:home/data/model/mobileplanRes.model.dart';
import 'package:home/data/model/paynow.model.dart';
import 'package:home/screen/mobilePospaid/mobilePostPaid3.page.dart';
import 'package:home/screen/order.details.page.dart';
import 'package:home/screen/rechargebill3.dart';
import 'package:home/screen/summerysPages/pipeGas.summery.page.dart';

class RechargePlansPage extends ConsumerStatefulWidget {
  final String billerName;
  final String billerCode;
  final String circleCode;

  RechargePlansPage({super.key, required this.billerName, required this.billerCode, required this.circleCode});
  @override
  ConsumerState<RechargePlansPage> createState() => _RechargePlansPageState();
}

class _RechargePlansPageState extends ConsumerState<RechargePlansPage> {
  late final RechargeRequestModel requestModel;
  String searchQuery = "";
  String tabName = "";
  @override
  void initState() {
    super.initState();
    final userBillerData = ref.read(billerProvider);
    requestModel = RechargeRequestModel(
      ipAddress: "198.168.62.1",
      macAddress: "not found",
      latitude: "42.000",
      longitude: "45.000",
      billerCode: userBillerData.selectedBiller!.billerCode,
      billerName: userBillerData.selectedBiller!.billerName,
      circleCode: userBillerData.selectedCircle?.circleId ?? "",
      param1: userBillerData.number ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    final dynamicPlan = ref.watch(mobilePlanProvider(requestModel));
    final userBillerData = ref.watch(billerProvider);
    return DefaultTabController(
      length: 4,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: dynamicPlan.when(
          data: (snap) {
            // Filter data based on search query
            final filteredPlans =
                snap.planData.where((plan) {
                  final planAmountStr = plan.planAmount.toString();
                  final planNameStr = plan.planName?.toLowerCase() ?? "";
                  final query = searchQuery.toLowerCase();

                  final matchesSearch =
                      planAmountStr.contains(query) ||
                      planNameStr.contains(query);

                  final matchesTab =
                      tabName.isEmpty ||
                      (plan.planTab?.toLowerCase() == tabName.toLowerCase());

                  return matchesSearch && matchesTab;
                }).toList();

            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 232, 243, 235),
              appBar: AppBar(
                title: const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Recharge Bill',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                backgroundColor: const Color.fromARGB(255, 232, 243, 235),
                elevation: 0,
                centerTitle: true,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(blurRadius: 4, color: Colors.grey.shade300),
                      ],
                    ),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                          size: 20,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(120),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                              });
                            },
                            decoration: const InputDecoration(
                              icon: Icon(Icons.search, color: Colors.black),
                              hintText: "Search by Amount or Plan Name",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body:
                  filteredPlans.isEmpty
                      ? const Center(
                        child: Text(
                          "No matching plans found",
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                      : SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30.h,
                              width: MediaQuery.of(context).size.width,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  SizedBox(width: 30),

                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        tabName = "";
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 5,
                                          bottom: 5,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "ALL",
                                            style: GoogleFonts.inter(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        tabName = "Data";
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 5,
                                          bottom: 5,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Data",
                                            style: GoogleFonts.inter(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        tabName = "Others";
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 5,
                                          bottom: 5,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Others",
                                            style: GoogleFonts.inter(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        tabName = "Rate Cutter";
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 5,
                                          bottom: 5,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Rate Cutter",
                                            style: GoogleFonts.inter(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        tabName = "Special Offer";
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 5,
                                          bottom: 5,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Special Offer",
                                            style: GoogleFonts.inter(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        tabName = "Top Up";
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 5,
                                          bottom: 5,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Top Up",
                                            style: GoogleFonts.inter(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: filteredPlans.length,
                              itemBuilder: (context, index) {
                                final plan = filteredPlans[index];
                                final isSpecialPlan =
                                    plan.planAmount.toString() == '199';

                                final planWidget = Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 10,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          plan.planAmount.toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Data: ${plan.planAmount ?? '-'}",
                                            ),
                                            Text(
                                              "Validity: ${plan.validity ?? '-'}",
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          "Plan Name: ${plan.planName ?? '-'}",
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          plan.planDescription ?? '',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => RechargePage3(plan: plan),
                                      ),
                                    );
                                  },
                                  child: planWidget,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
            );
          },
          error: (err, stack) {
            return MobilePrepaid2(billerCode: widget.billerCode, billerName: widget.billerName, circleId: widget.circleCode);
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class MobilePrepaid2 extends ConsumerStatefulWidget {
  final String billerCode;
  final String billerName;
  final String circleId;
  const MobilePrepaid2({
    super.key,
    required this.billerCode,
    required this.billerName,
    required this.circleId,
  });

  @override
  ConsumerState<MobilePrepaid2> createState() => _MobilePostpaidPageState();
}

class _MobilePostpaidPageState extends ConsumerState<MobilePrepaid2> {
  final TextEditingController _controller = TextEditingController();
  bool _isValid = true; // Start as true to avoid red border initially
  String? _errorText;

  void _validateInput(String input) {
    final isValidCID = RegExp(r'^[a-zA-Z0-9]{10}$').hasMatch(input);
    setState(() {
      _isValid = isValidCID;
      _errorText =
          isValidCID ? null : "Please enter a valid 10-character CID code";
    });
  }

  void _submitAccount() {
    final cidCode = _controller.text.trim();
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => MobilePostpaidPage3(
                body: FetchBodymodel(
                  data: FetchBillModel(
                    ipAddress: "152.59.109.59",
                    macAddress: "not found",
                    latitude: "26.917979",
                    longitude: "75.814593",
                    circleCode: widget.circleId,
                    billerCode: widget.billerCode,
                    billerName: widget.billerName,
                    param1: _parm1Controller.text,
                    param2: _parm2Controller.text,
                    param3: _parm3Controller.text,
                    param4: _parm4Controller.text,
                    param5: _parm5Controller.text,
                  ),
                  path: "b2c_bills_mobile",
                ),
              ),
        ),
      );
    }
  }

  void paynow() async {
    if (btnLoder == false) {
      if (_controller.text.isNotEmpty && coupnApplyed == false) {
        Fluttertoast.showToast(
          msg: "Apply Coupon first",
          textColor: Colors.white,
          backgroundColor: Colors.red,
        );
      } else {
        if (_formKey.currentState!.validate()) {
          setState(() {
            btnLoder = true;
          });
          final box = Hive.box('userdata');
          final mobile = box.get('@mobile');
          final service = APIStateNetwork(await createDio());
          final reponse = await service.payNow(
            'b2c_bills_mobile',
            PayNowModel(
              ipAddress: "152.59.109.59",
              macAddress: "not found",
              latitude: "26.917979",
              longitude: "75.814593",
              billerCode: widget.billerCode,
              billerName: widget.billerName,
              circleCode: widget.circleId,
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
              couponCode: coupnApplyed == true ? _controller.text.trim() : "",
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
                                  trnxId:
                                      '${reponse.response.data['trans_id']}',
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

  late final FetchBllerParam fetchBillerParam;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchBillerParam = FetchBllerParam(
      path: "b2c_prepaid_mobile",
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

  TextEditingController _parm1Controller = TextEditingController();
  TextEditingController _parm2Controller = TextEditingController();
  TextEditingController _parm3Controller = TextEditingController();
  TextEditingController _parm4Controller = TextEditingController();
  TextEditingController _parm5Controller = TextEditingController();

  final TextEditingController _mpinControllr = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _copounCodeKey = GlobalKey<FormState>();
  bool applyBtnLoder = false;
  bool coupnApplyed = false;
  bool isInvalid = false;
  bool btnLoder = false;
  @override
  Widget build(BuildContext context) {
    final billerParam = ref.watch(fetchBillerParamProvider2(fetchBillerParam));
    final params = ref.watch(paramsProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 232, 243, 235),
        elevation: 0,
        title: Text(
          widget.billerName,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: billerParam.when(
        data: (snap) {
          return Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 232, 243, 235),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
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
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(
                                    10,
                                  ), // Enforce length limit
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
                                  } else if (!RegExp(
                                    r'^[6-9]\d{9}$',
                                  ).hasMatch(value)) {
                                    return "Enter a valid 10-digit Indian mobile number";
                                  }
                                  return null; // Valid input
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    // ,
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
                                    TextInputType.number, // Use number keyboard
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                        LengthLimitingTextInputFormatter(15),
                                      ],
                                      decoration: InputDecoration(
                                        hintText: 'Gift card or discount code',
                                        counterText: '',
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 14,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                          borderSide: BorderSide(
                                            color:
                                                isInvalid
                                                    ? Colors.red
                                                    : Colors.grey,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                          borderSide: BorderSide(
                                            color:
                                                isInvalid
                                                    ? Colors.red
                                                    : Colors.grey,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
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
                                        if (_parm1Controller.text
                                            .trim()
                                            .isNotEmpty) {
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
                                                if (coupnApplyed == false) {
                                                  setState(() {
                                                    applyBtnLoder = true;
                                                  });
                                                  final state = APIStateNetwork(
                                                    await createDio(),
                                                  );
                                                  final response = await state
                                                      .checkMobilePostpaidCoupon(
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
                                                      textColor: Colors.white,
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
                                                      textColor: Colors.white,
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
                                                      "Amount is required to apply Coupon code",
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                );
                                              }
                                            } else {
                                              Fluttertoast.showToast(
                                                msg: "Coupon Code is required",
                                                backgroundColor: Colors.black,
                                                textColor: Colors.white,
                                              );
                                            }
                                          }
                                        } else {
                                          Fluttertoast.showToast(
                                            msg:
                                                "${snap.param1.name} is required",
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
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                  ),
                                ],
                              ),
                              if (coupnApplyed == true) ...[
                                SizedBox(height: 8),
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
                    SizedBox(height: 50),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed:
                            snap.fetchOption == true ? _submitAccount : paynow,
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
                          snap.fetchOption == true
                              ? "Process"
                              : "Processd to Pay",
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
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text("Error: $error")),
      ),
    );
  }
}
