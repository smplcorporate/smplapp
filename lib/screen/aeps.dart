import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: AEPSWithdrawalScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class AEPSWithdrawalScreen extends StatefulWidget {
  @override
  _AEPSWithdrawalScreenState createState() => _AEPSWithdrawalScreenState();
}

class _AEPSWithdrawalScreenState extends State<AEPSWithdrawalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bankNameController = TextEditingController();
  final _aadhaarController = TextEditingController();
  final _amountController = TextEditingController();

  String? _selectedTransactionType;
  bool _isConfirmed = false;

  List<String> transactionTypes = [
    'Cash Withdrawal',
    'Balance Inquiry',
    'Mini Statement'
  ];

  void _submit() {
    if (_formKey.currentState!.validate() && _isConfirmed) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Success"),
          content: Text("AEPS Request Submitted"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    } else if (!_isConfirmed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please confirm the details are correct.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 232, 243, 235),
          elevation: 0,
          centerTitle: true,
          title: Text("AEPS Withdrawal", style: TextStyle(color: Colors.black)),
          leading: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text("AEPS", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text("Secure and instant cash withdrawals using your Aadhaar number."),
              SizedBox(height: 20),

              // Bank Name
              Text("Bank Name*", style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(height: 5),
              TextFormField(
                controller: _bankNameController,
                decoration: InputDecoration(border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? "Please enter bank name" : null,
              ),
              SizedBox(height: 20),

              // Transaction Type
              Text("Transaction Type*", style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(height: 5),
              DropdownButtonFormField<String>(
                value: _selectedTransactionType,
                items: transactionTypes
                    .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedTransactionType = value),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                icon: Icon(
                  Icons.arrow_drop_down,
                  size: 25, // Increased icon size
                  color: Colors.black,
                ),
                validator: (value) => value == null ? "Please select transaction type" : null,
              ),
              SizedBox(height: 20),

              // Aadhaar Number
              Text("Aadhaar Number*", style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(height: 5),
              TextFormField(
                controller: _aadhaarController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color.fromARGB(255, 228, 227, 227)))),
                keyboardType: TextInputType.number,
                maxLength: 12,
                validator: (value) => value!.isEmpty || value.length != 12
                    ? "Enter valid 12-digit Aadhaar number"
                    : null,
              ),
              SizedBox(height: 10),

              // Amount
              Text("Amount*", style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(height: 5),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  prefixText: "₹ ",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Please enter amount" : null,
              ),
              SizedBox(height: 20),

              // Checkbox
              Row(
                children: [
                  Theme(
                    data: ThemeData(unselectedWidgetColor: Colors.grey),
                    child: Checkbox(
                      value: _isConfirmed,
                      activeColor: const Color.fromARGB(255, 239, 235, 235),
                      checkColor: Color.fromARGB(255, 68, 128, 106),
                      onChanged: (val) => setState(() => _isConfirmed = val!),
                    ),
                  ),
                  Expanded(child: Text("I confirm the details provided are correct."))
                ],
              ),
              SizedBox(height: 140),

              // Submit Button
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Text("Scan Now", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
