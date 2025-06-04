import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/openaccount5.dart';

class OpenBankAccountPage4 extends StatefulWidget {
  const OpenBankAccountPage4({super.key});

  @override
  State<OpenBankAccountPage4> createState() => _OpenBankAccountPage4State();
}

class _OpenBankAccountPage4State extends State<OpenBankAccountPage4> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _panController = TextEditingController();

  File? _selectedFileAadhar;
  File? _selectedFilePan;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AccountOpenConfirmation5()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete the form')),
      );
    }
  }

  Future<void> _pickFile(bool isAadharFile) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      setState(() {
        if (isAadharFile) {
          _selectedFileAadhar = File(result.files.single.path!);
        } else {
          _selectedFilePan = File(result.files.single.path!);
        }
      });
    }
  }

  Widget _buildFilePicker(String label, File? selectedFile, bool isAadharFile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          height: 52, // Match height of text fields
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _pickFile(isAadharFile),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  elevation: 0,
                  minimumSize: const Size(0, 36),
                ),
                child: const Text("Choose File",
                    style: TextStyle(fontSize: 14, color: Colors.white)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  selectedFile != null
                      ? selectedFile.path.split('/').last
                      : 'No file chosen',
                  style: const TextStyle(color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          width: mediaWidth,
          height: mediaHeight,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 232, 243, 235),
          ),
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
                        'Open Bank Account',
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
              const SizedBox(height: 20),

              // Step Indicator
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('Step ${index + 1}'),
                      ],
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),

              // Form Area
              Expanded(
                child: Container(
                  width: mediaWidth,
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
                                Text(
                                  'Account Details',
                                  style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Aadhar Number
                                Text('Aadhar Number',
                                    style: GoogleFonts.inter(
                                        fontSize: 14, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 6),
                                TextFormField(
                                  controller: _aadharController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 12,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter 12-digit Aadhar Number',
                                    counterText: '',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Aadhar number is required';
                                    } else if (value.length != 12) {
                                      return 'Aadhar must be exactly 12 digits';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),

                                // Choose File after Aadhar
                                _buildFilePicker(
                                    'Upload Document (Optional)', _selectedFileAadhar, true),
                                const SizedBox(height: 20),

                                // PAN Number
                                Text('PAN Number',
                                    style: GoogleFonts.inter(
                                        fontSize: 14, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 6),
                                TextFormField(
                                  controller: _panController,
                                  textCapitalization: TextCapitalization.characters,
                                  maxLength: 10,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter PAN Number',
                                    counterText: '',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'PAN number is required';
                                    } else if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$')
                                        .hasMatch(value)) {
                                      return 'Invalid PAN format';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),

                                // Choose File after PAN (optional)
                                _buildFilePicker(
                                    'Upload Document (Optional)', _selectedFilePan, false),
                              ],
                            ),
                          ),
                        ),

                        // Next Button
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                              elevation: 5,
                            ),
                            child: Text(
                              "Next",
                              style: GoogleFonts.inter(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
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
}
