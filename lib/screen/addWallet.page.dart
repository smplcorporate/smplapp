import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddWalletPage extends StatefulWidget {
  @override
  _AddWalletPageState createState() => _AddWalletPageState();
}

class _AddWalletPageState extends State<AddWalletPage> {
  final _formKey = GlobalKey<FormState>();
  String? ipAddress = 'aa';
  int? bankId = 2;
  double? transAmount = 500.0;
  String? transferType = 'IMPS';
  String? bankReferenceId = 'TES1233';
  String? depositDate = '28-03-2025';
  String? userMpin = '123456';
  File? selectedImage; // For image picker
  final ImagePicker _picker = ImagePicker();

  // Image Picker Function
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Money to Wallet', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green[700],
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[50]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IP Address
                TextFormField(
                  initialValue: ipAddress,
                  decoration: InputDecoration(
                    labelText: 'IP Address',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  readOnly: true,
                ),
                SizedBox(height: 10),
                // Bank ID
                TextFormField(
                  initialValue: bankId.toString(),
                  decoration: InputDecoration(
                    labelText: 'Bank ID',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  readOnly: true,
                ),
                SizedBox(height: 10),
                // Transaction Amount
                TextFormField(
                  initialValue: transAmount.toString(),
                  decoration: InputDecoration(
                    labelText: 'Transaction Amount (₹)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  keyboardType: TextInputType.number,
                  readOnly: true,
                ),
                SizedBox(height: 10),
                // Transfer Type
                TextFormField(
                  initialValue: transferType,
                  decoration: InputDecoration(
                    labelText: 'Transfer Type',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  readOnly: true,
                ),
                SizedBox(height: 10),
                // Bank Reference ID
                TextFormField(
                  initialValue: bankReferenceId,
                  decoration: InputDecoration(
                    labelText: 'Bank Reference ID',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  readOnly: true,
                ),
                SizedBox(height: 10),
                // Deposit Date
                TextFormField(
                  initialValue: depositDate,
                  decoration: InputDecoration(
                    labelText: 'Deposit Date',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  readOnly: true,
                ),
                SizedBox(height: 10),
                // User MPIN
                TextFormField(
                  initialValue: userMpin,
                  decoration: InputDecoration(
                    labelText: 'User MPIN',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  obscureText: true,
                  readOnly: true,
                ),
                SizedBox(height: 20),
                // Image Preview
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Transaction Receipt', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    // selectedImage != null
                    //     ? Image.file(
                    //         selectedImage!,
                    //         height: 150,
                    //         width: 150,
                    //         fit: BoxFit.cover,
                    //       )
                    //     : Image.network(
                    //         'https://via.placeholder.com/150',
                    //         height: 150,
                    //         width: 150,
                    //         fit: BoxFit.cover,
                    //       ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _pickImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text('Upload Receipt', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Money Added Successfully!')),
                        );
                        Navigator.pop(context); // Go back to previous page
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(
                      'Confirm Payment',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}