import 'package:flutter/material.dart';
import 'package:home/screen/rechargebill3.dart';


void main() {
  runApp(MaterialApp(
    home: RechargePlansPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class RechargePlansPage extends StatelessWidget {
  final List<Map<String, String>> plans = [
    {
      'price': '₹199',
      'data': '1.5GB/day',
      'validity': '28 Days',
      'desc': 'Don\'t miss Recharge with Rs.249 Plan & get 20% upto Rs.200 cashback from Jio Mart'
    },
    {
      'price': '₹299',
      'data': '2GB/day',
      'validity': '28 Days',
      'desc': 'Don\'t miss Recharge with Rs.249 Plan & get 20% upto Rs.200 cashback from Jio Mart'
    },
    {
      'price': '₹499',
      'data': '1.5GB/day',
      'validity': '56 Days',
      'desc': 'Don\'t miss Recharge with Rs.249 Plan & get 20% upto Rs.200 cashback from Jio Mart'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 232, 243, 235),
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text('Recharge Bill', style: TextStyle(color: Colors.black)),
          ),
          backgroundColor: const Color.fromARGB(255, 232, 243, 235),
          elevation: 0,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey.shade300)],
              ),
              child: Center(
                child:    IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.black, size: 30),
                        SizedBox(width: 10),
                        Text("Search by Biller", style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ),
                TabBar(
                  indicatorColor: Colors.transparent,
                  isScrollable: true,
                  tabs: [
                    tabBox("Prepaid Recharge", 122),
                    tabBox("Postpaid Bill Payment", 142),
                    tabBox("Data Packs", 82),
                    tabBox("Top-up", 82),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: plans.length,
              itemBuilder: (context, index) {
                final plan = plans[index];
                final isSpecialPlan = plan['price'] == '₹199';

                final planWidget = Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plan['price']!,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Data: ${plan['data']}"),
                            Text("Validity: ${plan['validity']}"),
                          ],
                        ),
                        SizedBox(height: 6),
                        Text("Data: ${plan['data']}"),
                        Text("Voice: Unlimited"),
                        SizedBox(height: 8),
                        Text(
                          plan['desc']!,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                );

                // Wrap only ₹199 plan with GestureDetector
                return isSpecialPlan
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RechargePage3(),
                            ),
                          );
                        },
                        child: planWidget,
                      )
                    : planWidget;
              },
            ),
            Center(child: Text("Postpaid Bill Payment")),
            Center(child: Text("Data Packs")),
            Center(child: Text("Top-up")),
          ],
        ),
      ),
    );
  }

  Widget tabBox(String text, double width) {
    return Container(
      height: 35,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Tab(text: text),
    );
  }
}

