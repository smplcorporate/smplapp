import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:home/data/model/passwordUpdatae.req.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _isObscureCurrent = true;
  bool _isObscureNew = true;
  bool _isObscureConfirm = true;
  bool btnLoder = false;
  void _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        btnLoder = true;
      });
      final api = APIStateNetwork(await createDio());
      final response = await api.updatePassword(
        PasswordChangeRequest(
          ipAddress: "127.0.0.1",
          passwordOld: currentPasswordController.text,
          passwordConfirm: confirmPasswordController.text,
          passwordNew: newPasswordController.text,
        ),
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              '',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold),
            ),
            content: Text('${response.statusDesc}', style: GoogleFonts.inter()),
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
      setState(() {
        btnLoder = false;
      });
    }
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback toggleObscure,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          cursorColor: Colors.deepPurple,
          cursorWidth: 3,
          cursorHeight: 24,
          cursorRadius: Radius.circular(4),
          decoration: InputDecoration(
            hintText: 'Enter your ${label.toLowerCase()}',
            suffixIcon: IconButton(
              icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
              onPressed: toggleObscure,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: const Color.fromARGB(255, 240, 240, 240),
                ),
              ),
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: media.height - 100),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Change Password',
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: media.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Keep your account secure by updating your password regularly.",
                        style: GoogleFonts.inter(
                          color: Colors.black87,
                          fontSize: media.width * 0.035,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildPasswordField(
                        label: "Current Password",
                        controller: currentPasswordController,
                        obscureText: _isObscureCurrent,
                        toggleObscure: () {
                          setState(() {
                            _isObscureCurrent = !_isObscureCurrent;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your current password';
                          }
                          return null;
                        },
                      ),
                      _buildPasswordField(
                        label: "New Password",
                        controller: newPasswordController,
                        obscureText: _isObscureNew,
                        toggleObscure: () {
                          setState(() {
                            _isObscureNew = !_isObscureNew;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a new password';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                      ),
                      _buildPasswordField(
                        label: "Confirm New Password",
                        controller: confirmPasswordController,
                        obscureText: _isObscureConfirm,
                        toggleObscure: () {
                          setState(() {
                            _isObscureConfirm = !_isObscureConfirm;
                          });
                        },
                        validator: (value) {
                          if (value != newPasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      Text(
                        'Password must be at least 8 characters long and include a mix of letters, numbers, and special symbols.',
                        style: GoogleFonts.inter(
                          color: Colors.black54,
                          fontSize: media.width * 0.032,
                        ),
                      ),
                      const Spacer(),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 35),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _saveChanges,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                68,
                                128,
                                106,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: btnLoder ==false? Text(
                              'Save Changes',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: media.width * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ): Center(
                              child: CircularProgressIndicator(color: Colors.white,),
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
