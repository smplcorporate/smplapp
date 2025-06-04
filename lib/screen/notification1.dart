import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(NotificationApp());

class NotificationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification UI',
      debugShowCheckedModeBanner: false,
      home: NotificationScreen(),
    );
  }
}

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, String>> notifications = []; // Add data to see list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(top: 20,left: 20),
          child: Container(
            height: 40,width: 40,decoration: BoxDecoration(
shape: BoxShape.circle,color: Colors.white

            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {},
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'Notification',
            style: GoogleFonts.inter
            ( fontSize: 20,
              color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Icon(Icons.notifications_active_outlined,
                        size: 400, color: Colors.blue.shade100),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Nothing to Display Here!',
                  style: GoogleFonts.inter
          ( fontSize: 20,
            color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange.shade100,
                    child: Icon(Icons.monetization_on, color: Colors.orange),
                  ),
                  title: Text(item['title'] ?? '',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(item['message'] ?? ''),
                );
              },
            ),
    );
  }
}