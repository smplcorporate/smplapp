import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:image_picker/image_picker.dart';

class KYCVerificationForm extends StatefulWidget {
  final String document_id;

  const KYCVerificationForm({super.key, required this.document_id});
  @override
  State<KYCVerificationForm> createState() => _KYCVerificationFormState();
}

class _KYCVerificationFormState extends State<KYCVerificationForm> {
  File? _selectedImage;
  bool _isLoading = false;

  Future<void> _pickImage({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 1080,
      maxHeight: 1080,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.teal),
                title: const Text('Take a photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(fromCamera: true);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.teal),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(fromCamera: false);
                },
              ),
            ],
          ),
        );
      },
    );
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
        title: Text(
          'KYC Verification Form',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              padding: const EdgeInsets.only(top: 40.0),
              children: [
                Text(
                  'Complete your KYC to unlock secure digital transactions.',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color.fromARGB(255, 130, 130, 130),
                  ),
                ),
                const SizedBox(height: 15),
                _buildField(
                  label: 'Document Type',
                  initialValue: widget.document_id,
                ),
                const SizedBox(height: 15),
                _buildImageUploadField(label: 'Upload Document Proof Image'),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    if (_isLoading == false) {
                      try {
                        // Call your upload function here
                        setState(() {
                          _isLoading = true;
                        });
                        final api = APIStateNetwork(await createDio());
                        final response = await api.uploadKycDocument(
                          '127.0.0.1',
                          '${widget.document_id}',
                          File(_selectedImage!.path),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              response.response.data["status_desc"],
                              style: GoogleFonts.inter(fontSize: 14),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                        setState(() {
                          _isLoading = false;
                          _selectedImage = null; // Reset the image after upload
                        });
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Error uploading document. Please try again.',
                              style: GoogleFonts.inter(fontSize: 14),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 68, 128, 106),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child:
                          _isLoading == true
                              ? Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: CircularProgressIndicator(color: Colors.white,),
                              )
                              : Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Text(
                                  'Submit',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField({required String label, required String? initialValue}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color.fromARGB(255, 166, 192, 173)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 68, 128, 106),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(height: 30, child: Text(initialValue ?? '')),
        ],
      ),
    );
  }

  Widget _buildImageUploadField({required String label}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color.fromARGB(255, 166, 192, 173)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 68, 128, 106),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: _showImageSourceSelector,
            child:
                _selectedImage == null
                    ? Container(
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 166, 192, 173),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.image,
                          size: 40,
                          color: const Color.fromARGB(
                            255,
                            68,
                            128,
                            106,
                          ).withOpacity(0.7),
                        ),
                      ),
                    )
                    : Container(
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(_selectedImage!),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: const Color.fromARGB(255, 166, 192, 173),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              'Tap to upload image',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: const Color.fromARGB(255, 68, 128, 106),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
