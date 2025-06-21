import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/data/controller/wallet.provider.dart';
import 'package:home/data/model/wallet.statementBody.dart';
import 'package:home/screen/addWallet.page.dart';

class MyWalletPage extends ConsumerStatefulWidget {
  @override
  _MyWalletPageState createState() => _MyWalletPageState();
}

class _MyWalletPageState extends ConsumerState<MyWalletPage> {
  int balance = 1640;
  String selectedTab = 'All';

  final transactions = [
    {'type': 'Credit', 'amount': 1000, 'date': '13 April 2024'},
    {'type': 'Debit', 'amount': 900, 'date': '13 April 2024'},
    {'type': 'Credit', 'amount': 65, 'date': '13 April 2024'},
    {'type': 'Debit', 'amount': 75, 'date': '13 April 2024'},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final data = ref.watch(getWalleStatementProider);
    return Scaffold(
      body: data.when(
        data: (snap) {
          return Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 232, 243, 235),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(size.width * 0.04),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 2,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new,
                                    size: 25,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "My Wallet",
                                    style: GoogleFonts.inter(
                                      fontSize: size.width * 0.045,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 44),
                            ],
                          ),
                          SizedBox(height: size.height * 0.02),
                          Container(
                            padding: EdgeInsets.all(size.width * 0.05),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.account_balance_wallet,
                                  size: 40,
                                  color: Color.fromARGB(255, 68, 128, 106),
                                ),
                                SizedBox(height: size.height * 0.01),
                                Text(
                                  "Your Balance Is",
                                  style: GoogleFonts.inter(
                                    fontSize: size.width * 0.035,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "₹${snap.balance}.00",
                                  style: GoogleFonts.inter(
                                    fontSize: size.width * 0.07,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: size.height * 0.015),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                          255,
                                          246,
                                          139,
                                          33,
                                        ),
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder:
                                                (context) => AddWalletPage(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Add Money",
                                        style: GoogleFonts.inter(
                                          fontSize: size.width * 0.035,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.orange,
                                        backgroundColor: Colors.white,
                                        side: const BorderSide(
                                          color: Color.fromARGB(
                                            255,
                                            246,
                                            139,
                                            33,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        "Withdraw",
                                        style: GoogleFonts.inter(
                                          fontSize: size.width * 0.035,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildTabButton('All', size),
                              _buildTabButton('Credit', size),
                              _buildTabButton('Debit', size),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.04,
                      ),
                      itemCount:
                          snap.statementList
                              .where(
                                (tx) =>
                                    selectedTab == 'All' ||
                                    (selectedTab == 'Credit' &&
                                        tx.credit != 0.00) ||
                                    (selectedTab == 'Debit' &&
                                        tx.credit == 0.00),
                              )
                              .length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final filteredTx =
                            snap.statementList
                                .where(
                                  (tx) =>
                                      selectedTab == 'All' ||
                                      (selectedTab == 'Credit' &&
                                          tx.credit != 0.00) ||
                                      (selectedTab == 'Debit' &&
                                          tx.credit == 0.00),
                                )
                                .toList()[index];
                        return _buildTransactionTile(filteredTx, size);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        error: (err, stack) {
          return Center(child: Text("$err"));
        },
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildTabButton(String label, Size size) {
    bool isSelected = selectedTab == label;

    return SizedBox(
      width: size.width * 0.28,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : Colors.black,
          backgroundColor:
              isSelected
                  ? const Color.fromARGB(255, 68, 128, 106)
                  : Colors.white,
          padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
        ),
        onPressed: () {
          setState(() {
            selectedTab = label;
          });
        },
        child: Text(
          label,
          style: GoogleFonts.inter(fontSize: size.width * 0.04),
        ),
      ),
    );
  }

  Widget _buildTransactionTile(StatementList tx, Size size) {
    bool isCredit = tx.credit == 0.00;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: 12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon + Date column
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: size.height * 0.06,
                  width: size.height * 0.06,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 68, 128, 106),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isCredit ? Icons.call_received : Icons.call_made,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  tx.date,
                  style: GoogleFonts.inter(
                    fontSize: size.width * 0.027,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(width: size.width * 0.04),

            // Title and subtitle column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isCredit ? 'Received From' : 'Paid To',
                    style: GoogleFonts.inter(
                      fontSize: size.width * 0.038,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Shreya Goyal',
                    style: GoogleFonts.inter(
                      fontSize: size.width * 0.032,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Amount and bank info column
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "₹${tx.credit}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.04,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isCredit ? 'Credited to' : 'Debited to',
                      style: GoogleFonts.inter(fontSize: size.width * 0.03),
                    ),
                    SizedBox(width: 5),
                    Image.asset(
                      'assets/sbi1.png', // Ensure this asset exists
                      width: size.width * 0.04,
                      height: size.width * 0.04,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
