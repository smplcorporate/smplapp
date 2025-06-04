import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCommissionPage extends StatelessWidget {
  const MyCommissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 375;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 12 * scale, top: 8 * scale, bottom: 8 * scale),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4 * scale)],
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20 * scale),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          "My Commission",
          style: GoogleFonts.inter(
            fontSize: 18 * scale,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your commission summary:",
              style: GoogleFonts.inter(fontSize: 18 * scale, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20 * scale),

            // Commission summary box
            Container(
              padding: EdgeInsets.all(20 * scale),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 243, 235),
                borderRadius: BorderRadius.circular(12 * scale),
                border: Border.all(color: Colors.green.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Commission Earned",
                    style: GoogleFonts.inter(fontSize: 16 * scale, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10 * scale),
                  Text(
                    "₹12,345.67",
                    style: GoogleFonts.inter(
                      fontSize: 32 * scale,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 68, 128, 106),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30 * scale),

            Text(
              "Recent Commissions",
              style: GoogleFonts.inter(fontSize: 18 * scale, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12 * scale),

            Expanded(
              child: ListView(
                children: [
                  commissionListItem("Order #1234", "₹123.45", "2025-05-30", scale),
                  commissionListItem("Order #1233", "₹99.99", "2025-05-28", scale),
                  commissionListItem("Order #1232", "₹150.00", "2025-05-27", scale),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget commissionListItem(String orderId, String amount, String date, double scale) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.symmetric(vertical: 6 * scale),
      child: ListTile(
        leading: Icon(Icons.monetization_on, color: const Color.fromARGB(255, 68, 128, 106), size: 24 * scale),
        title: Text(orderId, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14 * scale)),
        subtitle: Text(date, style: GoogleFonts.inter(color: Colors.grey.shade600, fontSize: 12 * scale)),
        trailing: Text(amount, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14 * scale)),
      ),
    );
  }
}
