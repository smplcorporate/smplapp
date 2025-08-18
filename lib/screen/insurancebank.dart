import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/screen/insurancebank2.dart';
// Updated import

class InsuranceServiceApp extends StatelessWidget {
  const InsuranceServiceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InsuranceApplyPage(),
    );
  }
}

class InsuranceApplyPage extends StatefulWidget {
  @override
  _InsuranceApplyPageState createState() => _InsuranceApplyPageState();
}

class _InsuranceApplyPageState extends State<InsuranceApplyPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _incomeController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  String? _dobError;
  bool _isConfirmed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 232, 243, 235),
        ),
        child: Column(
          children: [
            const SizedBox(height: 25),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(
                            CupertinoIcons.back,
                            color: Colors.black,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Insurance Service Apply',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildTextField('Full Name', _nameController),
                              buildTextField(
                                'Mobile Number',
                                _mobileController,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Mobile Number';
                                  } else if (!RegExp(
                                    r'^\d{10}$',
                                  ).hasMatch(value)) {
                                    return 'Mobile number must be exactly 10 digits';
                                  }
                                  return null;
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                              ),
                              buildTextField(
                                'Email',
                                _emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Email';
                                  } else if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                  ).hasMatch(value)) {
                                    return 'Enter a valid email address';
                                  }
                                  return null;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date of Birth",
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    TextFormField(
                                      controller: _dobController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [DateInputFormatter()],
                                      decoration: InputDecoration(
                                        hintText: 'DD/MM/YYYY',
                                        errorText: _dobError,
                                        suffixIcon: IconButton(
                                          icon: const Icon(
                                            Icons.calendar_today,
                                          ),
                                          onPressed: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
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
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                      ),
                                      onChanged: (value) {
                                        final regex = RegExp(
                                          r'^(\d{2})/(\d{2})/(\d{4})$',
                                        );
                                        if (regex.hasMatch(value)) {
                                          try {
                                            final parts = value.split('/');
                                            final day = int.parse(parts[0]);
                                            final month = int.parse(parts[1]);
                                            final year = int.parse(parts[2]);
                                            final date = DateTime(
                                              year,
                                              month,
                                              day,
                                            );
                                            if (date.isAfter(DateTime.now())) {
                                              setState(
                                                () =>
                                                    _dobError =
                                                        'DOB cannot be in future',
                                              );
                                            } else {
                                              setState(() => _dobError = null);
                                            }
                                          } catch (_) {
                                            setState(
                                              () => _dobError = 'Invalid date',
                                            );
                                          }
                                        } else {
                                          setState(
                                            () =>
                                                _dobError =
                                                    'Enter date as DD/MM/YYYY',
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              buildTextField(
                                'Monthly Income',
                                _incomeController,
                                keyboardType: TextInputType.number,
                              ),
                              buildTextField('Address', _addressController),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        child: Text(
                          'Next',
                          style: GoogleFonts.inter(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                            Future.delayed(
                              const Duration(milliseconds: 300),
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const InsurancePage2(),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: 1,
            inputFormatters: inputFormatters,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
            validator:
                validator ??
                (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter $label';
                  }
                  return null;
                },
          ),
        ],
      ),
    );
  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.length > 8) {
      digitsOnly = digitsOnly.substring(0, 8);
    }

    String formatted = '';
    for (int i = 0; i < digitsOnly.length; i++) {
      formatted += digitsOnly[i];
      if (i == 1 || i == 3) {
        formatted += '/';
      }
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
