import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:home/screen/kyccomp.dart';

class BankKYCPage extends StatefulWidget {
  const BankKYCPage({super.key});

  @override
  State<BankKYCPage> createState() => _BankKYCPageState();
}

class _BankKYCPageState extends State<BankKYCPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  String? _dobError;
  bool _isConfirmed = false;

  File? _passbookImage;
  File? _statementFile;
  File? _cancelChequeImage;

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _accountNumberController.dispose();
    _ifscController.dispose();
    _bankNameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(Function(File) onPicked) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      onPicked(File(pickedFile.path));
    }
  }

  bool _isFormValid() {
    return _formKey.currentState?.validate() == true &&
        _passbookImage != null &&
        _statementFile != null &&
        _cancelChequeImage != null &&
        _dobController.text.isNotEmpty &&
        _dobError == null &&
        _isConfirmed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 236, 226),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 223, 236, 226),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 20),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text('Bank KYC', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                'Submit your bank details and upload required documents.\nDocuments: Passbook, Cancelled Cheque, Bank Statement.',
                style: GoogleFonts.inter(fontSize: 13),
              ),
              const SizedBox(height: 24),

              // Account Number
              _buildTextField(
                label: 'Bank Account Number',
                controller: _accountNumberController,
                hint: '123456789012',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter account number';
                  if (!RegExp(r'^\d{9,18}$').hasMatch(value)) return 'Invalid account number';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // IFSC Code
              _buildTextField(
                label: 'IFSC Code',
                controller: _ifscController,
                hint: 'SBIN0001234',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter IFSC code';
                  if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(value.toUpperCase())) {
                    return 'Invalid IFSC code';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Bank Name
              _buildTextField(
                label: 'Bank Name',
                controller: _bankNameController,
                hint: 'State Bank of India',
                validator: (value) => value!.isEmpty ? 'Enter bank name' : null,
              ),
              const SizedBox(height: 16),

              // Upload Documents
              _buildUploadTile(
                label: 'Upload Passbook Photo',
                file: _passbookImage,
                onTap: () => _pickImage((file) => setState(() => _passbookImage = file)),
              ),
              const SizedBox(height: 16),

              _buildUploadTile(
                label: 'Upload Bank Statement',
                file: _statementFile,
                onTap: () => _pickImage((file) => setState(() => _statementFile = file)),
              ),
              const SizedBox(height: 16),

              _buildUploadTile(
                label: 'Upload Cancelled Cheque',
                file: _cancelChequeImage,
                onTap: () => _pickImage((file) => setState(() => _cancelChequeImage = file)),
              ),
              const SizedBox(height: 16),

              _buildDOBField(),
              const SizedBox(height: 12),

              // Confirmation Checkbox
              Row(
                children: [
                  Checkbox(
                    value: _isConfirmed,
                    onChanged: (value) {
                      setState(() => _isConfirmed = value ?? false);
                    },
                  ),
                  Expanded(
                    child: Text(
                      'I confirm the above bank details and uploaded documents are correct.',
                      style: GoogleFonts.inter(fontSize: 12),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: _isFormValid()
                    ? () {
                        _showSuccessDialog();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Verify Bank KYC',
                  style: GoogleFonts.inter(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required FormFieldValidator<String>? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }

  Widget _buildUploadTile({
    required String label,
    required File? file,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black26),
        ),
        child: Row(
          children: [
            const Icon(Icons.upload_file, color: Colors.black54),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                file == null ? label : 'Uploaded: ${file.path.split('/').last}',
                style: GoogleFonts.inter(fontSize: 13),
              ),
            ),
            if (file != null) const Icon(Icons.check_circle, color: Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildDOBField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date of Birth', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 6),
        TextFormField(
          controller: _dobController,
          decoration: InputDecoration(
            hintText: 'DD/MM/YYYY',
            errorText: _dobError,
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    _dobController.text =
                        "${pickedDate.day.toString().padLeft(2, '0')}/"
                        "${pickedDate.month.toString().padLeft(2, '0')}/"
                        "${pickedDate.year}";
                    _dobError = null;
                  });
                }
              },
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.grey[200],
          ),
          onChanged: (value) {
            final regex = RegExp(r'^(\d{2})/(\d{2})/(\d{4})$');
            if (regex.hasMatch(value)) {
              try {
                final parts = value.split('/');
                final day = int.parse(parts[0]);
                final month = int.parse(parts[1]);
                final year = int.parse(parts[2]);
                final date = DateTime(year, month, day);
                if (date.isAfter(DateTime.now())) {
                  setState(() => _dobError = 'DOB cannot be in future');
                } else {
                  setState(() => _dobError = null);
                }
              } catch (_) {
                setState(() => _dobError = 'Invalid date');
              }
            } else {
              setState(() => _dobError = 'Enter date as DD/MM/YYYY');
            }
          },
        ),
      ],
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            'Bank KYC Submitted',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 68, 128, 106),
            ),
          ),
          content: Text(
            'Your bank KYC documents have been submitted successfully.',
            style: GoogleFonts.inter(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => FullKycCompletedScreen()),
                  (route) => false,
                );
              },
              child: Text(
                'OK',
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 68, 128, 106),
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
