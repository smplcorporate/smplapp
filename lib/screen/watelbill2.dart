import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/data/controller/billerParam.notier.dart';
import 'package:home/data/controller/fetchBills.provider.dart';
import 'package:home/data/model/billerParms.req.model.dart';
import 'package:home/data/model/fetchBill.model.dart';
import 'package:home/screen/elebillsummary.dart';
import 'package:home/screen/waterbill3.dart';

class WaterBill2 extends ConsumerStatefulWidget {
  final String billerCode;
  final String billerName;
  final String circleId;
  const WaterBill2({
    super.key,
    required this.billerCode,
    required this.billerName,
    required this.circleId,
  });

  @override
  ConsumerState<WaterBill2> createState() => _WaterBill2State();
}

class _WaterBill2State extends ConsumerState<WaterBill2> {
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => WaterBill3(
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
                path: "b2c_bills_water",
              ),
            ),
      ),
    );
  }

  late final FetchBllerParam fetchBillerParam;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchBillerParam = FetchBllerParam(
      path: "b2c_bills_water",
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

  @override
  Widget build(BuildContext context) {
    final billerParam = ref.watch(fetchBillerParamProvider(fetchBillerParam));
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
                                hintText: snap.param3.name,
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
                                hintText: snap.param4.name,
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
                                hintText: snap.param5.name,
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
                      onPressed: _submitAccount,
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
                        "Confirm",
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
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text("Error: $error")),
      ),
    );
  }
}
