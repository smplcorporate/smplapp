import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/config/auth/auth.dart';
import 'package:home/data/controller/register.notifer.dart';
import 'package:home/data/model/register.model1.dart';
import 'package:home/screen/otp.dart';
import 'package:http/http.dart' as http;
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agree = false;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _authService = AuthService();
  String? _publicIp;
  String? _macAddress;
  Future<void> _getMacAddress() async {
    try {
      // Request permissions (for Android location permission)
      if (await Permission.locationWhenInUse.request().isGranted) {
        final info = NetworkInfo();
        final wifiBSSID =
            await info
                .getWifiBSSID(); // MAC address of the connected Wi-Fi access point

        setState(() {
          _macAddress = wifiBSSID ?? 'MAC Address not available';
        });
      } else {
        setState(() {
          _macAddress = 'Location permission denied';
        });
      }
    } catch (e) {
      setState(() {
        _macAddress = 'not found';
      });
    }
  }

  Future<void> _getPublicIpAddress() async {
    try {
      final response = await http.get(Uri.parse('https://api.ipify.org'));
      if (response.statusCode == 200) {
        setState(() {
          _publicIp =
              response.body; // The response body contains the IP address
        });
      } else {
        setState(() {
          _publicIp = 'Failed to fetch IP';
        });
      }
    } catch (e) {
      setState(() {
        _publicIp = 'notfound';
      });
    }
  }

  bool btnLoder = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMacAddress();
    _getPublicIpAddress();
  }

  @override
  Widget build(BuildContext context) {
    final userBody = ref.watch(userRegisterBodyProvider);
    final userBodyNotifier = ref.read(userRegisterBodyProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Left side circle
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 40),
                        Text(
                          "Create new account",
                          style: GoogleFonts.inter(
                            fontSize: 27,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Create Your Account & Start Paying Securely!",
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: firstNameController,
                                decoration: InputDecoration(
                                  hintText: "First name",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 230, 230, 230),
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintStyle: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: const Color.fromARGB(
                                      255,
                                      184,
                                      184,
                                      184,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor:
                                      Colors
                                          .white, // Set background color to white
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 230, 230, 230),
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                validator:
                                    (value) =>
                                        value!.isEmpty ? "Required" : null,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: lastNameController,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 230, 230, 230),
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: "Last name",
                                  hintStyle: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: const Color.fromARGB(
                                      255,
                                      184,
                                      184,
                                      184,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor:
                                      Colors
                                          .white, // Set background color to white
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 230, 230, 230),
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                validator:
                                    (value) =>
                                        value!.isEmpty ? "Required" : null,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: mobileController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 230, 230, 230),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: const Color.fromARGB(255, 68, 128, 106),
                            ),
                            hintText: "Mobile number",
                            hintStyle: GoogleFonts.inter(
                              fontSize: 14,
                              color: const Color.fromARGB(255, 184, 184, 184),
                            ),
                            filled: true,
                            fillColor:
                                Colors.white, // Set background color to white
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 230, 230, 230),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator:
                              (value) => value!.isEmpty ? "Required" : null,
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 230, 230, 230),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: const Color.fromARGB(255, 68, 128, 106),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color.fromARGB(255, 68, 128, 106),
                              ),
                              onPressed:
                                  () => setState(
                                    () => _obscurePassword = !_obscurePassword,
                                  ),
                            ),
                            hintText: "Password",
                            hintStyle: GoogleFonts.inter(
                              fontSize: 14,
                              color: const Color.fromARGB(255, 184, 184, 184),
                            ),
                            filled: true,
                            fillColor:
                                Colors.white, // Set background color to white
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 230, 230, 230),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator:
                              (value) => value!.isEmpty ? "Required" : null,
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: confirmPasswordController,
                          obscureText: _obscureConfirm,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 230, 230, 230),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: const Color.fromARGB(255, 68, 128, 106),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirm
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color.fromARGB(255, 68, 128, 106),
                              ),
                              onPressed:
                                  () => setState(
                                    () => _obscureConfirm = !_obscureConfirm,
                                  ),
                            ),
                            hintText: "Confirm Password",
                            hintStyle: GoogleFonts.inter(
                              fontSize: 14,
                              color: const Color.fromARGB(255, 184, 184, 184),
                            ),
                            filled: true,
                            fillColor:
                                Colors.white, // Set background color to white
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 230, 230, 230),
                              ), // Red border
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) return "Required";
                            if (value != passwordController.text)
                              return "Passwords do not match";
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.green,
                              value: _agree,
                              onChanged: (val) => setState(() => _agree = val!),
                            ),
                            // Terms text
                            Text.rich(
                              TextSpan(
                                text: 'I agree to',
                                children: [
                                  TextSpan(
                                    text: '  terms & condition',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: const Color.fromARGB(
                                        255,
                                        68,
                                        128,
                                        106,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
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
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                            child:
                                btnLoder == false
                                    ? Text(
                                      "Sign Up",
                                      style: GoogleFonts.inter(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    )
                                    : CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (_agree) {
                                  // After successful signup, navigate 1to the next screen
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => VerifyOtpScreen(),
                                  //   ),
                                  // );
                                  try {
                                    setState(() {
                                      btnLoder = true;
                                    });
                                    userBodyNotifier.setUserRegisterBody(
                                      UserRegisterBody(
                                        userFirstname: firstNameController.text,
                                        userLastname: lastNameController.text,
                                        userMobile: int.parse(
                                          mobileController.text,
                                        ),
                                        latitude: "26.917979",
                                        longitude: "75.814593",
                                        ipAddress: _publicIp ?? "not found",
                                        macAddress: "",
                                      ),
                                    );
                                    await _authService.regiterInit(
                                      UserRegisterBody(
                                        userFirstname: firstNameController.text,
                                        userLastname: lastNameController.text,
                                        userMobile: int.parse(
                                          mobileController.text,
                                        ),
                                        latitude: "26.917979",
                                        longitude: "75.814593",
                                        ipAddress: _publicIp ?? "not found",
                                        macAddress: "",
                                      ),
                                    );
                                  } catch (e) {
                                    setState(() {
                                      btnLoder = false;
                                    });
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "You must agree to terms",
                                    backgroundColor: Colors.red,
                                  );
                                }
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
