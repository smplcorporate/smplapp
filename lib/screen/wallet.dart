import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyWalletApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyWalletPage(),
    );
  }
}

class MyWalletPage extends StatefulWidget {
  @override
  _MyWalletPageState createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage> {
  int balance = 1640;
  String selectedTab = 'All';

  final transactions = [
    {'type': 'Credit', 'amount': 1000, 'date': '13 April 2024'},
    {'type': 'Debit', 'amount': 900, 'date': '13 April 2024'},
    {'type': 'Credit', 'amount': 65, 'date': '13 April 2024'},
    {'type': 'Debit', 'amount': 75, 'date': '13 April 2024'},
    {'type': 'Credit', 'amount': 1000, 'date': '13 April 2024'},
    {'type': 'Debit', 'amount': 900, 'date': '13 April 2024'},
    {'type': 'Credit', 'amount': 65, 'date': '13 April 2024'},
    {'type': 'Debit', 'amount': 75, 'date': '13 April 2024'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
        color:  const Color.fromARGB(255, 232, 243, 235)
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
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
                              )
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new, size: 25),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Center(
                            child: Text(
                              "My Wallet",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 44), // to balance the row layout
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.account_balance_wallet, size: 40,color: Color.fromARGB(255, 68, 128, 106),),
                          Text("Your Balance Is", style:GoogleFonts.inter(fontSize: 13,fontWeight: FontWeight.bold)),
                          Text(
                            "₹$balance.00",
                            style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 246,139, 33),
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {},
                                child: const Text("Add Money"),
                              ),
                              const SizedBox(width: 10),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.orange,
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(color: Color.fromARGB(255, 246, 139, 33)),
                                ),
                                onPressed: () {},
                                child: const Text("Withdraw"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildTabButton('All'),
                        _buildTabButton('Credit'),
                        _buildTabButton('Debit'),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: transactions
                      .where((tx) => selectedTab == 'All' || tx['type'] == selectedTab)
                      .map((tx) => _buildTransactionTile(tx))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(String label) {
    bool isSelected = selectedTab == label;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton( 
        style: ElevatedButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : Colors.black,
          backgroundColor: isSelected ?  Color.fromARGB(255, 68, 128, 106) : Colors.white,
        ),
        onPressed: () {
          setState(() {
            selectedTab = label;
          });
        },
        child: Text(label),
      ),
    );
  }

  Widget _buildTransactionTile(Map<String, dynamic> tx) {
    bool isCredit = tx['type'] == 'Credit';
    return Card(
      child: ListTile(
        leading: Icon(
          isCredit ? Icons.call_received : Icons.call_made,
          color: const Color.fromARGB(255, 68, 128, 106),
        ),
        title: Text(
          isCredit ? 'Received From Shreya Goyal' : 'Paid to Shreya Goyal',
        ),
        subtitle: Text(tx['date']),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("₹${tx['amount']}", style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(isCredit ? 'Credited to' : 'Debited to')
          ],
        ),
      ),
    );
  }
}
