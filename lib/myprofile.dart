import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

void main() {
  runApp(const MaterialApp(
    home: MyProfileScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  File? _profileImage;
  String? _selectedGender;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
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
        builder: (_) => Dialog(
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
            border: Border.all(
             color: const Color.fromARGB(255, 125, 125, 125)
            ),
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
                  color: isSelected ? const Color.fromARGB(255,  68, 128, 106) : Colors.transparent,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 236, 226),
      body: SafeArea(
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
                        fontSize: 20,
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
                            _profileImage != null ? FileImage(_profileImage!) : null,
                        child: _profileImage == null
                            ? const Icon(Icons.person,
                                size: 40,
                                color: Color.fromARGB(255, 68, 128, 106))
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
                          child: Icon(Icons.camera_alt,
                              size: 18,
                              color: Color.fromARGB(255, 68, 128, 106)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "Ankit Sharma",
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "+91 1234567879",
                  style: GoogleFonts.inter(
                    fontSize:15,
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
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                  
                      Text("Full Name",
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                                  SizedBox(height: 5,),
                   const TextField(
  decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 125, 125, 125)), // Default border color
    ),
    focusedBorder: OutlineInputBorder(
      // borderSide: BorderSide(color: Colors.green, width: 2.0), // On focus
    ),
    border: OutlineInputBorder(), // Fallback default
  ),
),
                      const SizedBox(height: 10),
                  
                      Text("Date of Birth",
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                                  SizedBox(height: 5,),
                                     const TextField(
  decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 125, 125, 125)), // Default border color
    ),
    focusedBorder: OutlineInputBorder(
      // borderSide: BorderSide(color: Colors.green, width: 2.0), // On focus
    ),
    border: OutlineInputBorder(), // Fallback default
  ),
),
                      const SizedBox(height: 10),
                  
                      Text("Gender",
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          genderOption("Male"),
                          const SizedBox(width: 10),
                          genderOption("Female"),
                          const SizedBox(width: 10),
                          genderOption("Other"),
                        ],
                      ),
                      const SizedBox(height: 10),
                  
                      Text("Address",
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                                  SizedBox(height: 5,),
                                   const TextField(
  decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 125, 125, 125)), // Default border color
    ),
    focusedBorder: OutlineInputBorder(
      // borderSide: BorderSide(color: Colors.green, width: 2.0), // On focus
    ),
    border: OutlineInputBorder(), // Fallback default
  ),
),
                      const SizedBox(height: 20),
                  
                      Text("Contact Details",
                          style: GoogleFonts.inter(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                  
                      Text("Mobile Number",
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                                  SizedBox(height: 5,),
                                  const TextField(
  decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 125, 125, 125)), // Default border color
    ),
    focusedBorder: OutlineInputBorder(
      // borderSide: BorderSide(color: Colors.green, width: 2.0), // On focus
    ),
    border: OutlineInputBorder(), // Fallback default
  ),
),
                      const SizedBox(height: 10),
                  
                      Text("Email ID",
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                              SizedBox(height: 5,),
                                 const TextField(
  decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 125, 125, 125)), // Default border color
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
                          onPressed: () {
                            // Save logic
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 68, 128, 106),
                            minimumSize: const Size(double.infinity, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text("Save",
                              style: GoogleFonts.inter(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
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
  }
}
