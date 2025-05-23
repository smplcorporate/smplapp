import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FullKYCPage extends StatefulWidget {
  const FullKYCPage({super.key});

  @override
  State<FullKYCPage> createState() => _FullKYCPageState();
}

class _FullKYCPageState extends State<FullKYCPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _panController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  bool _isConfirmed = false;
  String? _dobError;

  @override
  void dispose() {
    _panController.dispose();
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
              Text(
                'Full KYC',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Verify your identity for a seamless and secure\n experience.',
                style: GoogleFonts.inter(fontSize: 13, color: Colors.black),
              ),
              const SizedBox(height: 24),

              _buildTextField(
                label: 'PAN Card Number',
                hint: 'Enter your PAN card number',
                hintStyle: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
                controller: _panController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter PAN card number';
                  }
                  if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$')
                      .hasMatch(value.toUpperCase())) {
                    return 'Invalid PAN format';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: 'First Name',
                hint: 'Enter your first name',
                hintStyle: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.black54,
                ),
                controller: _firstNameController,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter first name' : null,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: 'Middle Name',
                hint: 'Enter your middle name',
                hintStyle: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.black54,
                ),
                controller: _middleNameController,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                label: 'Last Name',
                hint: 'Enter your last name',
                hintStyle: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.black54,
                ),
                controller: _lastNameController,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter last name' : null,
              ),
              const SizedBox(height: 16),

              _buildDateField(
                label: 'Date of Birth',
                hint: 'DD/MM/YYYY',
                hintStyle: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.green,
                    focusColor: Colors.black,
                    activeColor: Colors.white,
                    hoverColor: Colors.grey,
                    value: _isConfirmed,
                    onChanged: (value) {
                      setState(() {
                        _isConfirmed = value!;
                      });
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
                          _dobError = _dobController.text.isEmpty
                              ? 'Please select Date of Birth'
                              : null;
                        });

                        if (_formKey.currentState!.validate() &&
                            _dobError == null) {
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
                  'Verify PAN',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    color: Colors.white,
                  ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          validator: validator,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: hintStyle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: _dobController,
          readOnly: true,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: hintStyle,
            errorText: _dobError,
            suffixIcon: const Icon(Icons.calendar_today),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              setState(() {
                _dobController.text =
                    "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                _dobError = null;
              });
            }
          },
        ),
      ],
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('KYC Submitted'),
        content: const Text('Your KYC details have been successfully submitted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
