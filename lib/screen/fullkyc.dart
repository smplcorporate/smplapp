import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // <-- for inputFormatters
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/kyccomp.dart';

class FullKYCPage extends StatefulWidget {
  const FullKYCPage({super.key});

  @override
  State<FullKYCPage> createState() => _FullKYCPageState();
}

class _FullKYCPageState extends State<FullKYCPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _panController = TextEditingController();
  final TextEditingController _aadhaarController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  bool _isConfirmed = false;
  String? _dobError;

  @override
  void dispose() {
    _panController.dispose();
    _aadhaarController.dispose();
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    super.dispose();
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
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ),
        title: const Text('', style: TextStyle(color: Colors.transparent)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text('Full KYC',
                  style: GoogleFonts.inter(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Verify your identity for a seamless and secure\nexperience.',
                  style: GoogleFonts.inter(fontSize: 13)),
              const SizedBox(height: 24),

              _buildTextField(
                label: 'PAN Card Number',
                hint: 'ABCDE1234F',
                hintStyle: GoogleFonts.inter(fontSize: 13, color: Colors.black54),
                controller: _panController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter PAN card number';
                  }
                  if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$').hasMatch(value.toUpperCase())) {
                    return 'Invalid PAN format';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: 'Aadhaar Card Number',
                hint: '123456789012',
                hintStyle: GoogleFonts.inter(fontSize: 13, color: Colors.black54),
                controller: _aadhaarController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Aadhaar number';
                  }
                  if (!RegExp(r'^\d{12}$').hasMatch(value)) {
                    return 'Aadhaar number must be exactly 12 digits';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              _buildTextField(
                label: 'First Name',
                hint: 'Enter your first name',
                hintStyle: GoogleFonts.inter(fontSize: 13, color: Colors.black54),
                controller: _firstNameController,
                validator: (value) => value!.isEmpty ? 'Please enter first name' : null,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: 'Middle Name',
                hint: 'Enter your middle name',
                hintStyle: GoogleFonts.inter(fontSize: 13, color: Colors.black54),
                controller: _middleNameController,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: 'Last Name',
                hint: 'Enter your last name',
                hintStyle: GoogleFonts.inter(fontSize: 13, color: Colors.black54),
                controller: _lastNameController,
                validator: (value) => value!.isEmpty ? 'Please enter last name' : null,
              ),
              const SizedBox(height: 16),

              _buildDateField(
                label: 'Date of Birth',
                hint: 'DD/MM/YYYY',
                hintStyle: GoogleFonts.inter(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Checkbox(
                    value: _isConfirmed,
                    activeColor: Colors.white,
                    checkColor: const Color.fromARGB(255, 68, 128, 106),
                    onChanged: (value) {
                      setState(() => _isConfirmed = value ?? false);
                    },
                  ),
                  Expanded(
                    child: Text(
                      'I confirm the details provided are correct.',
                      style: GoogleFonts.inter(fontSize: 12),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _isConfirmed
                    ? () {
                        setState(() {
                          _dobError = _dobController.text.isEmpty ? 'Please select Date of Birth' : null;
                        });

                        if (_formKey.currentState!.validate() && _dobError == null) {
                          _showSuccessDialog();
                        }
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
                  'Verify KYC',
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
    required TextStyle hintStyle,
    required TextEditingController controller,
    FormFieldValidator<String>? validator,
  }) {
    final isAadhaar = label == 'Aadhaar Card Number';
    final isPAN = label == 'PAN Card Number';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: isAadhaar
              ? TextInputType.number
              : isPAN
                  ? TextInputType.text
                  : TextInputType.text,
          maxLength: isAadhaar ? 12 : null,
          inputFormatters: isAadhaar
              ? [FilteringTextInputFormatter.digitsOnly]
              : isPAN
                  ? [
                      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                      LengthLimitingTextInputFormatter(10)
                    ]
                  : null,
          decoration: InputDecoration(
            counterText: isAadhaar ? '' : null, // hides 0/12 counter for Aadhaar
            hintText: hint,
            hintStyle: hintStyle,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required String hint,
    required TextStyle hintStyle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 6),
        TextFormField(
          controller: _dobController,
          keyboardType: TextInputType.datetime,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: hintStyle,
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
                    _dobController.text = "${pickedDate.day.toString().padLeft(2, '0')}/"
                        "${pickedDate.month.toString().padLeft(2, '0')}/"
                        "${pickedDate.year}";
                    _dobError = null;
                  });
                }
              },
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
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
            'KYC Submitted',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 68, 128, 106),
            ),
          ),
          content: Text(
            'Your KYC details have been submitted.',
            style: GoogleFonts.inter(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
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
