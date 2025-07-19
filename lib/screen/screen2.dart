import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/config/colors.dart';
import 'package:home/data/controller/wallet.provider.dart';
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
    Future.microtask(() => ref.refresh(getWalleStatementProider));
  }

  @override
  Widget build(BuildContext context) {
    final statement = ref.watch(getWalleStatementProider);
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
                                      "₹${snap.balance}",
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
                      itemCount: snap.statementList.length,
                      itemBuilder: (context, index) {
                        return TransactionTile(
                          statement: snap.statementList[index],
                          transaction: Transaction(
                            status: "Done",
                            name: "",
                            date: snap.statementList[index].date,
                            amount:
                                snap.statementList[index].credit == 0.00
                                    ? snap.statementList[index].debit.toString()
                                    : snap.statementList[index].credit
                                        .toString(),
                            isCredit:
                                snap.statementList[index].credit == 0.00
                                    ? false
                                    : true,
                            isSuccess: true,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        error: (err, stack) {
          return Center(
            child: Text(
              "$stack",
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 20.w,
              ),
            ),
          );
        },
        loading: () {
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

// Transaction Class
class Transaction {
  final String status;
  final String name;
  final String date;
  final String amount;
  final bool isCredit;
  final bool isSuccess;

  Transaction({
    required this.status,
    required this.name,
    required this.date,
    required this.amount,
    required this.isCredit,
    required this.isSuccess,
  });
}

// Transaction Tile (List Item)
class TransactionTile extends StatelessWidget {
  final Transaction transaction;
  final StatementList statement;
  const TransactionTile({
    required this.transaction,
    super.key,
    required this.statement,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to Transaction Success Page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TransactionDetailsPage(data: statement,)),
        );
      },
      child: Container(
        height: 80.h,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Arrow icon with date below
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 210.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 68, 128, 106),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            transaction.isCredit
                                ? 'assets/arrow1.png'
                                : 'assets/arrow2.png',
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              statement.transId,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: const Color.fromARGB(255, 48, 47, 47),
                              ),
                            ),
                            Text(
                              transaction.status,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),
                Text(
                  transaction.date,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Color.fromARGB(255, 153, 153, 153),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 18),

            // Transaction info

            // Amount and bank info
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 4),
              
                Row(
                  children: [
                    Text(
                      transaction.isCredit ? "Credited to" : "Debited to",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Image.asset('assets/sbi1.png', width: 25, height: 25),
                  ],
                ),
                Spacer(),
                SizedBox(height: 3.h),
                Text(
                  "₹${transaction.amount}",
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
