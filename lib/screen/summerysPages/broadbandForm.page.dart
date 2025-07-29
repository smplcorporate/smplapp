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
import 'package:home/screen/summerysPages/broadBandSumerry.page.dart' hide UpperCaseTextFormatter;
import 'package:home/screen/summerysPages/fastagSummery.page.dart' hide UpperCaseTextFormatter;
// Make sure this file exists

class BroadBandFormnPage extends ConsumerStatefulWidget {
  final String circleCode;
  final String billerName;
  final String billerCode;
  const BroadBandFormnPage({
    super.key,
    required this.billerName,
    required this.billerCode,
    required this.circleCode,
  });

  @override
  ConsumerState<BroadBandFormnPage> createState() => _LoanAccountScreenState();
}

class _LoanAccountScreenState extends ConsumerState<BroadBandFormnPage> {
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
              (context) => BroadBandSumeery(
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
                  path: "b2c_bills_broadband",
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
      path: "b2c_bills_broadband",
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
                      
                      
                      
                      
                      
                      SizedBox(height: 100.h),
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
    if (_formKey.currentState!.validate()) {
      setState(() {
        btnLoder = true;
      });
      final box = Hive.box('userdata');
      final mobile = box.get('@mobile');
      final service = APIStateNetwork(await createDio());
      final reponse = await service.payNow(
        'b2c_bills_broadband',
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
          couponCode: "${_controller.text.trim()}",
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
