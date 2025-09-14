import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/utils.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:home/data/controller/common.controller.dart';
import 'package:home/data/model/distrctBody.res.dart';
import 'package:home/data/model/districtCommon.model.dart';
import 'package:home/data/model/distubiterBody.res.dart';
import 'package:home/data/model/lpgState.res.dart';
import 'package:home/data/model/profile.provider.dart';
import 'package:home/data/model/stateCommon.model.dart';
import 'package:home/data/model/theshsilCommon.model.dart';
import 'package:home/data/model/userupdateModel.dart';
import 'package:home/data/model/stateList.provider.dart';
import 'package:home/screen/elebillsummary.dart';

import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

// Providers for dropdowns (reusing from LPGPage2screen)
final stateProvider = StateProvider<LpgStatesList?>((ref) => null);
final districtProvider = StateProvider<LpgDistrictsList?>((ref) => null);
final tehsilProvider = StateProvider<LpgDistributorsList?>((ref) => null);

// Generic Dropdown Widget (based on LPGPage2screen dropdowns)
class GenericDropdown<T> extends ConsumerStatefulWidget {
  final String hintText;
  final AsyncValue provider;
  final String Function(T) displayText;
  final String Function(T) idSelector;
  final Function(T) callBack;

  const GenericDropdown({
    Key? key,
    required this.hintText,
    required this.provider,
    required this.displayText,
    required this.idSelector,
    required this.callBack,
  }) : super(key: key);

  @override
  _GenericDropdownState<T> createState() => _GenericDropdownState<T>();
}

class _GenericDropdownState<T> extends ConsumerState<GenericDropdown<T>> {
  T? selectedItem;
  String searchText = "";
  bool isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return widget.provider.when(
      data: (snap) {
        List<T> list;
        if (T == LpgStatesList) {
          list = snap.lpgStatesList as List<T>;
        } else if (T == LpgDistrictsList) {
          list = snap.lpgDistrictsList as List<T>;
        } else if (T == LpgDistributorsList) {
          list = snap.lpgDistributorsList as List<T>;
        } else {
          list = <T>[];
        }

        // Apply search filter
        final filteredList =
            list.where((e) {
              return widget
                  .displayText(e)
                  .toLowerCase()
                  .contains(searchText.toLowerCase());
            }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main dropdown button
            GestureDetector(
              onTap: () {
                setState(() {
                  isDropdownOpen = !isDropdownOpen;
                });
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.location_on, color: Colors.black),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            selectedItem != null
                                ? widget.displayText(selectedItem!)
                                : widget.hintText,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Icon(
                        isDropdownOpen
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Dropdown Panel
            if (isDropdownOpen) ...[
              const SizedBox(height: 8),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search ${widget.hintText}',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: width * 0.04,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child:
                      filteredList.isEmpty
                          ? const Center(child: Text("No items found"))
                          : ListView.builder(
                            itemCount: filteredList.length,
                            itemBuilder: (context, index) {
                              final e = filteredList[index];
                              return ListTile(
                                title: Text(widget.displayText(e)),
                                onTap: () {
                                  setState(() {
                                    selectedItem = e;
                                    isDropdownOpen = false;
                                    searchText = "";
                                    widget.callBack(e);
                                  });
                                },
                              );
                            },
                          ),
                ),
              ),
            ],
          ],
        );
      },
      error: (err, stack) => const SizedBox(),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

class MyProfileScreen extends ConsumerStatefulWidget {
  const MyProfileScreen({super.key});

  @override
  ConsumerState<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends ConsumerState<MyProfileScreen> {
  File? _profileImage;
  String? _selectedGender;
  late final TextEditingController firstName;
  late final TextEditingController lastName;
  late final TextEditingController dobController;
  late final TextEditingController addressController;
  late final TextEditingController mobileNumber;
  late final TextEditingController emailController;
  late final TextEditingController adharController;
  late final TextEditingController panNo;
  late final TextEditingController pincodeController;
  late final TextEditingController _stateIdController;
  late final TextEditingController _districtIdController;
  late final TextEditingController _tehsilIdController;
  late final TextEditingController _fatherNameController;
  late final TextEditingController _gstinNoController;

  final _formKey = GlobalKey<FormState>();

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
                      fit: BoxFit.contain,
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
    pincodeController = TextEditingController();
    _stateIdController = TextEditingController();
    _districtIdController = TextEditingController();
    _tehsilIdController = TextEditingController();
    _fatherNameController = TextEditingController();
    _gstinNoController = TextEditingController();

    // Load initial data only once
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.watch(profileprovider);
      await _initializeFormData();
    });
  }

  Future<void> _initializeFormData() async {
    final profileData = ref.watch(profileprovider).value;
    if (profileData != null) {
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
        pincodeController.text =
            profileData.userDetails.pinCode?.toString() ?? '';
        _fatherNameController.text = profileData.userDetails.fatherName ?? '';

        // Initialize gender
        ref
            .read(stringNotifierProvider.notifier)
            .update(profileData.userDetails.gender ?? 'M');

        // Initialize dropdowns (handled by providers, so no direct initialization here)
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
    pincodeController.dispose();
    _stateIdController.dispose();
    _districtIdController.dispose();
    _tehsilIdController.dispose();
    _fatherNameController.dispose();
    _gstinNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(profileprovider);
    final selectedState = ref.watch(stateProvider);
    final selectedDistrict = ref.watch(districtProvider);
    final selectedGender = ref.watch(stringNotifierProvider);

    // Providers for district and tehsil
    final districtListProvider =
        selectedState != null
            ? ref.watch(getDistrictListProvider(selectedState.stateId))
            : AsyncValue.data(null);
    final tehsilListProvider =
        selectedDistrict != null
            ? ref.watch(
              getDistrubterProvider({
                "stateID": selectedState?.stateId ?? "",
                "districtId": selectedDistrict.districtId,
              }),
            )
            : AsyncValue.data(null);

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
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(30)
                              ],
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ),
                                ),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
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
                              inputFormatters: [  LengthLimitingTextInputFormatter(30)],
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ),
                                ),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),

                            Text(
                              "Father Name",
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: _fatherNameController,
                              inputFormatters: [  LengthLimitingTextInputFormatter(40)],
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ),
                                ),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                return null;
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
                              inputFormatters: [
                                  LengthLimitingTextInputFormatter(10)
                              ],
                              decoration: InputDecoration(
                                hint: Text("DD/MM/YYYY"),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ),
                                ),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
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

                            // State Dropdown
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 223, 236, 226),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Select State",
                                          style: GoogleFonts.montserrat(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    StateListDropdown(
                                      callBack: (v) {
                                        setState(() {
                                          _stateIdController.text =
                                              v.stateId.toString();
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),

                            // District Dropdown
                            if (_stateIdController.text.trim().isNotEmpty) ...[
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    223,
                                    236,
                                    226,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Select District",
                                            style: GoogleFonts.montserrat(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      DistrctListDropDown(
                                        stateId: _stateIdController.text,
                                        callBack: (v) {
                                          setState(() {
                                            _districtIdController.text =
                                                v.districtId.toString();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            const SizedBox(height: 10),
                            // Tehsil Dropdown
                            if (_districtIdController.text
                                .trim()
                                .isNotEmpty) ...[
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    223,
                                    236,
                                    226,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Select Tehsil",
                                            style: GoogleFonts.montserrat(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 10),
                                      DistibruterLisDropDown(
                                        callBack: (e) {
                                          setState(() {
                                            _tehsilIdController.text =
                                                e.tehsilId.toString();
                                          });
                                        },
                                        stateId: _stateIdController.text,
                                        districId: _districtIdController.text,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],

                            Text(
                              "Pincode",
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: pincodeController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ),
                                ),
                                border: OutlineInputBorder(),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,

                                LengthLimitingTextInputFormatter(6), //
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
                              },
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
                              maxLines: 3,
                              maxLength:
                                  250, // ✅ Ye limit 250 characters tak kar dega
                              decoration: InputDecoration(
                                counterText:
                                    "", // Agar aapko neeche counter text ("0/250") nahi dikhana hai to isko rakho
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ),
                                ),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
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
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(12),
                              ],
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ),
                                ),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                
                                return null;
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
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z0-9]'),
                                ),
                                LengthLimitingTextInputFormatter(10),
                                UpperCaseTextFormatter(),
                              ],
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ),
                                ),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            Text(
                              "GST NO",
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: _gstinNoController,
                              inputFormatters: [  LengthLimitingTextInputFormatter(15)],
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ),
                                ),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
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
                              inputFormatters: [  LengthLimitingTextInputFormatter(10)],
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ),
                                ),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
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
                              inputFormatters: [LengthLimitingTextInputFormatter(50),],
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ),
                                ),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Save Button
                            Center(
                              child: ElevatedButton(
                                onPressed: () async {
                                  log(_stateIdController.text);
                                  if (snap.editAllow == true) {
                                    if (_formKey.currentState!.validate()) {
                                      if (_stateIdController.text
                                          .trim()
                                          .isEmpty) {
                                        Fluttertoast.showToast(
                                          msg: "State is required",
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                         gravity: ToastGravity.TOP_LEFT
                                        );
                                        return;
                                      }
                                      if (_districtIdController.text
                                          .trim()
                                          .isEmpty) {
                                        Fluttertoast.showToast(
                                          msg: "District is required",
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          gravity: ToastGravity.TOP_LEFT
                                        );
                                        return;
                                      }
                                      if (_tehsilIdController.text
                                          .trim()
                                          .isEmpty) {
                                        Fluttertoast.showToast(
                                          msg: "Tehsil is required",
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          gravity: ToastGravity.TOP_LEFT
                                        );
                                        
                                        return;
                                      }
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
                                              gender: selectedGender,
                                              dateOfBirth: dobController.text,
                                              emailId: emailController.text,
                                              aadhaarNo: int.parse(
                                                adharController.text,
                                              ),
                                              panNo: panNo.text,
                                              stateId: _stateIdController.text,
                                              districtId:
                                                  _districtIdController.text,
                                              tehsilId:
                                                  _tehsilIdController.text,
                                              pinCode: int.parse(
                                                pincodeController.text,
                                              ),
                                              gstinNo: _gstinNoController.text,
                                              address: addressController.text,
                                            ),
                                          );

                                      if (response.response.data['status'] ==
                                          true) {
                                        Fluttertoast.showToast(
                                          msg:
                                              response
                                                  .response
                                                  .data["status_desc"],
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          gravity: ToastGravity.TOP_LEFT
                                        );
                                        ref.invalidate(profileprovider);
                                        setState(() {
                                          btnLoder = false;
                                        });
                                      } else {
                                        setState(() {
                                          btnLoder = false;
                                        });
                                        Fluttertoast.showToast(
                                          msg:
                                              response
                                                  .response
                                                  .data["status_desc"],
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          gravity: ToastGravity.TOP_LEFT
                                        );
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "All fields are mandatory!",
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        gravity: ToastGravity.TOP_LEFT
                                      );
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                      msg:
                                          "It's not editable now. Contact help desk!",
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      gravity: ToastGravity.TOP_LEFT
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
  BoolStateNotifier() : super(false);

  void toggle() => state = !state;
  void setTrue() => state = true;
  void setFalse() => state = false;
}

final boolStateProvider = StateNotifierProvider<BoolStateNotifier, bool>(
  (ref) => BoolStateNotifier(),
);

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

class StateListDropdown extends ConsumerStatefulWidget {
  final Function(StateList) callBack;

  const StateListDropdown({super.key, required this.callBack});

  @override
  _StateListDropdownState createState() => _StateListDropdownState();
}

class _StateListDropdownState extends ConsumerState<StateListDropdown> {
  StateList? selectedCircle;
  String searchText = "";
  bool isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final stateListProvider = ref.watch(commonStateListProvider);

    return stateListProvider.when(
      data: (snap) {
        // apply search filter
        final filteredList =
            snap.stateList.where((e) {
              return e.stateName.toLowerCase().contains(
                searchText.toLowerCase(),
              );
            }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // main dropdown button
            GestureDetector(
              onTap: () {
                setState(() {
                  isDropdownOpen = !isDropdownOpen;
                });
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.gas_meter, color: Colors.black),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            selectedCircle?.stateName ?? "Select State",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Icon(
                        isDropdownOpen
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Dropdown Panel
            if (isDropdownOpen) ...[
              const SizedBox(height: 8),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search State',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: width * 0.04,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child:
                      filteredList.isEmpty
                          ? const Center(child: Text("No states found"))
                          : ListView.builder(
                            itemCount: filteredList.length,
                            itemBuilder: (context, index) {
                              final e = filteredList[index];
                              return ListTile(
                                title: Text(e.stateName),
                                onTap: () {
                                  setState(() {
                                    selectedCircle = e;
                                    isDropdownOpen = false;
                                    searchText = "";
                                    widget.callBack(e);
                                  });
                                },
                              );
                            },
                          ),
                ),
              ),
            ],
          ],
        );
      },
      error: (err, stack) => const SizedBox(),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

class DistrctListDropDown extends ConsumerStatefulWidget {
  final String stateId;
  final Function(DistrictList) callBack;

  const DistrctListDropDown({
    super.key,
    required this.callBack,
    required this.stateId,
  });

  @override
  _DistrctListDropDownState createState() => _DistrctListDropDownState();
}

class _DistrctListDropDownState extends ConsumerState<DistrctListDropDown> {
  DistrictList? selectedCircle;
  String searchText = "";
  bool isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final stateListProvider = ref.watch(
      commonDistrictListProvider(widget.stateId.toString()),
    );

    return stateListProvider.when(
      data: (snap) {
        // apply search filter
        final filteredList =
            snap.districtList.where((e) {
              return e.districtName.toLowerCase().contains(
                searchText.toLowerCase(),
              );
            }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // main dropdown button
            GestureDetector(
              onTap: () {
                setState(() {
                  isDropdownOpen = !isDropdownOpen;
                });
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.gas_meter, color: Colors.black),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            selectedCircle?.districtName ?? "Select District",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Icon(
                        isDropdownOpen
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Dropdown Panel
            if (isDropdownOpen) ...[
              const SizedBox(height: 8),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search State',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: width * 0.04,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child:
                      filteredList.isEmpty
                          ? const Center(child: Text("No states found"))
                          : ListView.builder(
                            itemCount: filteredList.length,
                            itemBuilder: (context, index) {
                              final e = filteredList[index];
                              return ListTile(
                                title: Text(e.districtName),
                                onTap: () {
                                  setState(() {
                                    selectedCircle = e;
                                    isDropdownOpen = false;
                                    searchText = "";
                                    widget.callBack(e);
                                  });
                                },
                              );
                            },
                          ),
                ),
              ),
            ],
          ],
        );
      },
      error: (err, stack) => const SizedBox(),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

class DistibruterLisDropDown extends ConsumerStatefulWidget {
  final String stateId;
  final String districId;
  final Function(TehsilList) callBack;

  const DistibruterLisDropDown({
    super.key,
    required this.callBack,
    required this.stateId,
    required this.districId,
  });

  @override
  _DistibruterLisDropDownState createState() => _DistibruterLisDropDownState();
}

class _DistibruterLisDropDownState
    extends ConsumerState<DistibruterLisDropDown> {
  TehsilList? selectedCircle;
  String searchText = "";
  bool isDropdownOpen = false;
  late Map<String, dynamic> bofy;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final stateListProvider = ref.watch(
      commonTehsilListProvider(int.parse(widget.districId)),
    );

    return stateListProvider.when(
      data: (snap) {
        // apply search filter
        final filteredList =
            snap.tehsilList.where((e) {
              return e.tehsilName.toLowerCase().contains(
                searchText.toLowerCase(),
              );
            }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // main dropdown button
            GestureDetector(
              onTap: () {
                setState(() {
                  isDropdownOpen = !isDropdownOpen;
                });
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.gas_meter, color: Colors.black),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            selectedCircle?.tehsilName ?? "Select Tehsil",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Icon(
                        isDropdownOpen
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Dropdown Panel
            if (isDropdownOpen) ...[
              const SizedBox(height: 8),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search State',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: width * 0.04,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child:
                      filteredList.isEmpty
                          ? const Center(child: Text("No states found"))
                          : ListView.builder(
                            itemCount: filteredList.length,
                            itemBuilder: (context, index) {
                              final e = filteredList[index];
                              return ListTile(
                                title: Text(e.tehsilName),
                                onTap: () {
                                  setState(() {
                                    selectedCircle = e;
                                    isDropdownOpen = false;
                                    searchText = "";
                                    widget.callBack(e);
                                  });
                                },
                              );
                            },
                          ),
                ),
              ),
            ],
          ],
        );
      },
      error: (err, stack) => const SizedBox(),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

void showErrorMessage({required String name}) {
  Fluttertoast.showToast(
    msg: "$name is required",
    backgroundColor: Colors.black,
    textColor: Colors.white,
  );
}
