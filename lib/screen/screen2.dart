import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/config/colors.dart';
import 'package:home/data/controller/orderList.provider.dart';
import 'package:home/data/controller/wallet.provider.dart';
import 'package:home/data/model/orderList.res.dart';
import 'package:home/data/model/wallet.statementBody.dart';
import 'package:home/screen/payment.dart';
import 'package:intl/intl.dart';

// Main App Entry

// TransactionPage Screen
class TransactionPage extends ConsumerStatefulWidget {
  const TransactionPage({super.key});

  @override
  ConsumerState<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends ConsumerState<TransactionPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => ref.refresh(orderListProvider));
  }

  @override
  Widget build(BuildContext context) {
    final statement = ref.watch(orderListProvider);
    return Scaffold(
      body: statement.when(
        data: (snap) {
          return Container(
            decoration: const BoxDecoration(
              color: const Color.fromARGB(255, 232, 243, 235),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Search by name, number or UPI ID",
                            prefixIcon: const Icon(Icons.search, size: 30),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 249, 249, 247),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${formatMonthYear(DateTime.now())}",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.download, size: 25),
                                    const SizedBox(width: 8),
                                    Text(
                                      "₹${snap.success}",
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snap.ordersList.length,
                      itemBuilder: (context, index) {
                        return OrderCard(order: snap.ordersList[index],);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        error: (err, stack) {
          return NoTransactionWidget();
        },
        loading: () {
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrdersList order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    Color statusColor(String status) {
      switch (status.toLowerCase()) {
        case 'success':
          return Colors.green;
        case 'pending':
          return Colors.orange;
        case 'failed':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Logo
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                order.transLogo,
                height: 40,
                width: 40,
                errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
              ),
            ),
            const SizedBox(width: 12),
            // Info Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.serviceProvider,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ID: ${order.transId}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    'Account: ₹${order.serviceAccount}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    order.transDate,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            // Amount and Status
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹ ${order.transAmount}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor(order.transStatus).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    order.transStatus.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      color: statusColor(order.transStatus),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }}

// Transaction Class


// Transaction Tile (List Item)


// // Transaction Success Page
// class TransactionSuccessPage extends StatelessWidget {
//   final Transaction transaction;

//   const TransactionSuccessPage({Key? key, required this.transaction}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Transaction Details"),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Transaction Status: ${transaction.status}",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text("Name: ${transaction.name}"),
//             SizedBox(height: 10),
//             Text("Date: ${transaction.date}"),
//             SizedBox(height: 10),
//             Text("Amount: ₹${transaction.amount}"),
//             SizedBox(height: 10),
//             Text("Transaction ${transaction.isSuccess ? 'Successful' : 'Failed'}"),
//           ],
//         ),
//       ),
//     );
//   }
// }

String formatMonthYear(DateTime date) {
  return DateFormat('MMMM yyyy').format(date);
}



class NoTransactionWidget extends StatelessWidget {
  const NoTransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 232, 243, 235),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
             color: const Color.fromARGB(255, 232, 243, 235),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.line_axis_rounded, color: Colors.green.shade900, size: 50,),
                const SizedBox(height: 20),
                Text(
                  "No transactions yet",
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Your transaction history will show up here\nonce you make a payment.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.grey,
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
