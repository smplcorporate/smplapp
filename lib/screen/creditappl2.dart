import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:home/data/controller/loanMitira.notifer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class CreditAppPage2 extends ConsumerStatefulWidget {
  const CreditAppPage2({super.key});

  @override
  ConsumerState<CreditAppPage2> createState() => _CreditAppPage2State();
}

class _CreditAppPage2State extends ConsumerState<CreditAppPage2> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  bool btnloder = false;
  File? _selectedFile1; // for Aadhaar section
  File? _selectedFile2; // for PAN section

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        btnloder = true;
      });
      final form = ref.watch(loanmitraFormProvider);
      final response = await submitLoanmitraForm(
        ipAddress: form.ipAddress,
        macAddress: form.macAddress,
        latitude: form.latitude,
        longitude: form.longitude,
        serviceType: "Axis-ETB- My Zone",
        serviceProviderCode: "Axis-ETB- My Zone",
        customerName: form.customerName,
        customerMobile: form.customerMobile,
        customerEmail: form.customerEmail,
        customerDob: form.customerDob,
        customerMonthlyIncome: form.customerMonthlyIncome,
        customerAddress: form.customerAddress,
        aadhaarNo: form.aadhaarNo,
        panNo: form.panNo,
        aadhaarNoFile: form.aadhaarNoFile!,
        panNoFile: form.panNoFile!,
        userMpin: form.userMpin,
      );
      if (response.data["status"] == true) {
        setState(() {
          btnloder = false;
        });
        _showPopup(response.data["redirect_url"], response.data["status_desc"]);
      } else {
        setState(() {
          btnloder = false;
        });
        Fluttertoast.showToast(
          msg: "${response.data["status_desc"]}",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete the form properly')),
      );
    }
  }

  Future<void> _launchURL(String uri) async {
    final Uri url = Uri.parse(uri.toString());
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showPopup(String uri, String desc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Form Submitted"),
          content: Text("$desc"),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _launchURL(uri);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickFile(bool isForAadhaar) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        if (isForAadhaar) {
          _selectedFile1 = File(result.files.single.path!);
        } else {
          _selectedFile2 = File(result.files.single.path!);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          width: mediaWidth,
          color: const Color.fromARGB(255, 232, 243, 235),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Credit Card Apply',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Form Section
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Aadhaar
                                Text(
                                  'Aadhaar Number',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _aadharController,
                                  maxLength: 12,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    counterText: "",
                                    hintText: 'Enter Aadhaar Number',
                                  ),
                                  onChanged: (value) {
                                    ref
                                        .read(loanmitraFormProvider.notifier)
                                        .updateField('aadhaarNo', value);
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Aadhaar number is required';
                                    } else if (!RegExp(
                                      r'^\d{12}$',
                                    ).hasMatch(value)) {
                                      return 'Must be exactly 12 digits';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                _buildFilePickerField(
                                  "Choose File",
                                  _selectedFile1,
                                  true,
                                ),

                                const SizedBox(height: 25),

                                // PAN
                                Text(
                                  'PAN Number',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _panController,
                                  maxLength: 10,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    counterText: "",
                                    hintText: 'Enter PAN Number',
                                  ),
                                  onChanged: (value) {
                                    ref
                                        .read(loanmitraFormProvider.notifier)
                                        .updateField('panNo', value);
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'PAN number is required';
                                    } else if (!RegExp(
                                      r'^[A-Z]{5}[0-9]{4}[A-Z]$',
                                    ).hasMatch(value)) {
                                      return 'Invalid PAN format';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                _buildFilePickerField(
                                  "Choose File",
                                  _selectedFile2,
                                  false,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        // Submit Button
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () async {
                              ref
                                  .read(loanmitraFormProvider.notifier)
                                  .updateField('aadhaarNoFile', _selectedFile1);
                              ref
                                  .read(loanmitraFormProvider.notifier)
                                  .updateField('panNoFile', _selectedFile2);
                              ref
                                  .read(loanmitraFormProvider.notifier)
                                  .updateField('userMpin', "123456");
                              _submitForm();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                68,
                                128,
                                106,
                              ),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              elevation: 5,
                            ),
                            child:
                                btnloder == true
                                    ? Center(child: CircularProgressIndicator())
                                    : Text(
                                      "Submit",
                                      style: GoogleFonts.inter(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilePickerField(String label, File? file, bool isForAadhaar) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () => _pickFile(isForAadhaar),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 68, 128, 106),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              elevation: 0, // Flat look
              minimumSize: const Size(120, 45), // Similar to TextField height
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                side: const BorderSide(
                  color: Colors.grey,
                ), // optional: add border like TextField
              ),
            ),
            child: const Text("Choose File"),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              file != null ? file.path.split('/').last : "No file chosen",
              style: const TextStyle(color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Future<Response<dynamic>> submitLoanmitraForm({
    required String ipAddress,
    required String macAddress,
    required String latitude,
    required String longitude,
    required String serviceType,
    required String serviceProviderCode,
    required String customerName,
    required String customerMobile,
    required String customerEmail,
    required String customerDob, // format: dd/mm/yyyy
    required String customerMonthlyIncome,
    required String customerAddress,
    required String aadhaarNo,
    required String panNo,
    required File aadhaarNoFile,
    required File panNoFile,
    required String userMpin,
  }) async {
    final dio = await createDio();
    final url =
        'https://uat.smplraj.in/b2c/appapi/banking/b2c_loanmitra/paynow';

    final formData = FormData.fromMap({
      'ip_address': ipAddress,
      'mac_address': macAddress,
      'latitude': latitude,
      'longitude': longitude,
      'service_type': serviceType,
      'service_provider_code': serviceProviderCode,
      'customer_name': customerName,
      'customer_mobile': customerMobile,
      'customer_email': customerEmail,
      'customer_dob': customerDob,
      'customer_monthlyincome': customerMonthlyIncome,
      'customer_address': customerAddress,
      'aadhaar_no': aadhaarNo,
      'pan_no': panNo,
      'aadhaar_no_url': await MultipartFile.fromFile(
        aadhaarNoFile.path,
        filename: 'aadhaar.jpg',
      ),
      'pan_no_url': await MultipartFile.fromFile(
        panNoFile.path,
        filename: 'pan.jpg',
      ),
      'user_mpin': userMpin,
    });

    final response = await dio.post(
      url,
      data: formData,
      options: Options(headers: {'Content-Type': 'multipart/form-data'}),
    );
    return response;
  }
}
