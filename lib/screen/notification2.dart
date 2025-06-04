import 'package:flutter/material.dart';

// NotificationScreen2 with back navigation functionality
class NotificationScreen2 extends StatefulWidget {
  @override
  _NotificationScreen2State createState() => _NotificationScreen2State();
}

class _NotificationScreen2State extends State<NotificationScreen2> {
  List<Map<String, String>> notifications = [
    // Example notifications (can be empty for the "Nothing to Display" state)
    {
      'title': 'You Earned ₹300 ',
      'message': 'You got cashback + crate bonus!',
    },
    {
      'title': 'You Earned ₹400',
      'message': 'You got cashback + crate bonus!',
    },
    {
      'title': 'You Earned ₹600',
      'message': 'You got cashback + crate bonus!',
    },
    {
      'title': 'You Earned ₹500',
      'message': 'You got cashback + crate bonus!',
    },
    {
      'title': 'You Earned ₹200',
      'message': 'You got cashback + crate bonus!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Back button functionality
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            // Navigator.pop(context) will pop the current screen and navigate back
            Navigator.pop(context);
          },
        ),
        title: Text('Notification'),
        centerTitle: true,
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_none, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Nothing to Display Here!',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/bon.png'),
                      backgroundColor: const Color.fromARGB(255, 245, 244, 244),
                      child: Icon(Icons.monetization_on, color: Colors.orange),
                    ),
                    title: Text(item['title'] ?? ''),
                    subtitle: Text(item['message'] ?? ''),
                  ),
                );
              },
            ),
    );
  }
}
