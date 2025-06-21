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
    setState(() {
      _selectedGender = gender;
    });
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
    bool isSelected = _selectedGender == gender;
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

  @override
  Widget build(BuildContext context) {
    final loder = ref.watch(boolStateProvider);
    final data = ref.watch(profileprovider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 236, 226),
      body: data.when(
        data: (snap) {
          final firstName = TextEditingController(
            text: snap.userDetails.firstName,
          );
          final lastName = TextEditingController(
            text: snap.userDetails.lastName,
          );
          final dobController = TextEditingController(
            text: snap.userDetails.dateOfBirth,
          );

          final addressController = TextEditingController(
            text: snap.userDetails.address,
          );
          final mobileNumber = TextEditingController(
            text: snap.userDetails.mobileNo,
          );
          final emailController = TextEditingController(
            text: snap.userDetails.emailId,
          );
          final adharController = TextEditingController(
            text: snap.userDetails.aadhaarNo,
          );
          final panNo = TextEditingController(text: snap.userDetails.panNo);

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          onTap: _profileImage != null ? _viewFullImage : null,
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
                                      color: Color.fromARGB(255, 68, 128, 106),
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
                          TextField(
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
                              border: OutlineInputBorder(), // Fallback default
                            ),
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
                          TextField(
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
                              border: OutlineInputBorder(), // Fallback default
                            ),
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
                          TextField(
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
                              border: OutlineInputBorder(), // Fallback default
                            ),
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
                          TextField(
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
                              border: OutlineInputBorder(), // Fallback default
                            ),
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
                          TextField(
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
                              border: OutlineInputBorder(), // Fallback default
                            ),
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
                          TextField(
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
                              border: OutlineInputBorder(), // Fallback default
                            ),
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
                          TextField(
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
                              border: OutlineInputBorder(), // Fallback default
                            ),
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
                          TextField(
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
                              border: OutlineInputBorder(), // Fallback default
                            ),
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
                                  ref.read(boolStateProvider.notifier).setTrue();
                                  final state = APIStateNetwork(
                                    await createDio(),
                                  );
                                  final response = await state.updateProfile(
                                    UserUpdateeModel(
                                      ipAddress: "152.59.109.59",
                                      firstName: firstName.text,
                                      lastName: lastName.text,
                                      gender: _selectedGender!,
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
                                        ref.read(boolStateProvider.notifier).setFalse();
                                    Fluttertoast.showToast(
                                      msg:
                                          response.response.data["status_desc"],
                                      backgroundColor: Colors.greenAccent,
                                      textColor: Colors.white,
                                    );
                                    ref.refresh(profileprovider);
                                  } else {
                                     ref.read(boolStateProvider.notifier).setFalse();
                                    Fluttertoast.showToast(
                                      msg:
                                          response.response.data["status_desc"],
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                    );
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Its not editable now!",
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
                              child: loder == true? CircularProgressIndicator(
                                color: Colors.white,
                              ) : Text(
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
