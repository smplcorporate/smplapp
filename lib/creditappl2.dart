import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/crideitapl3.dart';
import 'package:home/screen/openaccount5.dart';

class CreditAppPage2 extends StatefulWidget {
  const CreditAppPage2({super.key});

  @override
  State<CreditAppPage2> createState() => _CreditAppPage2State();
}

class _CreditAppPage2State extends State<CreditAppPage2> {
  final _formKey = GlobalKey<FormState>();
  String? selectedCard;
  String? uploadedFileName;

  final List<String> cardOptions = [
    'Visa Credit Card',
    'MasterCard Credit Card',
    'Rupay Debit Card',
    'American Express Card',
    'SBI SimplySave',
    'HDFC Regalia',
    'ICICI Coral',
  ];

  final TextEditingController _cardController = TextEditingController();

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        uploadedFileName = result.files.single.name;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && uploadedFileName != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Details submitted successfully!')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CreditCardApplyPage3()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete the form')),
      );
    }
  }

  void _showCardOptions() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => ListView(
        shrinkWrap: true,
        children: cardOptions.map((card) {
          return ListTile(
            title: Text(  
              card,style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.bold,
             ),  
            ),
            onTap: () => Navigator.pop(context, card),
          );
        }).toList(),
      ),
    );

    if (selected != null) {
      setState(() {
        selectedCard = selected;
        _cardController.text = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          width: mediaWidth,
          height: mediaHeight,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 232, 243, 235),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with centered title
              Padding(
                padding: const EdgeInsets.all(16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Credit Card Apply',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Form Section
              Expanded(
                child: Container(
                  width: mediaWidth,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Choose a Card',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),

                                // TextFormField acting like dropdown
                                GestureDetector(
                                  onTap: _showCardOptions,
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      controller: _cardController,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        hintText: 'Select Card ',hintStyle: GoogleFonts.inter(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),
                                        suffixIcon: const Icon(Icons.arrow_drop_down,size: 40,color: Colors.black,),
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 16),
                                      ),
                                      validator: (value) => value == null || value.isEmpty
                                          ? 'Please choose a card'
                                          : null,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                Text(
                                  'Upload Aadhar/PAN',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  margin: const EdgeInsets.only(top: 6),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  child: Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: _pickFile,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 15),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          elevation: 5,
                                        ),
                                        child: Text(
                                          'Choose File',
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          uploadedFileName ?? 'No File Chosen',
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Bottom-right aligned Next button
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              elevation: 5,
                            ),
                            child: Text(
                              "Next",
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 19,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
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
