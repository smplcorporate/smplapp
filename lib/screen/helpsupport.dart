import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:home/data/controller/userAllTickets.provider.dart';
import 'package:image_picker/image_picker.dart';



class SupportTicketsPage extends ConsumerStatefulWidget {


  const SupportTicketsPage({Key? key,}) : super(key: key);

  @override
  ConsumerState<SupportTicketsPage> createState() => _SupportTicketsPageState();
}

class _SupportTicketsPageState extends ConsumerState<SupportTicketsPage> {
bool _isInitialized = false;
  
  @override
void didChangeDependencies() {
  super.didChangeDependencies();

  ref.refresh(userAllTicketsProvider);
}
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(userAllTicketsProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 232, 243, 235),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  'Support Tickets',
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: data.when(
        data: (response) {
          if (response.status) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatCard("All Tickets", response.ticketsAll.toString()),
                      _buildStatCard("Pending Tickets", response.ticketsPending.toString()),
                      _buildStatCard("Closed Tickets", response.ticketsClosed.toString()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: response.ticketsList.length,
                      itemBuilder: (context, index) {
                        final ticket = response.ticketsList[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            tileColor: Colors.white,
                            title: Text(ticket.subject, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold)),
                            subtitle: Text('Status: ${ticket.status}\nDate Created: ${ticket.dateSupport}\nDate Closed: ${ticket.dateClosed}'),
                            trailing: Text(ticket.ticketId, style: GoogleFonts.inter(color: Colors.grey)),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(response.statusDesc, style: GoogleFonts.inter(fontSize: 16, color: Colors.red)),
            );
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text("No Tickets Found", style: GoogleFonts.inter(fontSize: 18, color: Colors.black)),
        ),
      ),
      bottomSheet: Container(
        color: const Color.fromARGB(255, 232, 243, 235),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ElevatedButton(
            onPressed: () {
              // TODO: Implement navigation to ticket raising page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TicketRaisePage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 68, 128, 106),
              minimumSize: const Size(double.infinity, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              "Raise Ticket",
              style: GoogleFonts.inter(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      child: Container(
        width: 100.w,
        height: 80.h,
      
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 68, 128, 106),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TicketRaisePage extends StatefulWidget {
  @override
  _TicketRaisePageState createState() => _TicketRaisePageState();
}

class _TicketRaisePageState extends State<TicketRaisePage> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  bool btnLoder = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      appBar: AppBar(
        title: Text('Raise Support Ticket'),
        backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(
                  labelText: 'Subject',
                  labelStyle: GoogleFonts.inter(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  fillColor: const Color.fromARGB(255, 232, 243, 235),
                  filled: true,
                ),
                maxLength: 50,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter a subject';
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelStyle: GoogleFonts.inter(color: Colors.black),
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  fillColor: const Color.fromARGB(255, 232, 243, 235),
                  filled: true,
                ),
                maxLength: 300,
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter a description';
                  return null;
                },
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:
                      _imageFile == null
                          ? Center(
                            child: Text(
                              'Upload any proof of issue',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          )
                          : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              _imageFile!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200,
                            ),
                          ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      setState(() {
                        btnLoder = true;
                      });
                      final api = APIStateNetwork(await createDio());
                      final response = await api.ticketRezie(
                        "127.0.0.1",
                        _subjectController.text,
                        _descriptionController.text,
                        File(_imageFile!.path),
                      );
                      if (response.response.data['Status'] == true) {
                        showTicketDialog(
                          context,
                          response.response.data['ticket_id'],
                          response.response.data['status_desc'],
                        );
                      } else {
                        showTicketDialog(
                          context,
                          "",
                          response.response.data['status_desc'],
                        );
                      }
                      setState(() {
                        btnLoder = false;
                      });
                    } catch (e) {
                      setState(() {
                        btnLoder = false;
                      });
                    }
                  }
                  // Navigator.push(
                  //   context,
                  //   CupertinoPageRoute(builder: (context) => TicketRaisePage()),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child:
                    btnLoder == true
                        ? Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                        : Text(
                          "Submit",
                          style: GoogleFonts.inter(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showTicketDialog(BuildContext context, String ticketId, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Ticket Info',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.confirmation_number, color: Colors.blue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Ticket ID: $ticketId',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(message, style: const TextStyle(color: Colors.black87)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context);
                Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => const SupportTicketsPage()));
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }
}
