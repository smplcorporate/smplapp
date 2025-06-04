import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart'
    hide Barcode;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:home/screen/scanpay.dart'; // Ensure this screen exists

class ScanPayScreen extends StatefulWidget {
  @override
  _ScanPayScreenState createState() => _ScanPayScreenState();
}

class _ScanPayScreenState extends State<ScanPayScreen> {
  final ImagePicker picker = ImagePicker();
  final MobileScannerController cameraController = MobileScannerController();
  bool _hasScanned = false;

  final List<Map<String, String>> suggestions = [
    {"name": "Rohit Goyal", "image": "assets/rg.png"},
    {"name": "Shreya Goyal", "image": "assets/sg.png"},
    {"name": "Sumit Goyal", "image": "assets/sumitg.png"},
    {"name": "Sameer Goyal", "image": "assets/smeer.png"},
    {"name": "Tanishq Goyal", "image": "assets/rg.png"},
  ];

  void _onDetect(BarcodeCapture capture) {
    if (_hasScanned) return;
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final String? code = barcodes.first.rawValue;
      if (code != null) {
        _hasScanned = true;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ScanAndPayScreen()),
        ).then((_) => _hasScanned = false);
      }
    }
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;

    final inputImage = InputImage.fromFile(File(pickedImage.path));
    final barcodeScanner = BarcodeScanner();
    final barcodes = await barcodeScanner.processImage(inputImage);

    if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ScanAndPayScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No QR code found in the image.")),
      );
    }
  }

  void _toggleFlash() {
    cameraController.toggleTorch();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final double padding = media.width * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: padding, top: 20),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFFE6E6E6)),
              ),
              child:
                  Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 25),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Text(
            "Scan & Pay",
            style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: media.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: media.height * 0.02),
            Text(
              "Suggestion",
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold, fontSize: media.width * 0.045),
            ),
            SizedBox(height: media.height * 0.02),
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final user = suggestions[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(user['image']!),
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          width: 60,
                          child: Text(
                            user['name']!,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                                fontSize: 10, color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: media.height * 0.03),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: media.width * 0.75,
                    height: media.width * 0.75,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: MobileScanner(
                        controller: cameraController,
                        onDetect: _onDetect,
                      ),
                    ),
                  ),
                  Positioned(
                    child: CustomPaint(
                      size: Size(media.width * 0.8, media.width * 0.8),
                      painter: QRScannerOverlayPainter(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: media.height * 0.03),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.flash_on,
                        color: Color(0xFF44806A), size: 35),
                    onPressed: _toggleFlash,
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    icon:
                        Icon(Icons.image, color: Color(0xFF44806A), size: 35),
                    onPressed: _pickImageFromGallery,
                  ),
                ],
              ),
            ),
            SizedBox(height: media.height * 0.05),
            Center(
              child: Column(
                children: [
                  Text(
                    "Scan & Pay Instantly",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: media.width * 0.05,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Make secure, contactless payments with just a\nquick scan",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: media.width * 0.032,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class QRScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF44806A)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    const double length = 30.0;

    // Corners
    canvas.drawLine(Offset(0, 0), Offset(length, 0), paint);
    canvas.drawLine(Offset(0, 0), Offset(0, length), paint);

    canvas.drawLine(Offset(size.width, 0), Offset(size.width - length, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, length), paint);

    canvas.drawLine(Offset(0, size.height), Offset(0, size.height - length), paint);
    canvas.drawLine(Offset(0, size.height), Offset(length, size.height), paint);

    canvas.drawLine(Offset(size.width, size.height), Offset(size.width, size.height - length), paint);
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width - length, size.height), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
