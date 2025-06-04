// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:home/screen/sendamount.dart';



class Contact {
  final String name;
  final String upiId;

  Contact(this.name, this.upiId);
}

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final List<Contact> contacts = List.generate(
    10,
    (index) => Contact('Shreya Goyal', '98765432$index@upi'),
  );

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredContacts = contacts
        .where((contact) =>
            contact.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
            contact.upiId.contains(searchQuery))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 232, 243, 235),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search by name, number or UPI ID',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredContacts.length,
                itemBuilder: (context, index) {
                  final contact = filteredContacts[index];
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 68, 128, 106),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(contact.name),
                    subtitle: Text(contact.upiId),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UPIChatApp(),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


