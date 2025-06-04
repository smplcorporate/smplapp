import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class InsurancePage2 extends StatefulWidget {
  const InsurancePage2({super.key});

  @override
  State<InsurancePage2> createState() => _InsurancePage2State();
}

class _InsurancePage2State extends State<InsurancePage2> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();

  File? _selectedFile1; // Aadhaar
  File? _selectedFile2; // PAN

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _showPopup();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete the form properly')),
      );
    }
  }

  Future<void> _launchURL() async {
    final Uri url = Uri.parse('https://example.com');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Form Submitted"),
          content: const Text("Your Aadhaar and PAN details have been submitted."),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _launchURL();
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
                          child: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Insurance Service Apply',
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
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
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
                                Text('Aadhaar Number',
                                    style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _aadharController,
                                  maxLength: 12,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    counterText: "",
                                    hintText: 'Enter Aadhaar Number',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Aadhaar number is required';
                                    } else if (!RegExp(r'^\d{12}$').hasMatch(value)) {
                                      return 'Must be exactly 12 digits';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                _buildFilePickerField("Choose File", _selectedFile1, true),

                                const SizedBox(height: 25),

                                // PAN
                                Text('PAN Number',
                                    style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _panController,
                                  maxLength: 10,
                                  textCapitalization: TextCapitalization.characters,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    counterText: "",
                                    hintText: 'Enter PAN Number',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'PAN number is required';
                                    } else if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$').hasMatch(value)) {
                                      return 'Invalid PAN format';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                _buildFilePickerField("Choose File", _selectedFile2, false),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              elevation: 5,
                            ),
                            child: Text(
                              "Submit",
                              style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600),
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
              elevation: 0,
              minimumSize: const Size(120, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                side: const BorderSide(color: Colors.grey),
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
}
