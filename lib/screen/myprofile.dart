import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:home/data/model/profile.provider.dart';
import 'package:home/data/model/userupdateModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

class MyProfileScreen extends ConsumerStatefulWidget {
  const MyProfileScreen({super.key});

  @override
  ConsumerState<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends ConsumerState<MyProfileScreen> {
  File? _profileImage;
  String? _selectedGender;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _selectGender(String gender) {
    ref.read(stringNotifierProvider.notifier).update(gender);
  }

  void _viewFullImage() {
    if (_profileImage != null) {
      showDialog(
        context: context,
        builder:
            (_) => Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: FileImage(_profileImage!),
                      // fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
      );
    }
  }

  Widget genderOption(String gender) {
    final genderSelected = ref.watch(stringNotifierProvider);
    bool isSelected = genderSelected == gender;
    return Expanded(
      child: GestureDetector(
        onTap: () => _selectGender(gender),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color.fromARGB(255, 125, 125, 125)),
            // color: isSelected ? Colors.green.shade50 : Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey),
                  color:
                      isSelected
                          ? const Color.fromARGB(255, 68, 128, 106)
                          : Colors.transparent,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                gender,
                style: GoogleFonts.inter(
                  fontSize: 15,

                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool btnLoder = false;
  late final TextEditingController firstName;
  late final TextEditingController lastName;
  late final TextEditingController dobController;
  late final TextEditingController addressController;
  late final TextEditingController mobileNumber;
  late final TextEditingController emailController;
  late final TextEditingController adharController;
  late final TextEditingController panNo;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Initialize all controllers
    firstName = TextEditingController();
    lastName = TextEditingController();
    dobController = TextEditingController();
    addressController = TextEditingController();
    mobileNumber = TextEditingController();
    emailController = TextEditingController();
    adharController = TextEditingController();
    panNo = TextEditingController();

    // Load initial data only once
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeFormData();
    });
  }

  Future<void> _initializeFormData() async {
    final profileData = ref.watch(profileprovider).value;
    if (profileData != null ) {
      log(profileData.userDetails.firstName.toString());
      setState(() {
        firstName.text = profileData.userDetails.firstName;
        lastName.text = profileData.userDetails.lastName;
        dobController.text = profileData.userDetails.dateOfBirth;
        addressController.text = profileData.userDetails.address;
        mobileNumber.text = profileData.userDetails.mobileNo;
        emailController.text = profileData.userDetails.emailId;
        adharController.text = profileData.userDetails.aadhaarNo;
        panNo.text = profileData.userDetails.panNo;

        // Initialize gender
        ref
            .read(stringNotifierProvider.notifier)
            .update(profileData.userDetails.gender ?? 'M');
      });
    }
  }

  @override
  void dispose() {
    // Clean up all controllers
    firstName.dispose();
    lastName.dispose();
    dobController.dispose();
    addressController.dispose();
    mobileNumber.dispose();
    emailController.dispose();
    adharController.dispose();
    panNo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(profileprovider);
    // data.whenData((value) {
    //   firstName.text = value.userDetails.firstName;
    //   lastName.text = value.userDetails.lastName;
    //   dobController.text = value.userDetails.dateOfBirth;
    //   addressController.text = value.userDetails.address;
    //   mobileNumber.text = value.userDetails.mobileNo;
    //   emailController.text = value.userDetails.emailId;
    //   adharController.text = value.userDetails.aadhaarNo;
    //   panNo.text = value.userDetails.panNo;
    // });
    final genderSelected = ref.watch(stringNotifierProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 236, 226),
      body: data.when(
        data: (snap) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Centered Header Row
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),

                        Center(
                          child: Text(
                            "My Profile",
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Profile Icon + Name
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          GestureDetector(
                            onTap:
                                _profileImage != null ? _viewFullImage : null,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  _profileImage != null
                                      ? FileImage(_profileImage!)
                                      : null,
                              child:
                                  _profileImage == null
                                      ? const Icon(
                                        Icons.person,
                                        size: 40,
                                        color: Color.fromARGB(
                                          255,
                                          68,
                                          128,
                                          106,
                                        ),
                                      )
                                      : null,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: const CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.transparent,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 18,
                                  color: Color.fromARGB(255, 68, 128, 106),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        "${snap.userDetails.firstName} ${snap.userDetails.lastName}",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "+91 ${snap.userDetails.mobileNo}",
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 126, 126, 126),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // All Details in One Container
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Basic Details",
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),

                            Text(
                              "First Name",
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: firstName,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ), // Default border color
                                ),
                                focusedBorder: OutlineInputBorder(
                                  // borderSide: BorderSide(color: Colors.green, width: 2.0), // On focus
                                ),
                                border:
                                    OutlineInputBorder(), // Fallback default
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }
                              },
                            ),
                            const SizedBox(height: 10),

                            Text(
                              "Last Name",
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: lastName,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ), // Default border color
                                ),
                                focusedBorder: OutlineInputBorder(
                                  // borderSide: BorderSide(color: Colors.green, width: 2.0), // On focus
                                ),
                                border:
                                    OutlineInputBorder(), // Fallback default
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }
                              },
                            ),
                            const SizedBox(height: 10),

                            Text(
                              "Date of Birth",
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: dobController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ), // Default border color
                                ),
                                focusedBorder: OutlineInputBorder(
                                  // borderSide: BorderSide(color: Colors.green, width: 2.0), // On focus
                                ),
                                border:
                                    OutlineInputBorder(), // Fallback default
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }
                              },
                            ),
                            const SizedBox(height: 10),

                            Text(
                              "Gender",
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                genderOption("M"),
                                const SizedBox(width: 10),
                                genderOption("F"),
                                const SizedBox(width: 10),
                                genderOption("O"),
                              ],
                            ),
                            const SizedBox(height: 10),

                            Text(
                              "Address",
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: addressController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ), // Default border color
                                ),
                                focusedBorder: OutlineInputBorder(
                                  // borderSide: BorderSide(color: Colors.green, width: 2.0), // On focus
                                ),
                                border:
                                    OutlineInputBorder(), // Fallback default
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Aadhaar No",
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: adharController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ), // Default border color
                                ),
                                focusedBorder: OutlineInputBorder(
                                  // borderSide: BorderSide(color: Colors.green, width: 2.0), // On focus
                                ),
                                border:
                                    OutlineInputBorder(), // Fallback default
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "PAN No",
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: panNo,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ), // Default border color
                                ),
                                focusedBorder: OutlineInputBorder(
                                  // borderSide: BorderSide(color: Colors.green, width: 2.0), // On focus
                                ),
                                border:
                                    OutlineInputBorder(), // Fallback default
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }
                              },
                            ),
                            const SizedBox(height: 20),

                            Text(
                              "Contact Details",
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),

                            Text(
                              "Mobile Number",
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: mobileNumber,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ), // Default border color
                                ),
                                focusedBorder: OutlineInputBorder(
                                  // borderSide: BorderSide(color: Colors.green, width: 2.0), // On focus
                                ),
                                border:
                                    OutlineInputBorder(), // Fallback default
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }
                              },
                            ),
                            const SizedBox(height: 10),

                            Text(
                              "Email ID",
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ), // Default border color
                                ),
                                focusedBorder: OutlineInputBorder(
                                  // borderSide: BorderSide(color: Colors.green, width: 2.0), // On focus
                                ),
                                border:
                                    OutlineInputBorder(), // Fallback default
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }
                              },
                            ),
                            const SizedBox(height: 20),

                            // Save Button
                            Center(
                              child: ElevatedButton(
                                onPressed: () async {
                                  // Save logic
                                  // setState(() {
                                  //   btnLoder = true;
                                  // });
                                  if (snap.editAllow == true) {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        btnLoder = true;
                                      });

                                      final state = APIStateNetwork(
                                        await createDio(),
                                      );
                                      final response = await state
                                          .updateProfile(
                                            UserUpdateeModel(
                                              ipAddress: "152.59.109.59",
                                              firstName: firstName.text,
                                              lastName: lastName.text,
                                              gender: genderSelected,
                                              dateOfBirth: dobController.text,
                                              emailId: emailController.text,
                                              aadhaarNo: int.parse(
                                                adharController.text,
                                              ),
                                              panNo: panNo.text,
                                              stateId: 23,
                                              districtId: 471,
                                              tehsilId: 1,
                                              pinCode: 302003,
                                              address: addressController.text,
                                            ),
                                          );
                                      if (response.response.data['status'] ==
                                          true) {
                                        // ref.read(boolStateProvider.notifier).setFalse();
                                        Fluttertoast.showToast(
                                          msg:
                                              response
                                                  .response
                                                  .data["status_desc"],
                                          backgroundColor: Colors.greenAccent,
                                          textColor: Colors.white,
                                        );
                                        setState(() {
                                          btnLoder = false;
                                        });
                                        // ref.refresh(profileprovider);
                                      } else {
                                        setState(() {
                                          btnLoder = false;
                                        });
                                        //  ref.read(boolStateProvider.notifier).setFalse();
                                        Fluttertoast.showToast(
                                          msg:
                                              response
                                                  .response
                                                  .data["status_desc"],
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                        );
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "All fields are mendotory!",
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                      );
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                      msg:
                                          "Its not editable now contact to help desk!",
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    68,
                                    128,
                                    106,
                                  ),
                                  minimumSize: const Size(double.infinity, 45),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                child:
                                    btnLoder == true
                                        ? CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                        : Text(
                                          "Save",
                                          style: GoogleFonts.inter(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        error: (err, stack) {
          return Center(child: Text("$err"));
        },
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class BoolStateNotifier extends StateNotifier<bool> {
  BoolStateNotifier() : super(false); // default is false

  void toggle() => state = !state;

  void setTrue() => state = true;

  void setFalse() => state = false;
}

final boolStateProvider = StateNotifierProvider<BoolStateNotifier, bool>(
  (ref) => BoolStateNotifier(),
);

// StateNotifier which manages a String state
class StringNotifier extends StateNotifier<String> {
  StringNotifier() : super('M');

  void update(String newValue) {
    state = newValue;
  }
}

final stringNotifierProvider = StateNotifierProvider<StringNotifier, String>((
  ref,
) {
  return StringNotifier();
});
