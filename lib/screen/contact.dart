// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';



class Contact {
  final String name;
  final String upiId;

  Contact(this.name, this.upiId);
}

class contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UPI Contact List',
      theme: ThemeData(primarySwatch: Colors.green),
      home: ContactListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final List<Contact> contacts = List.generate(
    10,
    (index) => Contact('Shreya Goyal', '98765432${index}'),
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
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color:  const Color.fromARGB(255, 232, 243, 235),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search by name, number or UPI id',
                  prefixIcon: Icon(Icons.search),
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
                    leading: CircleAvatar(
                      backgroundColor: Color.fromARGB(255,68, 128, 106),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(contact.name),
                    subtitle: Text(contact.upiId),
                    onTap: () {
                      // Add navigation or payment logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Selected ${contact.name}')),
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