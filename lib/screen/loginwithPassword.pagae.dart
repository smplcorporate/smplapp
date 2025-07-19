import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWithPasswordScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<LoginWithPasswordScreen> createState() =>
      _LoginWithPasswordScreenState();
}

class _LoginWithPasswordScreenState
    extends ConsumerState<LoginWithPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _btnLoader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background circle (optional)
          Positioned(
            top: 150,
            left: -70,
            child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/circle1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        Text(
                          "Login with Password",
                          style: GoogleFonts.inter(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Access your account securely!",
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 40),

                        // Mobile Number
                        TextFormField(
                          controller: mobileController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Color(0xFF44806A),
                            ),
                            hintText: "Mobile number",
                            hintStyle: GoogleFonts.inter(
                              fontSize: 14,
                              color: Color(0xFFB8B8B8),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color(0xFFE6E6E6),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required";
                            } else if (value.length != 10) {
                              return "Mobile number must be exactly 10 digits";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 16),

                        // Password
                        TextFormField(
                          controller: passwordController,
                          obscureText: _obscurePassword,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(8),
                          ],
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xFF44806A),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Color(0xFF44806A),
                              ),
                              onPressed: () => setState(() {
                                _obscurePassword = !_obscurePassword;
                              }),
                            ),
                            hintText: "Password",
                            hintStyle: GoogleFonts.inter(
                              fontSize: 14,
                              color: Color(0xFFB8B8B8),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color(0xFFE6E6E6),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "Required";
                            if (value.length != 8)
                              return "Password must be exactly 8 characters";
                            return null;
                          },
                        ),

                        SizedBox(height: 32),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF44806A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: _btnLoader
                                ? CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2)
                                : Text(
                                    "Login",
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => _btnLoader = true);

                                // 🔐 Here goes your login logic
                                await Future.delayed(Duration(seconds: 2));

                                setState(() => _btnLoader = false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Login successful"),
                                  ),
                                );

                                // Navigator.push(...) to your dashboard/home
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
