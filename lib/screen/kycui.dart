import 'package:flutter/material.dart';

void main() => runApp(KYCApp());

class KYCApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KYCVerificationPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class KYCVerificationPage extends StatelessWidget {
  Widget buildCard({
    required String title,
    required String document,
    required String validity,
    required List<String> benefits,
    required bool isCompleted,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                isCompleted
                    ? Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green),
                          SizedBox(width: 4),
                          Text("Completed",
                              style: TextStyle(color: Colors.green)),
                        ],
                      )
                    : ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: StadiumBorder(),
                        ),
                        child: Text("Get Start"),
                      )
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Required Document", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(document),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Validity", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(validity),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Text("Benefits", style: TextStyle(fontWeight: FontWeight.bold)),
            ...benefits.map((b) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Icon(Icons.circle, size: 6),
                      SizedBox(width: 6),
                      Expanded(child: Text(b))
                    ],
                  ),
                )),
            SizedBox(height: 6),
            Text("*Select to change based on the bank's risk categorization",
                style: TextStyle(fontSize: 12, color: Colors.grey[600]))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("KYC Verification"),
        leading: Icon(Icons.arrow_back),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Verify your identity to unlock seamless and secure digital transactions. It only takes a few minutes to complete",
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
            buildCard(
              title: "Mini KYC",
              document: "Pan Card",
              validity: "Lifetime*",
              benefits: [
                "Wallet Balance Upto ₹10,000",
                "Pay to merchants"
              ],
              isCompleted: false,
            ),
            buildCard(
              title: "Full KYC",
              document: "Pan Card",
              validity: "Lifetime*",
              benefits: [
                "Wallet Balance Upto ₹10,000",
                "Pay to merchants"
              ],
              isCompleted: true,
            ),
            buildCard(
              title: "Bank KYC",
              document: "Pan Card",
              validity: "Lifetime*",
              benefits: [
                "Wallet Balance Upto ₹10,000",
                "Pay to merchants"
              ],
              isCompleted: false,
            ),
          ],
        ),
      ),
    );
  }
}