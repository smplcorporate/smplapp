import 'package:flutter/material.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar with iOS back arrow in a circle
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  // Circle Back Button
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          )
                        ],
                      ),
                      child: Icon(Icons.arrow_back_ios_new, size: 20),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Centered Title Text
                  Expanded(
                    child: Center(
                      child: Text(
                        'Transaction Details',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 44), // To balance the row due to back button width
                ],
              ),
            ),

            // Transaction Card with reduced height
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.66,
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildRow('Bank Name', 'STATE BANK OF INDIA'),
                        buildRow('Services Name', 'CASH WITHDRAWAL'),
                        buildRow('Services Account', '**7896'),
                        buildRow('Bank RRN', '4567421098'),
                        buildRow('Order ID', 'CMB768924567421098'),
                        buildRow('SPB transaction ID', 'SMB7684567421098'),
                        buildRow('EMITRA Receipt No.', '7421098'),
                        buildRow('EMITRA Trans. No.', '7421098'),
                        buildRow('Transaction Amount', ''),
                        buildRow('Status', 'SUCCESS', valueColor: Colors.green),
                        buildRow('Remark', 'REQUEST COMPLETED'),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.download),
                            label: const Text('Download Receipt'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Bottom Button with spacing
            const SizedBox(height: 150),
            Container(
              width: 350,
              height: 50,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.green],
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: const Center(
                child: Text(
                  'Transaction Complete',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildRow(String title, String value, {Color valueColor = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              '$title :',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: TextStyle(color: valueColor),
            ),
          ),
        ],
      ),
    );
  }
}
