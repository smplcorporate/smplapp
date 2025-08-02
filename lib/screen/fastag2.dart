import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/data/controller/billerParam.notier.dart';
import 'package:home/data/controller/fetchBills.provider.dart';
import 'package:home/data/model/billerParms.req.model.dart';
import 'package:home/data/model/fetchBill.model.dart';
import 'package:home/screen/elebillsummary.dart';
import 'package:home/screen/fastag3.dart';
// Adjust if needed

class VehicleRegistrationScreen extends ConsumerStatefulWidget {
  final String billerName;
  final String billerCode;
  final String circleCode;

  const VehicleRegistrationScreen({
    super.key,
    required this.billerName,
    required this.billerCode,
    required this.circleCode,
  });
  @override
  _VehicleRegistrationScreenState createState() =>
      _VehicleRegistrationScreenState();
}

class _VehicleRegistrationScreenState
    extends ConsumerState<VehicleRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _vehicleController = TextEditingController();
  String? _errorText;

  bool isValidVehicleNumber(String input) {
    final regExp = RegExp(r'^[A-Z]{2}[0-9]{1,2}[A-Z]{1,3}[0-9]{1,4}$');
    return regExp.hasMatch(input);
  }

  void _validateAndSubmit() {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => FastagSummary(
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
  }

  late final FetchBllerParam fetchBillerParam;
  @override
  void dispose() {
    _vehicleController.dispose();
    super.dispose();
  }

  TextEditingController _parm1Controller = TextEditingController();
  TextEditingController _parm2Controller = TextEditingController();
  TextEditingController _parm3Controller = TextEditingController();
  TextEditingController _parm4Controller = TextEditingController();
  TextEditingController _parm5Controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

  bool isInvalid = false;
  bool _isValid = false;
  @override
  Widget build(BuildContext context) {
    final billerParam = ref.watch(fetchBillerParamProvider(fetchBillerParam));
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 232, 243, 235),
        title: Text(
          '${widget.billerName}',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: billerParam.when(
        data: (snap) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      'Vehicle Registration Number',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                                onChanged: (value) {
                                  ref
                                      .read(paramsProvider.notifier)
                                      .updateParam2(value);
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
                    const SizedBox(height: 5),
                    Text(
                      'Please enter your vehicle number',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Instructions to Enter Vehicle Number:',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 12),
                    instructionBullet(
                      "Enter the vehicle number exactly as shown on the number plate.",
                    ),
                    instructionBullet(
                      "Format: DL8CAP1234 (no spaces or special characters).",
                    ),
                    instructionBullet("Use only capital letters and numbers."),
                    instructionBullet(
                      "Incorrect entry may result in failure to fetch vehicle details.",
                    ),
                    instructionBullet(
                      "Double-check the number before submitting.",
                    ),
      
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _validateAndSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            68,
                            128,
                            106,
                          ),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          "Confirm",
                          style: GoogleFonts.inter(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
        error: (err, stack) {
          return Center(
            child: Text(
              "Error: $err",
              style: GoogleFonts.inter(fontSize: 16, color: Colors.red),
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget instructionBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• ",
            style: GoogleFonts.inter(fontSize: 18, color: Colors.black),
          ),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}
